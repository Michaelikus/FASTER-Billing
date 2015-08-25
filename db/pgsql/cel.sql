CREATE TABLE public.cel (
  id INTEGER DEFAULT nextval('cel_id_seq1'::regclass) NOT NULL,
  eventtype VARCHAR(30) NOT NULL,
  eventtime TIMESTAMP WITHOUT TIME ZONE NOT NULL,
  userdeftype VARCHAR(255) NOT NULL,
  cid_name VARCHAR(80) NOT NULL,
  cid_num VARCHAR(80) NOT NULL,
  cid_ani VARCHAR(80) NOT NULL,
  cid_rdnis VARCHAR(80) NOT NULL,
  cid_dnid VARCHAR(80) NOT NULL,
  exten VARCHAR(80) NOT NULL,
  context VARCHAR(80) NOT NULL,
  channame VARCHAR(80) NOT NULL,
  appname VARCHAR(80) NOT NULL,
  appdata VARCHAR(80) NOT NULL,
  amaflags INTEGER NOT NULL,
  accountcode VARCHAR(20) NOT NULL,
  peeraccount VARCHAR(20) NOT NULL,
  uniqueid VARCHAR(150) NOT NULL,
  linkedid VARCHAR(150) NOT NULL,
  userfield VARCHAR(255) NOT NULL,
  peer VARCHAR(80) NOT NULL,
  CONSTRAINT "PK_cel_id" PRIMARY KEY(id)
) 
WITH (oids = false);

CREATE INDEX idx_cel_accountcode ON public.cel
  USING btree (accountcode COLLATE pg_catalog."default");

CREATE INDEX idx_cel_amaflags ON public.cel
  USING btree (amaflags);

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

CREATE UNIQUE INDEX idx_cel_id ON public.cel
  USING btree (id);

CREATE INDEX idx_cel_linkedid ON public.cel
  USING btree (linkedid COLLATE pg_catalog."default");

CREATE INDEX idx_cel_peer ON public.cel
  USING btree (peer COLLATE pg_catalog."default");

CREATE INDEX idx_cel_peeraccount ON public.cel
  USING btree (peeraccount COLLATE pg_catalog."default");

CREATE INDEX idx_cel_uniqueid ON public.cel
  USING btree (uniqueid COLLATE pg_catalog."default");

CREATE INDEX idx_cel_userdeftype ON public.cel
  USING btree (userdeftype COLLATE pg_catalog."default");

CREATE INDEX idx_cel_userfield ON public.cel
  USING btree (userfield COLLATE pg_catalog."default");
