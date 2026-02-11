create table if not exists oauth.t_resource (
  resource_id character varying(256) primary key
  , resource_secret character varying(256)
  , created_at timestamp not null default current_timestamp
  , updated_at timestamp not null default current_timestamp
);
