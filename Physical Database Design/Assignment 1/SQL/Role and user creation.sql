/*Creating Profiles*/
DROP PROFILE bjy5305_AProfile;
DROP PROFILE bjy5305_DProfile;

CREATE PROFILE bjy5305_AProfile LIMIT
SESSIONS_PER_USER UNLIMITED
CPU_PER_SESSION UNLIMITED
CPU_PER_CALL UNLIMITED
IDLE_TIME 20
CONNECT_TIME UNLIMITED
FAILED_LOGIN_ATTEMPTS 3
PASSWORD_LOCK_TIME 0.04
PASSWORD_LIFE_TIME 91 /*Each Yearly Quarter*/
PASSWORD_GRACE_TIME 5; /*5 Days to change your password*/

CREATE PROFILE bjy5305_DProfile LIMIT
SESSIONS_PER_USER 2
CPU_PER_SESSION 180000 /*30 minutes*/
CPU_PER_CALL 2000 /*20 seconds*/
IDLE_TIME 5
CONNECT_TIME 30
FAILED_LOGIN_ATTEMPTS 5
PASSWORD_LOCK_TIME 0.04
PASSWORD_LIFE_TIME 91 /*Each Yearly Quarter*/
PASSWORD_GRACE_TIME 5; /*5 Days to change your password*/


/*Creating Roles*/
DROP ROLE bjy5305_ARole;
DROP ROLE Bjy5305_DRole;

CREATE ROLE bjy5305_ARole
IDENTIFIED BY AdmnLoginUni;
CREATE ROLE Bjy5305_DRole
IDENTIFIED BY DevAUTUni;

/*Granting Roles perms to DBAdmin*/
GRANT ALL PRIVILEGES TO bjy5305_ARole;
/*Granting Roles perms to Developer*/
GRANT SELECT,
      INSERT,
      UPDATE ON branch_table TO Bjy5305_DRole;
GRANT SELECT ON customer_table TO Bjy5305_DRole;
GRANT SELECT ON reservation_table TO Bjy5305_DRole;
GRANT SELECT,
      INSERT,
      UPDATE ON room_table TO Bjy5305_DRole;
GRANT create procedure,
      create any procedure,
      alter any procedure,
      drop any procedure,
      execute any procedure,
      create any index,
      alter any index,
      drop any index,
      create session,
      create sequence,
      create any sequence,
      alter any sequence,
      drop any sequence,
      select any sequence,
      create table,
      comment any table,
      create trigger,
      create any trigger,
      alter any trigger,
      drop any trigger,
      create view,
      create any view,
      drop any view
      TO Bjy5305_DRole;
      

/*Creating Users*/
DROP USER bjy5305_DBAdmin;
DROP USER bjy5305_Developer;

CREATE USER bjy5305_DBAdmin
IDENTIFIED BY PAssword
DEFAULT TABLESPACE branch_table_space
QUOTA UNLIMITED ON branch_table_space
QUOTA UNLIMITED ON customer_table_space
QUOTA UNLIMITED ON invoice_table_space
QUOTA UNLIMITED ON reservation_table_space
QUOTA UNLIMITED ON room_table_space;

CREATE USER bjy5305_Developer
IDENTIFIED BY PAssword
DEFAULT TABLESPACE branch_table_space
QUOTA UNLIMITED ON branch_table_space
QUOTA UNLIMITED ON customer_table_space
QUOTA UNLIMITED ON invoice_table_space
QUOTA UNLIMITED ON reservation_table_space
QUOTA UNLIMITED ON room_table_space;

GRANT bjy5305_ARole TO bjy5305_DBAdmin;
GRANT Bjy5305_DRole TO bjy5305_Developer;
