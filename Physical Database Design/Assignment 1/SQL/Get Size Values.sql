SELECT TYPE, TYPE_SIZE
FROM V$TYPE_SIZE
WHERE TYPE = 'KDBT';

SELECT NAME, VALUE
FROM V$PARAMETER
WHERE NAME = 'db_block_size';

SELECT NAME, VALUE
FROM V$PARAMETER;

SELECT VSIZE(branch_id),
       VSIZE (branch_name), 
       VSIZE (branch_city), 
       VSIZE (branch_email), 
       VSIZE (branch_phone), 
       VSIZE (branch_address)
FROM BRANCH_TABLE;