CREATE OR REPLACE PROCEDURE NewRes
IS
  /*Variables needed*/
  C_FirstName reservation_table.cust_fname%TYPE;
  C_LastName reservation_table.cust_lname%TYPE;
  C_RoomType reservation_table.room_type%TYPE;
  C_startDate reservation_table.start_date%TYPE;
  C_endDate reservation_table.end_date%TYPE;
  C_Address customer_table.cust_address%TYPE;

  /*Missing variables setup*/
  C_ResID reservation_table.res_id%TYPE;
  C_CustID reservation_table.cust_id%TYPE;
  C_RoomID reservation_table.room_id%TYPE;
  
  /*Counters*/
  any_room_found_count Number;
  any_customer_found_count Number;
  
  /*Room chosen variables*/
  BranchCity branch_table.branch_city%TYPE;
  BranchName branch_table.branch_name%TYPE;
  RoomType room_table.room_type%TYPE;
  RoomDesc room_table.room_desc%TYPE;
  
  /*Exception*/
  e_halt_processing EXCEPTION;
  
Begin
  /*Get variables from input*/
  C_FirstName := '&Your_First_Name';
  C_LastName := '&Your_Last_Name';
  C_RoomType := UPPER('&A_Room_Type');
  C_startDate := TO_DATE('&Start_Date','DD-MM-YYYY');
  C_endDate := TO_DATE('&End_Date', 'DD-MM-YYYY');
  C_Address := '&Youre_address_for_contacting';
    

  /*Check if room exists*/
    SELECT count(room_id) INTO any_room_found_count
    FROM room_table
    WHERE room_type = C_RoomType;
    IF any_room_found_count = 0 THEN
        dbms_output.put_line('No '||C_RoomType||' room found sorry');
        RAISE e_halt_processing;
    END IF;
    
    /*Check if customer exists*/
    SELECT count(cust_id) INTO any_customer_found_count
    FROM customer_table
    WHERE cust_fname = C_FirstName
      AND cust_lname = C_LastName;
    IF any_customer_found_count = 0  THEN
        dbms_output.put_line('No customer account found, new one created for you. '||
                             'Your mobile and homephone, as well as your email and fax have been left null');
        
        /*Fill C_CustID*/
        SELECT (MAX(cust_id)+1) INTO C_CustID
        FROM customer_table;
                             
        INSERT INTO customer_table(cust_id, cust_fname, cust_lname, cust_address, cust_homephone, cust_mobilephone, cust_email, cust_fax)
        VALUES(C_CustID, C_FirstName, C_LastName, C_Address, null, null, null, null);
        
        dbms_output.put_line('Customer account created...');
    END IF;
    
    /*Fill C_ResID*/
    SELECT (count(*)+1) INTO C_ResID
    FROM reservation_table;
    
    /*Fill C_CustID*/
    SELECT cust_id INTO C_CustID
    FROM customer_table
    WHERE cust_fname = C_FirstName
      AND cust_lname = C_LastName;
      
    /*More than one room with the desired room type has been found so randomly select one of them*/
    IF any_room_found_count > 1 THEN
        dbms_output.put_line('More than one room has been found with your requested room type. One of them was chosen for you');
        SELECT room_id INTO C_RoomID
        FROM (
            SELECT * 
            FROM room_table
            ORDER BY DBMS_RANDOM.VALUE)
        WHERE room_type = C_RoomType
        AND ROWNUM = 1;
    
    /*Make sure that the rooms being returned is only one of them*/
    ELSE
        /*Fill C_RoomID if there's only one room found*/
        SELECT room_id INTO C_RoomID
        FROM room_table
        WHERE room_type = C_RoomType;
    END IF;
    
    dbms_output.put_line('Room chosen: ');
    SELECT b.branch_city, b.branch_name, r.room_type, r.room_desc INTO BranchCity, BranchName, RoomType, RoomDesc
    FROM room_table r, branch_table b
    WHERE r.branch_id = b.branch_id
      AND r.room_id = C_RoomID;
     
     
     
      
    /*Print out room chosen*/
    dbms_output.put_line(''||BranchName||', '||BranchCity||': '||RoomType||', '||RoomDesc); 
    
    /*Insert new reservation*/
    dbms_output.put_line('Creating your reservation....');
    INSERT INTO reservation_table(res_id, cust_id, cust_fname, cust_lname, room_id, room_type, start_date, end_date)
    VALUES(C_ResID, C_CustID, C_FirstName, C_LastName, C_RoomID, C_RoomType, C_StartDate, C_EndDate);
            
    dbms_output.put_line('Inserted reservation for '||C_FirstName||' '||C_LastName||' from '||C_StartDate||' till '||C_EndDate||' in room: '||C_RoomID||', room type: '||C_RoomType);
    
    COMMIT;
    
    
    /*Exception handling*/
    EXCEPTION
      WHEN e_halt_processing THEN
        dbms_output.put_line('Exiting Program');
    
End;
/
  