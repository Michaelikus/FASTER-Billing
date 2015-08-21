CREATE OR REPLACE FUNCTION public.process_cel001 (
)
RETURNS void AS
$body$
DECLARE
    --записи для обработки табличных строк
    current				record;
    rec003				record;
    
	CallBegin			cel%rowtype;
    cel_row				cel%rowtype;

	-- 
    ChanID				cel.linkedid%type;
    ChanStart			cel.eventtime%type;
    ChanEnd				cel.eventtime%type;
	CallerID			cel.cid_num%type;

	-- cel fields
	CallDisposition		calls_list.disposition%type;
    FirstAnswer			cel.cid_num%type;

    CallStart			cel.eventtime%type;
    CallEnd				cel.eventtime%type;
    

    --
	TotalRedirects		numeric;
    
BEGIN
	truncate calls_list;
    truncate calls_routes;


	--	вытаскиваем из cel только те linkedid, сессия по котормы закрыта, т.е. eventtype = 'LINKEDID_END'
	for current in 
		select distinct linkedid from cel where eventtype = 'LINKEDID_END'
    loop
	    CallDisposition := 'TROLOLO';
        TotalRedirects	:= 0;

    	/*
        Теперь нам нужно событие(оно всегда первое в общем списке) открывающее текущую сессию, чтоб проверить входящий это вызов или нет
        */  
        select * into CallBegin from cel where id IN( select min(id) from cel where linkedid = current.linkedid);
        
        case callbegin.context
        when 'from-pstn' then
        -- Разбор вызова по алгоритму как входящий
		
        	-- Достаем начало и конец вызова, чтоб подсчитать продолжительность(будет очень востребовано для звонков на 8-800)
        	CallStart := CallBegin.eventtime;
			select eventtime into CallEnd   from cel where linkedid = current.linkedid and eventtype='LINKEDID_END';

			-- Формируем заголовок (calls_list)
			insert into calls_list(linkedid, dt_begin, dt_end, src_cid, dst_cid) values(CallBegin.linkedid, CallBegin.eventtime, CallEnd, CallBegin.cid_num, CallBegin.exten);
            --select linkedid, eventtime, cid_num, exten from cel where uniqueid = current.linkedid and eventtype = 'CHAN_START' and context = 'from-pstn';

			select * into cel_row from cel where cel.eventtype='BRIDGE_START' and cel.context = 'ext-queues' and cel.uniqueid = current.linkedid;
            IF NOT FOUND THEN
                -- Если бридж не открыт, значит звонка не было
                -- На всякий случай запишем номер до которого не дозвонились, если был таковой.
				
                update calls_list set dst_ext = (select ext from cel where uniqueid = current.linkedid and eventtype = 'ANSWER') where calls_list.linkedid = current.linkedid;
                CallDisposition := 'UNANSWERED';
            ELSE
                -- А если бридж открыт, вот тут начинается %*?:%
                CallDisposition := 'ANSWERED';

                -- Добавляем в заголовок номер, на который пришёл вызов
                update calls_list set dst_ext = cel_row.exten where calls_list.linkedid = current.linkedid;


                -- Запомним ключевые параметры канала данного звонка
                
                select eventtime into ChanStart   from cel where cel.eventtype='BRIDGE_START' and cel.context  = 'ext-queues' and cel.uniqueid = current.linkedid;
                select eventtime into ChanEnd     from cel where cel.eventtype='LINKEDID_END' and cel.uniqueid = current.linkedid;
                select exten     into FirstAnswer from cel WHERE cel.eventtype='CHAN_START'   and cel.channame = cel_row.peer;
                
                -- Разберем основной заголовок(linkedid = uniqueid) и запишем начальные маршруты:
                -- звонящий		>>>	наш номер
                -- наш номер	>>>	группа
                -- группа		>>>	принимающий номер

                --insert into calls_routes(linkedid, uniqueid, dt, src,dst) values(cel_row.linkedid, cel_row.uniqueid, cel_row.eventtime, cel_row.cid_num, cel_row.cid_dnid);
                insert into calls_routes(linkedid, uniqueid, dt, src,dst) select linkedid, uniqueid, eventtime, cid_num, exten from cel where uniqueid = current.linkedid and eventtype = 'CHAN_START' and context = 'from-pstn';
                insert into calls_routes(linkedid, uniqueid, dt, src,dst) values(cel_row.linkedid, cel_row.uniqueid, cel_row.eventtime, cel_row.cid_dnid, cel_row.exten);
                insert into calls_routes(linkedid, uniqueid, dt, src,dst) values(cel_row.linkedid, cel_row.uniqueid, cel_row.eventtime, cel_row.exten,FirstAnswer);
                


                for rec003 in select * from cel WHERE linkedid = ChanID and eventtype = 'HANGUP' and length(cid_ani) > 2 and length(cid_dnid) > 2 and cid_ani != cel_row.cid_num order by eventtime asc
                loop
                    insert into calls_routes(linkedid, uniqueid, dt, src,dst) 
                        values(rec003.linkedid, rec003.uniqueid, rec003.eventtime, rec003.cid_ani, rec003.cid_dnid);
                        TotalRedirects := TotalRedirects + 1;
                end loop;
                UPDATE calls_list set redirected = TotalRedirects where linkedid = ChanID;
                
            END IF;

            -- Заполним поле статуса звонка(ответили/не ответили)
            update calls_list set disposition = CallDisposition where linkedid = current.linkedid;


        -- END from-pstn
        end case;

	end loop; -- linkedid_end


END;
$body$
LANGUAGE 'plpgsql'
VOLATILE
CALLED ON NULL INPUT
SECURITY INVOKER
COST 100;


