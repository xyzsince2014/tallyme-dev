-- dev_user
create user dev_user with password 'dev_password';

grant connect on database tallyme to dev_user;

grant usage on schema public to dev_user;
grant select, insert, update, delete on all tables in schema public to dev_user;

grant usage, select, update on all sequences in schema public to dev_user;

alter default privileges in schema public grant select, insert, update, delete on tables to dev_user;
alter default privileges in schema public grant usage, select, update on sequences to dev_user;
