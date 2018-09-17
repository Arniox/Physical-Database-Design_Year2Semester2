/*Table Creation*/
DROP TABLESPACE branch_table_space INCLUDING CONTENTS AND DATAFILES;
DROP TABLESPACE customer_table_space INCLUDING CONTENTS AND DATAFILES;
DROP TABLESPACE invoice_table_space INCLUDING CONTENTS AND DATAFILES;
DROP TABLESPACE reservation_table_space INCLUDING CONTENTS AND DATAFILES;
DROP TABLESPACE room_table_space INCLUDING CONTENTS AND DATAFILES;


CREATE TABLESPACE branch_table_space
DATAFILE '/usr/local/apps/oracle/oradata/ldb30/bjy5305_branchTableSpace.dat'
SIZE 81K AUTOEXTEND ON;

CREATE TABLESPACE customer_table_space
DATAFILE '/usr/local/apps/oracle/oradata/ldb30/bjy5305_customerTableSpace.dat'
SIZE 3M AUTOEXTEND ON;

CREATE TABLESPACE invoice_table_space
DATAFILE '/usr/local/apps/oracle/oradata/ldb30/bjy5305_invoiceTableSpace.dat'
SIZE 81K AUTOEXTEND ON;

CREATE TABLESPACE reservation_table_space
DATAFILE '/usr/local/apps/oracle/oradata/ldb30/bjy5305_reservationTableSpace.dat'
SIZE 158K AUTOEXTEND ON;

CREATE TABLESPACE room_table_space
DATAFILE '/usr/local/apps/oracle/oradata/ldb30/bjy5305_roomTableSpace.dat'
SIZE 405K AUTOEXTEND ON;


/*Move Tables to table spaces*/
