BEGIN
  FOR i IN 1 .. 5 LOOP
    DELETE FROM invoice_table
    WHERE res_id = i;
  END LOOP;

  FOR i IN 1 .. 5 LOOP
    INSERT INTO invoice_table (res_id, room_id, cust_fname, cust_lname, price, days_stayed, bill)
    VALUES(i,
        (SELECT room_id FROM reservation_table WHERE res_id = i), 
        (SELECT cust_fname FROM reservation_table WHERE res_id = i),
        (SELECT cust_lname FROM reservation_table WHERE res_id = i),
        (SELECT price FROM room_table WHERE room_id = 123),
        (SELECT (end_date-start_date) 
          FROM reservation_table 
          WHERE res_id = i),
        (SELECT (roo.price*(res.end_date-res.start_date))
          FROM room_table roo, reservation_table res
          WHERE roo.room_id = (SELECT room_id FROM reservation_table WHERE res_id = i) AND res.res_id = i));
  END LOOP;
END;