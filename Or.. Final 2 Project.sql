
-- Welcome to Library management system

-----------------------------------------------------
-- Create a table for showing if some users log ined and log outed
CREATE TABLE loginfo
(
    LogOn VARCHAR2(100)
);

 select * from loginfo;

-- Execute Trigger

CREATE OR REPLACE TRIGGER On_Logon  
  AFTER LOGON  
  ON SYSTEM.Schema  
BEGIN  
  INSERT INTO loginfo VALUES ('User logged in -->  ' || current_date);  
END; 

----------------------------------------------


-----------------------------------------------------------------------
--  Some Queries for different action

            -- how to drop a Table
            drop table Table_name;
            
            -- how to add a column in an exiting Table
            alter table Table_name  add Col_name varchar2(33);


            -- show table information
            desc Branch;
            
            -- allow or on trigger creater on this system
             SET SERVEROUTPUT ON;
            
            
            -- how to Drop a trigger
            drop trigger backup1;
            
            
            -- How to Delete a Row or a Column (Entity)
            delete 
            from Table_name
            where conditon='Value';
             
            
              -- if we want ot update our Tabel use of    
            update Branch
            set CITY='Kabul',B_Name='Alama Habibi'
            where B_ID='B01';
            
            
             -- How to Grant for  a User
             grant connect  to sys;
              
            
            -- by this command we can delet all entity in Staff table
            delete from Staff;
            
            
            
             
            -- way how to Rename a Column
            Alter Table Brancht 
            rename column Street to Branch_Street;










-----------------------------------------------------------------------


-- First i wanna create  a bracnh for the lilbrary
  
 create table Brancht
(
      B_ID varchar(5),
     B_Name varchar2(33),
	 Street varchar(50),
	 City varchar(50) not null,
        primary key (B_ID)
);


 
drop table Brancht;
-- use trigger for insert branch

-- allow or on trigger creater on this system
 SET SERVEROUTPUT ON;
 
create or replace trigger backup1   -- backup means Branch backup
after insert on Brancht
  Begin
 
dbms_output.put_line('Your table updated --> ' || current_date);

End;


------------------------------------------ 
-- apply name to every Branch
     insert into Brancht values('B10','Alame Habibi', '9 Street', 'Kandahar');
    insert into Brancht values('B20','New Technology', 'Kabul', 'Kabul');
     insert into Brancht values('B30','life guidness', 'Drawaza Malik', ' Herat');
     insert into Brancht values('B40','Ahmadian Books ', '1 Street', '  Kandahar');
     insert into Brancht values('B50','Islamic Books', 'New City', ' Kabul');
    insert into Brancht values('B60','Good Future','first area','Kandahar');
    insert into Brancht values('B70','now World','9nd Street','Herat');
 
 ------------------------------------------------- 
 delete 
 from Branch
 where B_id='B60';
 
        select * from Branch;
    ------------------------------------------------- 

-- Way How to delete a record from an exting Table
delete from Branch
where B_ID='33';
 
 
 
 /*
 i applied Many types of Trigger on Staff Table 
 1. For inserting a vule in tabel automatically show a message
 2. a trigger if Occure any Error in the Table
 
*/



-- Create a table fro Staff
create table Stafft
(
	Staff_ID varchar(5),
    Staff_Branch_ID varchar(5),
	Staff_Name varchar(30) not null,
	Salary numeric(10, 2) check (Salary>=1000),
	Phone varchar(11) not null ,
	Street varchar(50),
       	foreign key (Staff_Branch_ID )
		references Brancht(B_ID),
       	 primary key (Staff_ID)
);

drop Table Staff;
desc Staff;

-----------------------------------------------------------------
-- use Trigger if occur any error or problim  

-- First we make a table which we can dicate some rules
CREATE TABLE staffErrors
(
    ErrorInfo NVARCHAR2(100)
);


