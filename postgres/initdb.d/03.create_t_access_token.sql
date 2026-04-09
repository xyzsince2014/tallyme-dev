create table if not exists t_access_token (
  access_token character varying(2048) primary key
  , refresh_token character varying(2048)
  , created_at timestamp not null default current_timestamp
  , updated_at timestamp not null default current_timestamp
  , constraint fk_refresh_token foreign key (refresh_token) references t_refresh_token(refresh_token) on delete cascade
);
