DECLARE
  numberOfInvoices Number;
  numberOfReservations Number;
  numberOfRooms Number;
  numberOfCustomers Number;
  numberOfBranches Number;
BEGIN
  SELECT count(*) INTO numberOfInvoices
  FROM invoice_table;
  SELECT count(*) INTO numberOfReservations
  FROM reservation_table;
  SELECT count(*) INTO numberOfRooms
  FROM room_table;
  SELECT count(*) INTO numberOfCustomers
  FROM customer_table;
  SELECT count(*) INTO numberOfBranches
  FROM branch_table;
  

  
/*Deleting in order in seperate loops so child dependencies don't break*/
  FOR i IN 1 .. numberOfInvoices LOOP
    DELETE FROM invoice_table
    WHERE res_id = i;
  END LOOP;
  FOR i IN 1 .. numberOfReservations LOOP
    DELETE FROM reservation_table
    WHERE res_id = i;
  END LOOP;
  FOR i IN 1 .. numberOfRooms LOOP
    DELETE FROM room_table
    WHERE room_id = i;
  END LOOP;
  FOR i IN 1 .. numberOfCustomers LOOP
    DELETE FROM customer_table
    WHERE cust_id = i;
  END LOOP;
  FOR i IN 1 .. numberOfBranches LOOP
    DELETE FROM branch_table
    WHERE branch_id = i;
  END LOOP;
  