-- Excute Trigger
 CREATE OR REPLACE TRIGGER log_errors AFTER SERVERERROR ON DATABASE 
BEGIN
    INSERT INTO staffErrors VALUES ('Error occured on server  in --> '||current_date);
END;

select * from staffErrors;
-----------------------------------------------------------------


 
---------------------------
-- use trigger for inserting data show a message (Just while inserting)

 SET SERVEROUTPUT ON;

create or replace trigger backupstaff   
after insert on  Stafft
  Begin
 
 dbms_output.put_line('Your table updated --> ' || current_date);

End;

drop trigger backupstaff;
----------------------------------------------------
 
 
 
 
 --- Third Trigger for many operations------------
 
   
-- Create a table for logs

CREATE TABLE StaffttLogs
(
    EventName VARCHAR2(100)
);
 
 
 -- Trigger
CREATE OR REPLACE TRIGGER trg_1 
    BEFORE DELETE OR INSERT OR UPDATE ON Stafft
BEGIN
    IF INSERTING THEN
        INSERT INTO StaffttLogs VALUES
              ('INSERTED at --> '|| current_date);
    ELSIF DELETING THEN
        INSERT INTO StaffttLogs VALUES
              ('DELETED  at --> '|| current_date);
    ELSE
        INSERT INTO StaffttLogs VALUES
              ('UPDATED  at --> '|| current_date);   
    END IF;
END;

drop trigger trg_1 ;
  
  
 -- show how many operations occured
 select * from StaffttLogs;
  
  
  desc Stafft;
  insert into Stafft values ('S44','B40','Khan Ali',3399,'090332','Kabul');
  
  
  delete from Stafft where STAFF_ID='S44';
  
  
  select * from Stafft;
  update from Stafft
  set STAFF_NAME='Ziba'
  where  STAFF_BRANCH_ID ='B40';
 
 
 desc Stafft;
 
 
 ----------------------------------------------------
 -- fourth Trigger Do a Operation to Salary then give Back up in a new Table 
 
 
  -- Created  table is Staff table
 
-- Creat a table for calculate
CREATE TABLE CalculatedSalary
(
    STAFF_NAME VARCHAR2(100),
    SALARY DECIMAL
);



-- Trigger
CREATE OR REPLACE TRIGGER order_insert BEFORE INSERT ON Stafft FOR EACH ROW
BEGIN
    INSERT INTO CalculatedSalary(STAFF_NAME, SALARY)
    -- here multiple our salary into 0.1 then subtract from itself
      VALUES (:new.STAFF_NAME, (:new.SALARY - :new.SALARY * 0.1));
END;
 
 -- now show the table
 select * from  CalculatedSalary;
 
  ----------------------------------------------------
  
  
  ------------------------------------------ 


-- now we can applay Staff
insert into Stafft values('S01','B10','Azizkhan',50000,'934223','Kandahar');
INSERT INTO Stafft VALUES('S02','B20','Ahmadi', 990000,'9167180803', 'Kabul');
INSERT INTO Stafft VALUES('S03','B40','Lyla', 3040.,'9161180803', ' Herat');
insert into Stafft values('S04','B20','Frishta',5673,'345621','Mazare Sharif');
insert into Stafft values('S05','B20','Azizkhan',5673,'345621','Mazare Sharif');


-- Deleted a Record
delete from Stafft
where Staff_id='S04';

select * from Stafft;

desc Stafft;

-- by this command we can delet all entity in Staff table
delete from Stafft;
 -----------------------------------------
 -- how to update a Record
 
 update Stafft
 set Phone=0700993519               -- here we can use multiple condition
 where Staff_id='S02';
  
 ----------------------------------------
 
select * from Stafft

-- now we creat a table for customer
create table Customert
(
        CU_ID varchar(5),
        CU_Name varchar(50) not null,
        CU_Email varchar(30) check (CU_Email like '%@%.%'),
        CU_City varchar(20),
        CU_Contact varchar(15) unique check (CU_Contact like '0%'),
        primary key(CU_ID)
);

