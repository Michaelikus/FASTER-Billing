CREATE TABLE public.pbx_ext (
  ext VARCHAR NOT NULL,
  descr VARCHAR,
  grp VARCHAR,
  ext_type VARCHAR,
  CONSTRAINT pbx_ext_idx_ext_uniq UNIQUE(ext)
) 
WITH (oids = false);

CREATE INDEX pbx_ext_idx_descr ON public.pbx_ext
  USING btree (descr COLLATE pg_catalog."default");

CREATE INDEX pbx_ext_idx_ext ON public.pbx_ext
  USING btree (ext COLLATE pg_catalog."default");

CREATE INDEX pbx_ext_idx_ext_type ON public.pbx_ext
  USING btree (ext_type COLLATE pg_catalog."default");

CREATE INDEX pbx_ext_idx_grp ON public.pbx_ext
  USING btree (grp COLLATE pg_catalog."default");

