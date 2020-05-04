



CREATE ROLE 'analytic_user', 'manage_user', 'rrhh_user';

GRANT SELECT, CREATE VIEW, SHOW VIEW on 'analytic_user';

GRANT CREATE USER ON 'rrhh_user';

