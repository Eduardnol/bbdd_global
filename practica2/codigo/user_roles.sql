USE f1;


DROP USER IF EXISTS analytic_userm;
DROP USER IF EXISTS manage_user;
DROP USER IF EXISTS rrhh_user;

CREATE USER 'analytic_user'@'localhost', 'manager_user'@'localhost', 'rrhh_user'@'localhost';

GRANT SELECT, CREATE VIEW, SHOW VIEW ON f1_olap.* to 'analytic_user'@'localhost';

GRANT SELECT, INSERT, UPDATE, USAGE, DELETE ON f1.* to 'manager_user'@'localhost';

GRANT CREATE USER ON *.* TO 'rrhh_user'@'localhost';




