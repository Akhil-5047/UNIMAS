-- 1. Dept 
-- 2. Student
-- 3. Faculty
-- 4. Course
-- 5. Table with Cid, yr , fid
-- 6. Registration Table sid, Cid
-- 7. Grade
-- 8. Attendance
-- 9. Prerequisite

-- SELECT owner, table_name  FROM  all_tables;
-- SELECT  table_name  FROM  USER_tables;
ALTER SESSION SET NLS_DATE_FORMAT='DD-MM-YYYY'; 

DROP TABLE Prerequisite;
DROP TABLE Attendance;
DROP TABLE SCORE;
DROP TABLE Registration;
DROP TABLE teaches;
DROP TABLE course;

DROP TABLE faculty;
DROP TABLE JOBS;
DROP TABLE student;
DROP TABLE department;
DROP TABLE PERSON;

CREATE TABLE DEPARTMENT(
    dept_id int,
    dept_name varchar(32),
    code varchar(2),
    hod_id int,
    PRIMARY KEY (dept_id)
);

--SELECT * FROM DEPARTMENT;

CREATE TABLE PERSON(
    email varchar(32),
    password varchar(32),
    PRIMARY KEY (EMAIL)
);

CREATE TABLE STUDENT(
    sroll varchar(9),
    sname varchar(32),
    batch int,
    dept_id int,
    email varchar(32),
    phone varchar(32),
    gender char, 
    dob date,
    program varchar(16),
    address varchar(32),
    PRIMARY KEY (sroll),
    CONSTRAINT FK_STU_DEPT FOREIGN KEY (dept_id) REFERENCES DEPARTMENT(dept_id) ON DELETE CASCADE,
    CONSTRAINT FK_STU_EMAIL FOREIGN KEY (email) REFERENCES PERSON(email) ON DELETE CASCADE,
    CONSTRAINT CHECK_STU_GENDER CHECK (gender = 'F' or gender = 'M'),
    CONSTRAINT CHECK_STU_SNAME CHECK (SNAME IS NOT NULL), 
    CONSTRAINT CHECK_STU_DOB CHECK (DOB IS NOT NULL),
    CONSTRAINT CHECK_STU_EMAIL CHECK (EMAIL IS NOT NULL),
    CONSTRAINT CHECK_STU_BATCH CHECK (BATCH IS NOT NULL),
    CONSTRAINT CHECK_STU_PROGRAM CHECK (PROGRAM IS NOT NULL)
);

CREATE TABLE JOBS(
    job_id int,
    job_title varchar(32),
    PRIMARY KEY (job_id),
    CONSTRAINT CHECK_JOB_JTITLE CHECK (JOB_TITLE IS NOT NULL)
);


CREATE TABLE FACULTY(
    faculty_id int,
    fname varchar(32),
    joining_date date,
    dept_id int,
    email varchar(32),
    phone varchar(32),
    gender char,  
    salary int,
    job_id int,
    PRIMARY KEY (faculty_id),
    CONSTRAINT FK_FAC_DEPT FOREIGN KEY (dept_id) REFERENCES DEPARTMENT(dept_id) ON DELETE CASCADE,
    CONSTRAINT FK_FAC_JID FOREIGN KEY (JOB_ID) REFERENCES JOBS(JOB_ID) ON DELETE CASCADE,
    CONSTRAINT FK_FAC_EMAIL FOREIGN KEY (email) REFERENCES PERSON(email) ON DELETE CASCADE, 
    CONSTRAINT CHECK_FAC_GENDER CHECK (gender = 'F' or gender = 'M'),
    CONSTRAINT CHECK_FAC_FNAME CHECK (FNAME IS NOT NULL),
    CONSTRAINT CHECK_FAC_SAL CHECK (SALARY > 0),
    CONSTRAINT CHECK_FAC_EMAIL CHECK (EMAIL IS NOT NULL),
    CONSTRAINT CHECK_FAC_JDATE CHECK (joining_date IS NOT NULL)
);


CREATE TABLE COURSE(
    course_id int,
    cname varchar(32),
    ctype varchar(32),
    dept_id int,
    semno int,
    CREDITS int,
    PRIMARY KEY (course_id),
    CONSTRAINT FK_COU_DEPT  FOREIGN KEY (dept_id) REFERENCES DEPARTMENT(dept_id) ON DELETE CASCADE,
    CONSTRAINT CHECK_COU_CNAME CHECK (CNAME IS NOT NULL),
    CONSTRAINT CHECK_COU_CTYPE CHECK (CTYPE IS NOT NULL),
    CONSTRAINT CHECK_COU_CR CHECK (CREDITS >= 1 AND CREDITS <= 6),
    CONSTRAINT CHECK_COU_SEMNO CHECK (SEMNO >= 1 AND SEMNO <= 8)
);
--DROP TABLE TEACHES;
CREATE TABLE TEACHES(
    course_id int,
    year  varchar2(8), 
    faculty_id int,
    PRIMARY KEY (course_id, year),
    CONSTRAINT FK_OFFCOURSE_CID  FOREIGN KEY (course_id) REFERENCES COURSE(course_id) ON DELETE CASCADE,
    CONSTRAINT FK_OFFCOURSE_FID  FOREIGN KEY (faculty_id) REFERENCES FACULTY(faculty_id) ON DELETE CASCADE
);

CREATE TABLE REGISTRATION(
    sroll varchar(9),
    course_id int,
    PRIMARY KEY (sroll, course_id),
    CONSTRAINT FK_REG_SROLL FOREIGN KEY (sroll) REFERENCES STUDENT(SROLL) ON DELETE CASCADE,
    CONSTRAINT FK_REG_CID FOREIGN KEY (course_id) REFERENCES COURSE(course_id) ON DELETE CASCADE
);

CREATE TABLE SCORE(
    sroll varchar(9),
    course_id int,
    grade int,
    PRIMARY KEY (sroll, course_id),
    CONSTRAINT FK_GRA_SROLLCID FOREIGN KEY (sroll, course_id) REFERENCES REGISTRATION(sroll, course_id) ON DELETE CASCADE,
    CONSTRAINT CHECK_GRA_GRA CHECK (GRADE >= 0 AND GRADE <= 10)
);

CREATE TABLE ATTENDANCE(
    sroll varchar(9),
    course_id int,
    adate date,
    status char,
    PRIMARY KEY (sroll , course_id, adate),
    CONSTRAINT FK_ATT_SROLLCID FOREIGN KEY (sroll, course_id) REFERENCES REGISTRATION(sroll, course_id) ON DELETE CASCADE,
    CONSTRAINT CHECK_ATT_GRA CHECK (status = 'A' OR status = 'P')
);


CREATE TABLE PREREQUISITE(
    course_id int,
    prerequisite_id int,
    PRIMARY KEY (course_id, prerequisite_id),
    CONSTRAINT FK_PRE_CID FOREIGN KEY (course_id) REFERENCES COURSE(course_id) ON DELETE CASCADE,
    CONSTRAINT FK_PRE_PID FOREIGN KEY (prerequisite_id) REFERENCES COURSE(course_id) ON DELETE CASCADE
);
 
