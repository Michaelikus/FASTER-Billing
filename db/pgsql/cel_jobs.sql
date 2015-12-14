CREATE TABLE public.cel_jobs (
  id SERIAL,
  dt TIMESTAMP WITHOUT TIME ZONE DEFAULT now(),
  linkedid VARCHAR,
  event VARCHAR,
  descr VARCHAR
) 
WITH (oids = false);

CREATE INDEX cel_jobs_idx_descr ON public.cel_jobs
  USING btree (descr COLLATE pg_catalog."default");

CREATE INDEX cel_jobs_idx_dt ON public.cel_jobs
  USING btree (dt);

CREATE INDEX cel_jobs_idx_event ON public.cel_jobs
  USING btree (event COLLATE pg_catalog."default");

CREATE INDEX cel_jobs_idx_linkedid ON public.cel_jobs
  USING btree (linkedid COLLATE pg_catalog."default");

