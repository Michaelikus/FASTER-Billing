CREATE TABLE public.cl (
  id SERIAL,
  linkedid VARCHAR,
  dt_begin TIMESTAMP WITHOUT TIME ZONE,
  dt_end TIMESTAMP WITHOUT TIME ZONE,
  src_cid VARCHAR,
  dst_cid VARCHAR,
  duration TIME WITHOUT TIME ZONE,
  waittime TIME WITHOUT TIME ZONE,
  speaktime TIME WITHOUT TIME ZONE,
  disposition VARCHAR,
  last_cid VARCHAR,
  first_cid VARCHAR,
  CONSTRAINT cl_pkey PRIMARY KEY(id)
) 
WITH (oids = false);

CREATE INDEX cl_idx_disposition ON public.cl
  USING btree (disposition COLLATE pg_catalog."default");

CREATE INDEX cl_idx_dst_cid ON public.cl
  USING btree (dst_cid COLLATE pg_catalog."default");

CREATE INDEX cl_idx_dt ON public.cl
  USING btree (dt_begin);

CREATE INDEX cl_idx_dt_end ON public.cl
  USING btree (dt_end);

CREATE INDEX cl_idx_duration ON public.cl
  USING btree (duration);

CREATE INDEX cl_idx_first_cid ON public.cl
  USING btree (first_cid COLLATE pg_catalog."default");

CREATE INDEX cl_idx_id ON public.cl
  USING btree (id);

CREATE INDEX cl_idx_last_cid ON public.cl
  USING btree (last_cid COLLATE pg_catalog."default");

CREATE INDEX cl_idx_linkedid ON public.cl
  USING btree (linkedid COLLATE pg_catalog."default");

CREATE INDEX cl_idx_speaktime ON public.cl
  USING btree (speaktime);

CREATE INDEX cl_idx_src_cid ON public.cl
  USING btree (src_cid COLLATE pg_catalog."default");

CREATE INDEX cl_idx_waittime ON public.cl
  USING btree (waittime);

CREATE TRIGGER cl_tr_parse_cel
  BEFORE INSERT 
  ON public.cl FOR EACH ROW 
  EXECUTE PROCEDURE public.tr_cel_parser();

ALTER TABLE public.cl
  DISABLE TRIGGER cl_tr_parse_cel;

