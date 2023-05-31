--LIST OF STUDENTS, REGISTERED IN FAC COURSES
ALTER SESSION SET NLS_DATE_FORMAT='DD-MM-YYYY'; 

SELECT * FROM REGISTRATION NATURAL JOIN TEACHES;

SELECT S.SROLL, S.BATCH, C.CNAME, FLOOR(S.BATCH + (C.SEMNO)/2) AS TOREAD
    FROM STUDENT S, COURSE C WHERE C.DEPT_ID = 3 OR C.DEPT_ID = S.DEPT_ID ORDER BY S.SROLL,TOREAD ;

CREATE OR REPLACE VIEW STUDENT_COURSE_YEAR AS (SELECT S.SROLL, S.BATCH, C.COURSE_ID, FLOOR(S.BATCH + (C.SEMNO)/2) AS TOREAD
    FROM STUDENT S, COURSE C WHERE C.DEPT_ID = 3 OR C.DEPT_ID = S.DEPT_ID  )ORDER BY SROLL , TOREAD;

--Q
select * from STUDENT_COURSE_YEAR;

CREATE OR REPLACE VIEW REG_TOREAD AS (SELECT S.SROLL, S.COURSE_ID, TOREAD FROM STUDENT_COURSE_YEAR S, REGISTRATION R
    WHERE R.SROLL = S.SROLL AND R.COURSE_ID = S.COURSE_ID);

SELECT * FROM REG_TOREAD;

SELECT * FROM TEACHES T , (SELECT R.SROLL,R.COURSE_ID,S.TOREAD FROM REGISTRATION R, STUDENT_COURSE_YEAR S 
    WHERE R.SROLL = S.SROLL AND R.COURSE_ID = S.COURSE_ID) K WHERE T.COURSE_ID = K.COURSE_ID;

SELECT * FROM TEACHES;
 
 

CREATE OR REPLACE TRIGGER FAC_UPDATE_CHECK
BEFORE UPDATE ON FACULTY
FOR EACH ROW 
BEGIN
    IF :NEW.FACULTY_ID <> :OLD.FACULTY_ID
        THEN RAISE_APPLICATION_ERROR(-20000, 'ID cannot be changed!');
    ELSIF :NEW.EMAIL <> :OLD.EMAIL
        THEN RAISE_APPLICATION_ERROR(-20000, 'EMAIL ID cannot be changed!');
    END IF;
END;
/

--UPDATE FACULTY SET EMAIL = 'I' where faculty_id=1;
-- 
-- SELECT * FROM (SELECT S.SNAME, S.SROLL, S.BATCH, G.GRADE,G.COURSE_ID FROM STUDENT S, SCORE G WHERE S.SROLL = G.SROLL) P , 
--    (SELECT R.TOREAD, T.YEAR ,R.SROLL, C.CNAME,C.SEMNO,C.COURSE_ID FROM TEACHES T , COURSE C, REG_TOREAD R 
--        WHERE C.COURSE_ID = T.COURSE_ID AND T.FACULTY_ID = ? AND T.YEAR LIKE ?) K WHERE P.COURSE_ID = K.COURSE_ID AND K.SROLL = P.SROLL;
--
-- BEGIN
-- 
-- END;
-- /