drop table Customert;
 desc Customert;


---------------------------

create or replace trigger backupcustomer   
after insert on customert
  Begin
 
dbms_output.put_line('Your table updated --> ' || current_date);

End;

drop trigger backupcustomert;

------------------------------------------ 


-- now insert customer
INSERT INTO Customert VALUES('C01','Rahmatullah','Rahmat@gmail.com', 'New Street', '0902011235');
INSERT INTO Customert VALUES('C02','Khan','Khan@gmail.com', 'Kdr Street ', '0831314634');
INSERT INTO Customert VALUES('C03','Frishta','Fr@gmail.com', 'Herat', '0700993519');
INSERT INTO Customert VALUES('C04','Vedant','ved@yahoo.com', 'Nashik', '087154526');
INSERT INTO Customert VALUES('C05','Jan','Jan@yahoo.com', 'Kandahar',  '0982562365');
INSERT INTO Customert VALUES('C06','Janhavi','janhavi@gmail.com', 'Dadar', '0782562365');
INSERT INTO Customert VALUES('C07','Somu','somu@hotmail.com', 'Thane', '0965812358');
INSERT INTO Customert VALUES('C08','Khan','Khan@redmail.com', 'Kabul', '0736259665');
insert into Customert values('C09','Jan','jlo@gmail.ocm','Mazare s','04352');

drop table Customert;
delete from Customert
where CU_ID='C08';
 
  
 ------------------------
-- we can update the above Table by
update Customert
set NAME='Rahmatullah', EMAIL_ID='Rahmat@gmail.com', CITY='New Street'
where REG_ID='C01';
 ----------------------------
select * from Customert;

-- now create a table for publisher
CREATE TABLE  Publishert(	
     P_ID VARCHAR(5), 
	 P_NAME VARCHAR2(100) NOT NULL, 
     P_Location varchar2(44),
	 PRIMARY KEY (P_ID)	
);
desc publisher;

drop table Publishert;
---------------------------

create or replace trigger backuppublisher  
after insert on publishert
  Begin
 
dbms_output.put_line('Your table updated --> ' || current_date);

End;

drop trigger backupstafft;

------------------------------------------ 

-- now list all publisher
INSERT INTO Publishert VALUES('P001','Jahan_hous','Kabul');
INSERT INTO Publishert VALUES('P012','Techneo','India');
INSERT INTO Publishert VALUES('P003','Oxford','USA');
INSERT INTO Publishert VALUES('P145',' ALAME HABIBI','KANDAHAR');
INSERT INTO Publishert VALUES('P456','S Chand','CHIN');
INSERT INTO Publishert VALUES('P087','Cengage','SOUTH AMRICAN');
INSERT INTO Publishert VALUES('P324','Black Swan','TURKIA');

select * from Publishert;

------------------------
delete from Publisher
where P_id='P324';
-------------------------------

update publisher
set P_Name='Alama Habibi Ketabtoon'
where P_ID='P001';
-------------------
 
 select  * from Publisher;

-- create a books table
create table Bookst
(
        BO_ID int,
        Publisher_ID varchar(5),
        BO_Title varchar(100),
        BO_Author varchar(50) not null,
         
        No_of_Books int check (No_of_Books >= 0),
        Foreign key (Publisher_ID) references  Publishert(P_ID),
        primary key (BO_ID)
        
);
drop Table Bookst;

select * from Bookst;
desc Bookst;



---------------------------

create or replace trigger backupBooks   
after insert on Bookst
  Begin
 
dbms_output.put_line('Your table updated --> ' || current_date);

End;

drop trigger backupstaff;

------------------------------------------ 

