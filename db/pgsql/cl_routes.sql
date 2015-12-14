CREATE TABLE public.cl_routes (
  linkedid VARCHAR,
  dt TIMESTAMP WITHOUT TIME ZONE,
  src VARCHAR,
  dst VARCHAR,
  pos SMALLINT,
  duration TIME WITHOUT TIME ZONE
) 
WITH (oids = false);

CREATE INDEX cl_routes_idx_dst ON public.cl_routes
  USING btree (dst COLLATE pg_catalog."default");

CREATE INDEX cl_routes_idx_dt ON public.cl_routes
  USING btree (dt);

CREATE INDEX cl_routes_idx_duration ON public.cl_routes
  USING btree (duration);

CREATE INDEX cl_routes_idx_linkedid ON public.cl_routes
  USING btree (linkedid COLLATE pg_catalog."default");

CREATE INDEX cl_routes_idx_pos ON public.cl_routes
  USING btree (pos);

CREATE INDEX cl_routes_idx_src ON public.cl_routes
  USING btree (src COLLATE pg_catalog."default");

