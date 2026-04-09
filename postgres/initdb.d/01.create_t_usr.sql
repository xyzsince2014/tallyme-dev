create table if not exists t_usr (
  sub character varying(256) primary key
  , name character varying(256)
  , family_name character varying(256)
  , given_name character varying(256)
  , middle_name character varying(256)
  , nickname character varying(256)
  , preferred_username character varying(256)
  , profile character varying(256)
  , picture character varying(256)
  , website character varying(256)
  , zoneinfo character varying(256)
  , locale character varying(256)
  , password character varying(256)
  , email character varying(256) unique
  , email_verified boolean not null default false
  , address character varying(256)
  , phone character varying(256)
  , phone_number_verified boolean not null default false
  , scope character varying(256)
  , role character varying(16) not null default 'USER'
  , created_at timestamp without time zone not null default current_timestamp
  , updated_at timestamp without time zone not null default current_timestamp
);
