-- oauth_user
create user oauth_user with password 'oauth_password';

grant connect on database oauth to oauth_user;

grant usage on schema public to oauth_user;
grant select, insert, update, delete on all tables in schema public to oauth_user;

grant usage, select, update on all sequences in schema public to oauth_user;

alter default privileges in schema public grant select, insert, update, delete on tables to oauth_user;
alter default privileges in schema public grant usage, select, update on sequences to oauth_user;
