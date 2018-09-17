ALTER TABLE reservation_table
MODIFY cust_fname Varchar2(20)
MODIFY cust_lname Varchar2(20)
MODIFY room_type Varchar2(10);

INSERT INTO invoice_table(res_id, room_id, cust_fname, cust_lname, price, days_stayed, bill)
VALUES(5, 12544, 'Katty', 'Pa\erry', 123, 5, (5*123));

SELECT VSIZE(start_date), VSIZE(end_date)
FROM reservation_table;

/*UPDATE customer_table
SET cust_homephone = 098878787,
    cust_mobilephone = 02102485838,
    cust_email = 'Katty@gmail.com'
WHERE cust_fname = 'Katty';
*/

DELETE FROM invoice_table
WHERE res_id = 5;