-- now we can insert books in our table
insert into Bookst values(110,'P003','Forent end developer','Sekshper' ,100);
INSERT INTO Bookst VALUES(120,'P012','DICTIONARY', ' Kazim Housain Housani ' , 20);
INSERT INTO Bookst VALUES(130,'P001','DBMS', 'Molana'    , 34);
INSERT INTO Bookst VALUES(140,'P001','B.E.E', 'BALLANIS' ,56 );
INSERT INTO Bookst VALUES(150,'P012','SOCIAL STUDIES', 'H. TAUB' , 67);
INSERT INTO Bookst VALUES(160,'P001','BIG DATA ANALYTICS', 'SARVESH TALE' , 78);
INSERT INTO Bookst VALUES(170,'P003','TELL TALES', 'RK NARAYAN' , 89);
INSERT INTO Bookst VALUES(180,'P087','JEE PREP', 'HC VERMA' , 69);
INSERT INTO Bookst VALUES(190,'P012','CHEMISTRY', 'SD SHETE' , 76);
INSERT INTO Bookst VALUES(200,'P324','HISTORY', 'RAVI MADHAVI' , 2);
INSERT INTO Bookst VALUES(210,'P001','IMAGE PROCESSING', 'ALAN OPPENHEIM' , 12);
INSERT INTO Bookst VALUES(220,'P003','MATHEMATICS', 'PETER GOMES' , 25);
INSERT INTO Bookst VALUES(230,'P324','GEOGRAPHY', 'MUKTA PATIL' , 35);
INSERT INTO Bookstt VALUES(240,'P012','LET US C', 'Y KANETKAR' , 15);
INSERT INTO Books VALUES(250,'P087','NEET PREP', 'DR. SUSHIL TAMBE' , 27);
INSERT INTO Bookst VALUES(260,'P456','CRYPTOGRAPHY', 'MINAL KAUR' , 21);

select * from Bookst;
------------------------------------
select * from Bookst
where BO_Author=' Kazim Housain Housani';


------------------------------------------------
-- update a Record
update Bookst
set    BO_AUTHOR=' Kazim Housain Housani'
WHERE BO_ID='120';
----------------------------------
 -- show some faurite Entity with conditional
select * from Bookst
where Publisher_ID ='P001';

-- this Table is like a (Noskha or Report) it just rewrite the list for us
Create  table Issuet
(
    Cust_id varchar(5),
    Book_id int,
   Issue_date date,
    Return_date date,
    Br_ID varchar(5),
    St_id varchar(5),
   foreign key (Br_ID) references Brancht(B_ID),
   foreign key (Cust_id) references Customert(CU_ID),
   foreign key (Book_id) references Bookst(BO_ID),
   foreign key (St_id) references Stafft(Staff_ID),
   primary key (Cust_id, Book_id, Issue_date,Br_ID)
);

drop table issuet;
desc ISSUEt;



---------------------------

create or replace trigger backupissue   
after insert on issuet
  Begin
 
dbms_output.put_line('Your table updated --> ' || current_date);

End;

drop trigger backupstaff;

------------------------------------------ 


INSERT INTO Issuet VALUES('C01',110,'06-Aug-2019','13-Aug-2019','B10','S01');
INSERT INTO Issuet VALUES('C02',130,'07-Nov-2019','14-Nov-2019','B50','S02');
INSERT INTO Issuet VALUES('C03',200,'23-Jan-2019','30-Jan-2019','B20','S03');
INSERT INTO Issuet VALUES('C02',220,'17-Jun-2019','24-Jun-2019','B30',NULL);
INSERT INTO Issuet VALUES('C04',130,'18-Jul-2019','25-Jul-2019','B10','S01');
INSERT INTO Issuet VALUES('C05',240,'16-Jul-2019','23-Jul-2019','B20',NULL);
INSERT INTO Issuet VALUES('C08',250,'20-Nov-2020','27-Nov-2020','B40','S03');
INSERT INTO Issuet VALUES('C06',210,'23-Jul-2020','30-Jul-2020','B50',NULL);
INSERT INTO Issuet VALUES('C06',140,'16-Dec-2020','23-Dec-2020','B10','S02');
INSERT INTO Issuet VALUES('C07',170,'30-Jul-2020','7-Aug-2020','B20',NULL);
INSERT INTO Issuet VALUES('C08',180,'28-Jan-2021','4-Feb-2021','B30','S01');

