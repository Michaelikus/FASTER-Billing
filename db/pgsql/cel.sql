CREATE TABLE public.cel (
  id INTEGER DEFAULT nextval('cel_id_seq2'::regclass) NOT NULL,
  eventtype VARCHAR NOT NULL,
  eventtime TIMESTAMP WITHOUT TIME ZONE NOT NULL,
  userdeftype VARCHAR NOT NULL,
  cid_name VARCHAR NOT NULL,
  cid_num VARCHAR NOT NULL,
  cid_ani VARCHAR NOT NULL,
  cid_rdnis VARCHAR NOT NULL,
  cid_dnid VARCHAR NOT NULL,
  exten VARCHAR NOT NULL,
  context VARCHAR NOT NULL,
  channame VARCHAR NOT NULL,
  appname VARCHAR NOT NULL,
  appdata VARCHAR NOT NULL,
  amaflags INTEGER NOT NULL,
  accountcode VARCHAR NOT NULL,
  peeraccount VARCHAR NOT NULL,
  uniqueid VARCHAR NOT NULL,
  linkedid VARCHAR NOT NULL,
  userfield VARCHAR NOT NULL,
  peer VARCHAR NOT NULL
) 
WITH (oids = false);

CREATE INDEX idx_cel_accountcode ON public.cel
  USING btree (accountcode COLLATE pg_catalog."default");

CREATE INDEX idx_cel_appdata ON public.cel
  USING btree (appdata COLLATE pg_catalog."default");

CREATE INDEX idx_cel_appname ON public.cel
  USING btree (appname COLLATE pg_catalog."default");

CREATE INDEX idx_cel_channame ON public.cel
  USING btree (channame COLLATE pg_catalog."default");

CREATE INDEX idx_cel_cid_ani ON public.cel
  USING btree (cid_ani COLLATE pg_catalog."default");

CREATE INDEX idx_cel_cid_dnid ON public.cel
  USING btree (cid_dnid COLLATE pg_catalog."default");

CREATE INDEX idx_cel_cid_name ON public.cel
  USING btree (cid_name COLLATE pg_catalog."default");

CREATE INDEX idx_cel_cid_num ON public.cel
  USING btree (cid_num COLLATE pg_catalog."default");

CREATE INDEX idx_cel_cid_rdnis ON public.cel
  USING btree (cid_rdnis COLLATE pg_catalog."default");

CREATE INDEX idx_cel_context ON public.cel
  USING btree (context COLLATE pg_catalog."default");

CREATE INDEX idx_cel_eventtime ON public.cel
  USING btree (eventtime);

CREATE INDEX idx_cel_eventtype ON public.cel
  USING btree (eventtype COLLATE pg_catalog."default");

CREATE INDEX idx_cel_exten ON public.cel
  USING btree (exten COLLATE pg_catalog."default");

CREATE INDEX idx_cel_linkedid ON public.cel
  USING btree (linkedid COLLATE pg_catalog."default");

CREATE INDEX idx_cel_peer ON public.cel
  USING btree (peer COLLATE pg_catalog."default");

CREATE INDEX idx_cel_peeraccount ON public.cel
  USING btree (peeraccount COLLATE pg_catalog."default");

CREATE INDEX idx_cel_uniqueid ON public.cel
  USING btree (uniqueid COLLATE pg_catalog."default");

CREATE UNIQUE INDEX idx_celid ON public.cel
  USING btree (id);

CREATE TRIGGER cel_tr01
  AFTER INSERT 
  ON public.cel FOR EACH ROW 
  EXECUTE PROCEDURE public."CEL_TRIGGER01"();

