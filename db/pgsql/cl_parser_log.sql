CREATE TABLE public.cl_parser_log (
  id SERIAL,
  dt TIMESTAMP WITHOUT TIME ZONE DEFAULT now(),
  linkedid VARCHAR,
  comment VARCHAR,
  uniqueid VARCHAR
) 
WITH (oids = false);
