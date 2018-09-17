CREATE OR REPLACE TRIGGER newInvoiceTrigger
AFTER INSERT ON reservation_table
DECLARE
    C_ResID reservation_table.res_id%TYPE;
    C_CustFirstName reservation_table.cust_fname%TYPE;
    C_CustLastName reservation_table.cust_lname%TYPE;
    C_RoomID reservation_table.room_id%TYPE;
    C_StartDate reservation_table.start_date%TYPE;
    C_EndDate reservation_table.end_date%TYPE;
    C_Price room_table.price%TYPE;
    
    reservation_size_count Number;
    
BEGIN
    /*Get size of reservation table*/
    SELECT MAX(res_id) INTO reservation_size_count
    FROM reservation_table;

    /*Fill room values*/
    SELECT price INTO C_Price
    FROM room_table roo, reservation_table res
    WHERE res.room_id = roo.room_id
      AND res.res_id = reservation_size_count;
    
    /*Fill other values*/
    SELECT res_id,
           cust_fname,
           cust_lname, 
           room_id, 
           start_date, 
           end_date INTO C_ResID,
                             C_CustFirstName, 
                             C_CustLastName, 
                             C_RoomID,
                             C_StartDate,
                             C_EndDate
    FROM reservation_table
    WHERE res_id = reservation_size_count;


    INSERT INTO invoice_table(res_id, room_id, cust_fname, cust_lname, price, days_stayed, bill)
    VALUES(C_ResID, C_RoomID, C_CustFirstName, C_CustLastName, C_Price,
           (C_EndDate-C_StartDate),
           ((C_EndDate-C_StartDate)*C_Price));
           
    dbms_output.put_line('Inserted invoice. Reservation ID: '||
                          C_ResID||', Room ID: '||C_RoomID||' for '||
                          C_CustFirstName||' '||C_CustLastName||'. Cost is '||
                          C_Price||' per day. Youre staying '||(C_EndDate-C_StartDate)||' days which comes to a total cost of: $'||
                          ((C_EndDate-C_StartDate)*C_Price)||'. Please enjoy your stay');
    
    COMMIT;
    
END;
/