-- a condation for show a command 
select * from ISSUEt
WHERE BOOK_ID=1001;

-- now i wanna know how is with this id which brough  a book --> C02
select * from Customert
where REG_ID='C02';

desc Customert;
select * from Issuet;

-- we can drop the issue etc...
drop table Issuet;

-- with this command we can print (show) the BOOK_ID and BOOK_TITLE Between a specific Date
select i.book_ID,b.BO_TITLE   from ISSUEt i, Bookst b  where Issue_date between '1-aug-2019' and '31-dec-2020' and i.book_id=b.BO_ID   order by book_Id;
-- or we can write
select BOOK_ID,BO_TITLE   FROM ISSUEt , BOOKSt  WHERE ISSUE_DATE  BETWEEN '16-JUL-1923 ' AND '23-JUL-2023' and BOOK_ID=BO_ID  ORDER BY BO_TITLE;

 select * from Stafft;
 
 desc Bookst;
 --------------------------------------------------------------
 
 
  
  
-------------------------------------------------------

---------------Stored Procedures---------------
-- Stored Procedures


-- how to decler a procedure with a prameter
 CREATE OR REPLACE PROCEDURE first_procedure (va IN VARCHAR2)
IS
BEGIN
dbms_output.put_line ('Hi! my name is ' ||va);
END;

drop procedure first_procedure;
SET SERVEROUTPUT ON

-- run an extinc procedure give a prameter pass to above procedure
BEGIN
first_procedure('  Ahmad');
END;


Select * from Stafft;


--Dropping a proccedure
DROP PROCEDURE first_procedure;


SELECT * FROM All_SOURCE
WHERE TYPE = 'PROCEDURE'



SELECT * FROM All_SOURCE
WHERE TYPE = 'PROCEDURE' AND
TEXT LIKE '%dbms%'

  
  
   
desc Stafft;
 --------------------------------------------------------
-- Befor update salary
select Salary,Staff_Name,Staff_ID
 from Stafft;

-- with this command we can just update all salaries without any condition
update Stafft
set Salary=Salary+7;

select * from Stafft;

-- update all staff salaries (Means Favorite)
update Stafft
set Salary = Salary+7
where Salary <=50007; 
    

 /* In Oracle queries, SAVEPOINT is a command used to define a point
 within a transaction to which you can later rollback 
 The savepoint name must be unique within the transaction.
 Savepoints are useful when you want to divide a transaction into smaller, 
 more manageable units. If an error occurs or you need to undo part of the transaction, 
 you can rollback to a specific savepoint instead of rolling back the entire transaction.
 
 Example:
 
 BEGIN
   SAVEPOINT A;

   -- Perform some operations

   SAVEPOINT B;

   -- Perform more operations

   SAVEPOINT C;

   -- Perform additional operations

   -- If an error occurs or you need to rollback to a specific savepoint:
   ROLLBACK TO SAVEPOINT B;

   -- Continue with the transaction or perform other operations

   COMMIT;
END;
 */
savepoint A

-- if you want to Rollbak a savepoint
rollback A;
/*  In Oracle, the COMMIT statement is used to permanently
save the changes made within a transaction   
Example:  
BEGIN
   -- Perform some operations within the transaction

   -- If everything is successful, commit the changes
   COMMIT;

   -- Once the commit is executed, the changes are permanent and visible to 
   other users
END;
*/
commit;

select * from Stafft;
select * from Brancht;

------------------------------
-- Join operation
 select Stafft.Staff_Name, Brancht. City 