/*Inserting all the data*/
  INSERT INTO branch_table (branch_id, branch_name, branch_city, branch_email, branch_phone, branch_address)
  VALUES(1, 'A-Hotels', 'Auckland', 'hotelAuck@gmail.com', 098775667, '231, Pukeiti Rd');
  INSERT INTO branch_table (branch_id, branch_name, branch_city, branch_email, branch_phone, branch_address)
  VALUES(2, 'Church Hotels', 'Christchurch', 'hotelChurch@gmail.com', 098775666, '135, Hawdon St');
  INSERT INTO branch_table (branch_id, branch_name, branch_city, branch_email, branch_phone, branch_address)
  VALUES(3, 'Rocky Hotels', 'Rotorua', 'hotelRot@gmail.com', 098775665, '15, McKenzie Rd');
  INSERT INTO branch_table (branch_id, branch_name, branch_city, branch_email, branch_phone, branch_address)
  VALUES(4, 'Windy Hotels', 'Wellington', 'hotelWell@gmail.com', 098775664, '115, Fiona Grove');
  INSERT INTO branch_table (branch_id, branch_name, branch_city, branch_email, branch_phone, branch_address)
  VALUES(5, 'Lower Hut', 'Invercargill', 'hotelInv@gmail.com', 098775663, '177, Preston Street');
  
  INSERT INTO customer_table (cust_id, cust_fname, cust_lname, cust_address, cust_homephone, cust_mobilephone, cust_email, cust_fax)
  VALUES(1, 'Eleanor', 'Alcaraz', '57, Webster Ave', 0261508439, 273569256, 'EA@gmail.com', null);
  INSERT INTO customer_table (cust_id, cust_fname, cust_lname, cust_address, cust_homephone, cust_mobilephone, cust_email, cust_fax)
  VALUES(2, 'Harry', 'Potter', '9-3/4 Place Ave', 23423454, 23234234, 'harryPotterWizard@gmail.com', null);
  INSERT INTO customer_table (cust_id, cust_fname, cust_lname, cust_address, cust_homephone, cust_mobilephone, cust_email, cust_fax)
  VALUES(3, 'Johnn', 'Pwertwy', '8th Bonnerstine Place', 234234234, 234234266, 'magicmagickek@gmail.com', null);
  INSERT INTO customer_table (cust_id, cust_fname, cust_lname, cust_address, cust_homephone, cust_mobilephone, cust_email, cust_fax)
  VALUES(4, 'Katty', 'Lola', '6th Maori Rd', 21342344, 123123333, 'Aeoteroa@gmail.com', null);
  INSERT INTO customer_table (cust_id, cust_fname, cust_lname, cust_address, cust_homephone, cust_mobilephone, cust_email, cust_fax)
  VALUES(5, 'Terry', 'Utan', '5930 Jackson Rd', 2342344, 55556566, 'Utanterry@gmail.com', null);
  
  INSERT INTO room_table (room_id, branch_id, room_type, room_desc, bathroom_count, bed_count, price)
  VALUES(1, 5, 'PENTHOUSE', 'Great room with stunning vista', 3, 3, 98);
  INSERT INTO room_table (room_id, branch_id, room_type, room_desc, bathroom_count, bed_count, price)
  VALUES(2, 4, 'KING', 'Honeymoon Room suited for kings', 2, 4, 67);
  INSERT INTO room_table (room_id, branch_id, room_type, room_desc, bathroom_count, bed_count, price)
  VALUES(3, 2, 'SMALL', 'A small quiet place to stay', 1, 1, 25);
  INSERT INTO room_table (room_id, branch_id, room_type, room_desc, bathroom_count, bed_count, price)
  VALUES(4, 3, 'QUEEN', 'View of the ocean', 2, 2, 45);
  INSERT INTO room_table (room_id, branch_id, room_type, room_desc, bathroom_count, bed_count, price)
  VALUES(5, 4, 'PENTHOUSE', 'Increadable view of the ocean', 2, 4, 105);
  INSERT INTO room_table (room_id, branch_id, room_type, room_desc, bathroom_count, bed_count, price)
  VALUES(6, 1, 'SMALL', 'Small window room', 1, 1, 23);
  INSERT INTO room_table (room_id, branch_id, room_type, room_desc, bathroom_count, bed_count, price)
  VALUES(7, 1, 'SMALL', 'No windows, simply a room', 1, 1, 14);
  INSERT INTO room_table (room_id, branch_id, room_type, room_desc, bathroom_count, bed_count, price)
  VALUES(8, 1, 'LARGE', 'Large deck that opens out to wellington', 2, 2, 56);
  INSERT INTO room_table (room_id, branch_id, room_type, room_desc, bathroom_count, bed_count, price)
  VALUES(9, 2, 'SMALL', 'Christchurchs best room for cheap', 1, 1, 10);
  INSERT INTO room_table (room_id, branch_id, room_type, room_desc, bathroom_count, bed_count, price)
  VALUES(10, 3, 'MEDIUM', 'Increadable view of Whakapapa Ski fields', 1, 3, 45);
  INSERT INTO room_table (room_id, branch_id, room_type, room_desc, bathroom_count, bed_count, price)
  VALUES(11, 2, 'VISTA', 'Sits right next to the church', 3, 5, 123);
  INSERT INTO room_table (room_id, branch_id, room_type, room_desc, bathroom_count, bed_count, price)
  VALUES(12, 3, 'PENTHOUSE', 'You can practically ski out from your room', 6, 12, 280);
  INSERT INTO room_table (room_id, branch_id, room_type, room_desc, bathroom_count, bed_count, price)
  VALUES(13, 1, 'PENTHOUSE', 'A-Star room with a view of the sky tower', 4, 4, 190);
  INSERT INTO room_table (room_id, branch_id, room_type, room_desc, bathroom_count, bed_count, price)
  VALUES(14, 2, 'PENTHOUSE', 'Bueatiful view of the mountain ranges', 3, 7, 120);
  INSERT INTO room_table (room_id, branch_id, room_type, room_desc, bathroom_count, bed_count, price)
  VALUES(15, 5, 'KING', 'A room suited for a king and his queen and with a cheap price tag', 2, 2, 67);
  INSERT INTO room_table (room_id, branch_id, room_type, room_desc, bathroom_count, bed_count, price)
  VALUES(16, 5, 'VISTA', 'Deck outside that leads to a fantastic view', 2, 13, 110);
  INSERT INTO room_table (room_id, branch_id, room_type, room_desc, bathroom_count, bed_count, price)
  VALUES(17, 3, 'QUEEN', 'A queen and her self could spend an eternity here', 1, 1, 90);
  
  INSERT INTO reservation_table (res_id, cust_id, cust_fname, cust_lname, room_id, room_type, start_date, end_date)
  VALUES(1, 1, (SELECT cust_fname FROM customer_table WHERE cust_id = 1),
               (SELECT cust_lname FROM customer_table WHERE cust_id = 1), 1,
               (SELECT room_type FROM room_table WHERE room_id = 1), '12-07-2018', '30-08-2018');
  INSERT INTO reservation_table (res_id, cust_id, cust_fname, cust_lname, room_id, room_type, start_date, end_date)
  VALUES(2, 2, (SELECT cust_fname FROM customer_table WHERE cust_id = 2),
               (SELECT cust_lname FROM customer_table WHERE cust_id = 2), 2,
               (SELECT room_type FROM room_table WHERE room_id = 2), '4-07-2017', '30-03-2018');
  INSERT INTO reservation_table (res_id, cust_id, cust_fname, cust_lname, room_id, room_type, start_date, end_date)
  VALUES(3, 3, (SELECT cust_fname FROM customer_table WHERE cust_id = 3),
               (SELECT cust_lname FROM customer_table WHERE cust_id = 3), 3,
               (SELECT room_type FROM room_table WHERE room_id = 3), '5-09-1999', '1-10-2018');
  INSERT INTO reservation_table (res_id, cust_id, cust_fname, cust_lname, room_id, room_type, start_date, end_date)
  VALUES(4, 4, (SELECT cust_fname FROM customer_table WHERE cust_id = 4),
               (SELECT cust_lname FROM customer_table WHERE cust_id = 4), 4,
               (SELECT room_type FROM room_table WHERE room_id = 4), '5-02-2018', '6-02-2018');
  INSERT INTO reservation_table (res_id, cust_id, cust_fname, cust_lname, room_id, room_type, start_date, end_date)
  VALUES(5, 5, (SELECT cust_fname FROM customer_table WHERE cust_id = 5),
               (SELECT cust_lname FROM customer_table WHERE cust_id = 5), 1,
               (SELECT room_type FROM room_table WHERE room_id = 1), '12-05-2018', '30-08-2018');

/*Inseting into invoice table loop*/
  FOR i IN 1 .. numberOfReservations LOOP
    INSERT INTO invoice_table (res_id, room_id, cust_fname, cust_lname, price, days_stayed, bill)
    VALUES((SELECT res_id FROM reservation_table WHERE res_id = i),
        (SELECT room_id FROM reservation_table WHERE res_id = i), 
        (SELECT cust_fname FROM reservation_table WHERE res_id = i),
        (SELECT cust_lname FROM reservation_table WHERE res_id = i),
        (SELECT price FROM room_table roo, reservation_table res 
          WHERE res.res_id = i 
          AND res.room_id = roo.room_id),
        (SELECT (end_date-start_date) 
          FROM reservation_table 
          WHERE res_id = i),
        (SELECT (roo.price*(res.end_date-res.start_date))
          FROM room_table roo, reservation_table res
          WHERE roo.room_id = res.room_id 
          AND res.res_id = i));
  END LOOP;

END;



