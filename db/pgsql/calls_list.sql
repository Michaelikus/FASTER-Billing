CREATE TABLE public.calls_list (
  id SERIAL,
  linkedid VARCHAR,
  dt_begin TIMESTAMP(0) WITHOUT TIME ZONE,
  dt_end TIMESTAMP(0) WITHOUT TIME ZONE,
  src_cid VARCHAR,
  dst_cid VARCHAR,
  dst_ext VARCHAR,
  s_channel VARCHAR,
  d_channel VARCHAR,
  duration TIME(0) WITHOUT TIME ZONE,
  waittime TIME(0) WITHOUT TIME ZONE,
  speaktime TIME(0) WITHOUT TIME ZONE,
  disposition VARCHAR,
  routes INTEGER,
  redirected NUMERIC(2,0),
  CONSTRAINT calls_list_pkey PRIMARY KEY(id)
) 
WITH (oids = false);

CREATE INDEX idx_calls_list_d_channel ON public.calls_list
  USING btree (d_channel COLLATE pg_catalog."default");

CREATE INDEX idx_calls_list_disposition ON public.calls_list
  USING btree (disposition COLLATE pg_catalog."default");

CREATE INDEX idx_calls_list_dst_cid ON public.calls_list
  USING btree (dst_cid COLLATE pg_catalog."default");

CREATE INDEX idx_calls_list_dst_ext ON public.calls_list
  USING btree (dst_ext COLLATE pg_catalog."default");

CREATE INDEX idx_calls_list_dt ON public.calls_list
  USING btree (dt_begin);

CREATE INDEX idx_calls_list_dt_end ON public.calls_list
  USING btree (dt_end);

CREATE INDEX idx_calls_list_duration ON public.calls_list
  USING btree (duration);

CREATE INDEX idx_calls_list_id ON public.calls_list
  USING btree (id);

CREATE INDEX idx_calls_list_linkedid ON public.calls_list
  USING btree (linkedid COLLATE pg_catalog."default");

CREATE INDEX idx_calls_list_redirected ON public.calls_list
  USING btree (redirected);

CREATE INDEX idx_calls_list_routes ON public.calls_list
  USING btree (routes);

CREATE INDEX idx_calls_list_s_channel ON public.calls_list
  USING btree (s_channel COLLATE pg_catalog."default");

CREATE INDEX idx_calls_list_speaktime ON public.calls_list
  USING btree (speaktime);

CREATE INDEX idx_calls_list_src_cid ON public.calls_list
  USING btree (src_cid COLLATE pg_catalog."default");

CREATE INDEX idx_calls_list_waittime ON public.calls_list
  USING btree (waittime);

CREATE TRIGGER calls_list_tr_parse_cel
  BEFORE INSERT 
  ON public.calls_list FOR EACH ROW 
  EXECUTE PROCEDURE public.tr_cel_parser();

ALTER TABLE public.calls_list
  DISABLE TRIGGER calls_list_tr_parse_cel;