from Brancht
left join Stafft 
on Stafft.Street= Brancht.BR_Street;


----------------------
 select Stafft.Staff_Name, Brancht. City 
from Brancht
right join Stafft 
on Stafft.Street= Brancht.BR_Street;


desc Brancht;
----------------------------
select * from Branch; 

 
 
select Stafft.Staff_Name, Brancht.City 
from Brancht
inner join Stafft 
on Stafft.STREET= Brancht.Br_Street

   

 
-- way how to Rename a Column
Alter Table Brancht 
rename column Street to Branch_Street;

 
 ----------------------------------------------------
 -- View for staff 
 desc customert;
 
-- CREATE VIEW Staff_View AS  
--SELECT Issuet.Cust_ID,Customert.CU_Name, Bookst.BO_ID, Bookst.BO_Title, Issuet.Book_id, Issuet.Issue_Date, Issuet.Return_date, Customert.CU_Email,Customert.CU_Contact
--FROM Issuet, Customert, Bookst 
--WHERE Issuet.Book_id=Bookst.BO_ID and Issuet.Cust_ID=Customert.CU_ID;  
--
--
--drop view Staff_View; 

SELECT * FROM Staff_View; 
 -------------------------------------------------- 
-- Create a General View  for customer  customers have some role for views 

CREATE VIEW Customer_View AS  
SELECT Bookst.BO_Title,Bookst.BO_Author,Bookst.No_of_Books,Publishert.P_Name
FROM Publishert, Bookst
WHERE Publishert.P_ID=Bookst.Publisher_ID;

DROP VIEW CUSTOMER_VIEW;
Select * from Customer_View;

-------------------------------------------------------------

-- Create a General View  for Admin --> * used which an Admin can see all entity, attributes

CREATE VIEW Admin_View AS  
SELECT *
FROM Stafft,Brancht 
WHERE Stafft.Staff_Branch_ID=Brancht.B_ID;
 
----------------------------------------------
alter Table Brancht
rename column Street to Br_Street;

desc Branch;
drop view Admin_View;

Select * from Admin_View;

-------------------------------------------------------------------
-- Aggregate Functions

select count(NO_OF_BOOKS )as All_Books_count from Bookst;
 
 select  sum(Salary) as Total_salary,count(salary)as Staffs_count, avg(salary) as AVG_Salary_of_Staffs from Stafft;

 select max(Salary) as Max_Salary,min(Salary) as Min_Salary from Stafft; 
 
 
 ---------- Aggregate Functions
 
 SELECT  Staff_Name    ,count(Staff_name)as Staff_count, MAX (Salary) as Max_Salary FROM Stafft GROUP BY Staff_Name  ;
  
 desc Stafft;
------------------------------------------------
    
-- show for me that salary which greater than all average 
select Staff_ID, Staff_name, salary
from Stafft
where salary > (
select avg(salary)
from Stafft
)


-- NOW SHOW FOR US THAT SALARIES WHICH THEY BECAM LESS THAN AVERAGE
select Staff_ID,STAFF_NAME,SALARY
FROM STAFFt
WHERE  SALARY<( SELECT AVG(SALARY)
FROM STAFFt);

select Salary from Stafft;

----------------------------------------------------------------
-- INdex 


 CREATE INDEX Stafft_index
   ON Stafft (Staff_name);
   
   
   --- this index make all staffs name to lower case 
   CREATE INDEX staff_name
ON stafft (LOWER(staff_name));

select * from staff_name;

drop index staff_name;

-- how to rename an index
ALTER INDEX currentindex_name
RENAME TO new_indexname;

-----------------------------------------------------
drop table Issuet;
drop table Bookst;
drop table Publishert;
drop table Customert;
drop table Stafft;
drop table Brancht;

Delete from Stafft where Staff_Branch_ID='B05';

---------------------------------------------------------------------------------
 
 
