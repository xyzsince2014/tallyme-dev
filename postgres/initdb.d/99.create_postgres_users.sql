-- AS user
create user as_user with password 'as_password';
revoke all on schema public from as_user;
grant usage on schema oauth to as_user;
grant all privileges on all tables in schema oauth to as_user;
grant all privileges on all sequences in schema oauth to as_user;

-- RP user
create user rp_user with password 'rp_password';
revoke all on schema oauth from rp_user;
grant usage on schema public to rp_user;
grant all privileges on all tables in schema public to rp_user;
grant all privileges on all sequences in schema public to rp_user;
