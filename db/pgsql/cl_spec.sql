CREATE TABLE public.cl_spec (
  id BIGINT,
  linkedid VARCHAR,
  uniqueid VARCHAR,
  dt TIMESTAMP WITHOUT TIME ZONE,
  cid VARCHAR,
  disposition VARCHAR
) 
WITH (oids = false);

CREATE INDEX cl_spec_idx_1 ON public.cl_spec
  USING btree (linkedid COLLATE pg_catalog."default", dt, cid COLLATE pg_catalog."default");

CREATE INDEX cl_spec_idx_cid ON public.cl_spec
  USING btree (cid COLLATE pg_catalog."default");

CREATE INDEX cl_spec_idx_dt ON public.cl_spec
  USING btree (dt);

CREATE INDEX cl_spec_idx_linkedid ON public.cl_spec
  USING btree (linkedid COLLATE pg_catalog."default");

CREATE INDEX cl_spec_idx_uniqueid ON public.cl_spec
  USING btree (uniqueid COLLATE pg_catalog."default");
