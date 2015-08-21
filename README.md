# FASTER-Billing
Free ASTERisk Billing \
Случилось так, что на новом месте мне пришлось погрузиться в тонкости учета звонков Asterisk. А так как политикой компании является лозунг "дешево и сердито", я решил взяться за эту интересную задачу сам.

Система основывается на обработке лога CEL(Channel Event Logs).

Первоочередные задачи:
1.   Обрабатывать входящие вызовы и складывать информацию о них для последующего использования.
1.1. Отслеживать маршрут прохождения входящего с момента его поступления до разрыва соединения.
2.   Построение отчетов по группам входящих вызовов(на основе очередей, или queues)
3.   
Почему я пришёл именно к решению четер CEL, объяснять долго и нудно. Возможно, когда появится время, расскажу. А пока сфокусируемся на предмете.

Итак, 
#Таблица CEL
В документации по астериску имеется ее структура и поверхностное описание. https://wiki.asterisk.org/wiki/pages/viewpage.action?pageId=5242932
В качестве площадки для хранения буду использовать PgSQL(http://www.postgresql.org) Толко не спрашивайте, почему.

Попробуем разобраться.

Структура таблицы(https://wiki.asterisk.org/wiki/display/AST/PostgreSQL+CEL+Backend):
id serial , 
eventtype varchar (30) NOT NULL ,
eventtime timestamp NOT NULL ,
userdeftype varchar(255) NOT NULL ,
cid_name varchar (80) NOT NULL , 
cid_num varchar (80) NOT NULL ,
cid_ani varchar (80) NOT NULL , 
cid_rdnis varchar (80) NOT NULL ,
cid_dnid varchar (80) NOT NULL ,
exten varchar (80) NOT NULL ,
context varchar (80) NOT NULL , 
channame varchar (80) NOT NULL ,
appname varchar (80) NOT NULL ,
appdata varchar (80) NOT NULL , 
amaflags int NOT NULL ,
accountcode varchar (20) NOT NULL ,
peeraccount varchar (20) NOT NULL ,
uniqueid varchar (150) NOT NULL ,
linkedid varchar (150) NOT NULL , 
userfield varchar (255) NOT NULL ,
peer varchar (80) NOT NULL 

Грабли №1.
Настроим PgSQL так, чтоб он логировал некорректные запросы. Позже расскажу для чего.
