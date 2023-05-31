CREATE OR REPLACE PROCEDURE add_dept
(
    deptname IN varchar2,
    deptcode IN varchar2,
    hodid IN int,
    dept_id OUT INT 
)    
  AS 
    DEPT INT := 0; 
BEGIN
    select MAX(DEPT_ID) into DEPT FROM DEPARTMENT;
    INSERT INTO DEPARTMENT   VALUES (DEPT+1, DEPTNAME, DEPTCODE, HODID) ;
    dept_id := dept + 1;
END add_dept; 
/ 
 

select * from department;
SET SERVEROUTPUT ON;
DECLARE DEPT INT;
BEGIN
    add_dept('TEMP DEPT','TD',NULL,dept);
    DBMS_OUTPUT.PUT_LINE(DEPT);
END;
/

SELECT * FROM department;


CREATE OR REPLACE PROCEDURE ADD_COURSE(
    cname OUT varchar2 ,
    ctype OUT varchar2,
    dept_id IN int,
    semno IN int,
    CREDITS IN int,
    course_id OUT int
) AS 
    CID INT := 0;
BEGIN
    SELECT MAX(COURSE_ID) + 1 INTO CID FROM COURSE; 
    INSERT INTO COURSE VALUES (CID, CNAME, CTYPE, DEPT_ID, SEMNO, CREDITS);
    COURSE_ID := CID;
END;
/

--select * from person where email = 'f1@s.com';
CREATE SEQUENCE FAC_IDS
START WITH 11
INCREMENT BY 1;

SELECT * FROM FACULTY;
CREATE OR REPLACE PROCEDURE ADD_FACULTY(
 
    fname varchar2, 
    dept int,
    femail varchar2,
    phone varchar2,
    gender char,  
    salary int,
    job_id int,
    password in varchar2,
    fid out int
) 
AS
    curr_max int := 0;
BEGIN  
    INSERT INTO PERSON VALUES (FEMAIL, PASSWORD);
    INSERT INTO FACULTY VALUES (FAC_IDS.NEXTVAL, FNAME,SYSDATE, DEPT, FEMAIL, PHONE, GENDER, SALARY, JOB_ID);
    SELECT FACULTY_ID INTO FID FROM FACULTY F WHERE F.EMAIL = FEMAIL;
END;
/

DECLARE
FID INT;
BEGIN
    add_faculty('S',1,'f112@s.com','9876543210','M', 10000,1, 'pass', FID);
END;
/

SELECT * FROM FACULTY;