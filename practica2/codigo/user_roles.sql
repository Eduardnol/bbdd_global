USE f1;



CREATE ROLE 'analytic_user', 'manage_user', 'rrhh_user';

DROP ROLE analytic_userm, manage_user, rrhh_user;

GRANT SELECT, CREATE VIEW, SHOW VIEW on 'f1' to 'analytic_user';

GRANT CREATE USER ON 'rrhh_user';



