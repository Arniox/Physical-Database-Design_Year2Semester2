/*Creation of the customer table.
Primary key(s) are: Cust_Id
Foreign key(s) are: */
DROP TABLE invoice_table;
DROP TABLE reservation_table;
DROP TABLE room_table;
DROP TABLE branch_table;
DROP TABLE customer_table;
COMMIT;

CREATE TABLE customer_table(
            Cust_Id Number(5) NOT NULL,
            Cust_FName varchar2(20) NOT NULL,
            Cust_LName varchar2(20),
            Cust_Address varchar2(50) NOT NULL,
            Cust_HomePhone Number(15),
            Cust_MobilePhone Number(15),
            Cust_Email varchar(30),
            Cust_Fax Number(15),
            CONSTRAINT PK_CustID PRIMARY KEY (Cust_Id))
TABLESPACE customer_table_space
PCTFREE 40
PCTUSED 50
STORAGE(INITIAL 1M NEXT 1M PCTINCREASE 0);
            
/*Creation of the Branch table.
Primary key(s) are: Branch_Id
Foreign key(s) are: */
CREATE TABLE branch_table(
            Branch_Id Number(5) NOT NULL,
            Branch_name varchar2(30) NOT NULL,
            Branch_city varchar2(20),
            Branch_Email varchar2(30),
            Branch_phone Number(15),
            Branch_address varchar2(50) NOT NULL,
            CONSTRAINT PK_BranchID PRIMARY KEY (Branch_Id))
TABLESPACE branch_table_space
PCTFREE 20
PCTUSED 70
STORAGE(INITIAL 4K NEXT 0 PCTINCREASE 0);

/*Creation of the Room table.
Primary key(s) are: Room_Id
Foreign key(s) are: Branch_Id*/
CREATE TABLE room_table(
            Room_Id Number(5) NOT NULL,
            Branch_Id Number(5) NOT NULL,
            Room_Type varchar2(20),
            Room_Desc varchar2(150),
            Bathroom_Count Number(1),
            Bed_Count Number(2),
            Price Number(10),
            CONSTRAINT PK_RoomID PRIMARY KEY (Room_Id),
            CONSTRAINT FK_BranchID FOREIGN KEY (Branch_Id) REFERENCES branch_table(Branch_Id))
TABLESPACE room_table_space
PCTFREE 6
PCTUSED 85
STORAGE(INITIAL 100K NEXT 100K PCTINCREASE 0);
                    
/*Creation of the Reservation table.
Primary key(s) are: Res_Id
Foreign key(s) are: Cust_Id, Room_Id*/
CREATE TABLE reservation_table(
            Res_Id Number(5) NOT NULL,
            Cust_Id Number(5) NOT NULL,
            Cust_FName varchar2(20) NOT NULL,
            Cust_LName varchar2(20) NOT NULL,
            Room_Id Number(5) NOT NULL,
            Room_Type varchar2(10),
            start_date date NOT NULL,
            end_date date NOT NULL,
            CONSTRAINT PK_ResID PRIMARY KEY (Res_Id),
            CONSTRAINT FK_Cust_ID FOREIGN KEY (Cust_Id) REFERENCES customer_table(Cust_Id),
            CONSTRAINT FK_RoomID FOREIGN KEY (Room_Id) REFERENCES room_table(Room_Id))
TABLESPACE reservation_table_space
PCTFREE 37
PCTUSED 55
STORAGE(INITIAL 50K NEXT 50K PCTINCREASE 0);
              
/*Creation of the Invoice table.
Primary key(s) are: Res_Id, Room_Id
Foreign key(s) are: Res_Id, Room_Id, Cust_Fname, Cust_LName*/
CREATE TABLE invoice_table(
            Res_Id Number(5) NOT NULL,
            Room_Id Number(5) NOT NULL,
            Cust_FName varchar2(20) NOT NULL,
            Cust_LName varchar2(20) NOT NULL,
            Price Number(10),
            Days_Stayed Number(10),
            Bill Number(10) NOT NULL,
            CONSTRAINT PK_InvoiceResID PRIMARY KEY (Res_Id),
            CONSTRAINT FK_ResID_IN FOREIGN KEY (Res_Id) REFERENCES reservation_table(Res_Id),
            CONSTRAINT FK_RoomID_IN FOREIGN KEY (Room_Id) REFERENCES room_table(Room_Id))
TABLESPACE invoice_table_space
PCTFREE 25
PCTUSED 65
STORAGE(INITIAL 50K NEXT 0 PCTINCREASE 0);

COMMIT;
