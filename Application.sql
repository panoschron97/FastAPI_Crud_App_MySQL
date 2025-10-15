CREATE DATABASE IF NOT EXISTS application;
-- 
USE application;
--
CREATE TABLE IF NOT EXISTS information
(
id INTEGER AUTO_INCREMENT,
firstname VARCHAR(50) NOT NULL,
lastname VARCHAR(50) NOT NULL,
age INTEGER NOT NULL,
sex CHARACTER(1) DEFAULT 'N',
datebirth DATE NOT NULL,
jobstatus BOOLEAN DEFAULT FALSE,
levelofeducation VARCHAR(50) DEFAULT 'N/A',
salary FLOAT DEFAULT 0.0,
netsalary DOUBLE GENERATED ALWAYS AS (salary - (salary * 0.257)) VIRTUAL,/*STORED,*/
PRIMARY KEY(id ASC, datebirth ASC),
INDEX datebirth_indx (datebirth ASC),
CONSTRAINT age_chk CHECK (age >= 18),
CONSTRAINT sex_chk CHECK (sex IN ('M', 'F', 'N')),
CONSTRAINT firstname_lastname_chk CHECK (firstname REGEXP '^[A-Za-z ]+$' AND lastname REGEXP '^[A-Za-z ]+$'),
CONSTRAINT salary_jobstatus_chk CHECK ((salary = 0.0 AND jobstatus = FALSE) OR (salary >= 1000.0 AND jobstatus = TRUE))
) PARTITION BY RANGE /*COLUMNS*/(YEAR(datebirth))
SUBPARTITION BY HASH (MONTH(datebirth))
(PARTITION p0 VALUES LESS THAN (1971)
(SUBPARTITION p0_dec,
SUBPARTITION p0_jan,
SUBPARTITION p0_feb,
SUBPARTITION p0_mar,
SUBPARTITION p0_apr,
SUBPARTITION p0_may,
SUBPARTITION p0_jun,
SUBPARTITION p0_jul,
SUBPARTITION p0_aug,
SUBPARTITION p0_sept,
SUBPARTITION p0_oct,
SUBPARTITION p0_nov),
PARTITION p1 VALUES LESS THAN (1989)
(SUBPARTITION p1_dec,
SUBPARTITION p1_jan,
SUBPARTITION p1_feb,
SUBPARTITION p1_mar,
SUBPARTITION p1_apr,
SUBPARTITION p1_may,
SUBPARTITION p1_jun,
SUBPARTITION p1_jul,
SUBPARTITION p1_aug,
SUBPARTITION p1_sept,
SUBPARTITION p1_oct,
SUBPARTITION p1_nov),
PARTITION p2 VALUES LESS THAN (2007)
(SUBPARTITION p2_dec,
SUBPARTITION p2_jan,
SUBPARTITION p2_feb,
SUBPARTITION p2_mar,
SUBPARTITION p2_apr,
SUBPARTITION p2_may,
SUBPARTITION p2_jun,
SUBPARTITION p2_jul,
SUBPARTITION p2_aug,
SUBPARTITION p2_sept,
SUBPARTITION p2_oct,
SUBPARTITION p2_nov),
PARTITION p3 VALUES LESS THAN (2025)
(SUBPARTITION p3_dec,
SUBPARTITION p3_jan,
SUBPARTITION p3_feb,
SUBPARTITION p3_mar,
SUBPARTITION p3_apr,
SUBPARTITION p3_may,
SUBPARTITION p3_jun,
SUBPARTITION p3_jul,
SUBPARTITION p3_aug,
SUBPARTITION p3_sept,
SUBPARTITION p3_oct,
SUBPARTITION p3_nov));
--
DELIMITER //
CREATE TRIGGER Insert_Before_Information
/*AFTER*/BEFORE INSERT ON Information
FOR EACH ROW
BEGIN
IF (YEAR(CURRENT_DATE()) != NEW.Age + YEAR(NEW.Datebirth)) THEN
SIGNAL SQLSTATE '45000'
SET MESSAGE_TEXT = 'Date birth is not valid with the age you gave.';
END IF;
IF (NEW.Firstname REGEXP '^[A-Za-z ]+$' AND NEW.Lastname REGEXP '^[A-Za-z ]+$') THEN
SET NEW.Firstname = CONCAT(UPPER(SUBSTRING(NEW.Firstname, 1, 1)), LOWER(SUBSTRING(NEW.Firstname, 2, LENGTH(NEW.Firstname) - 1)));
SET NEW.Lastname = CONCAT(UPPER(SUBSTRING(NEW.Lastname, 1, 1)), LOWER(SUBSTRING(NEW.Lastname, 2, LENGTH(NEW.Lastname) - 1)));
END IF;
IF (NEW.Levelofeducation = '4') THEN
SET NEW.Levelofeducation = 'Lyceum';
ELSEIF (NEW.Levelofeducation = '5') THEN
SET NEW.Levelofeducation = 'Institute of vocational training';
ELSEIF (NEW.Levelofeducation = '6') THEN
SET NEW.Levelofeducation = 'Bachelor''s degree';
ELSEIF (NEW.Levelofeducation = '7') THEN
SET NEW.Levelofeducation = 'Master''s degree';
ELSEIF (NEW.Levelofeducation = '8') THEN
SET NEW.Levelofeducation = 'PhD';
ELSEIF (NEW.Levelofeducation = 'N/A') THEN
SET NEW.Levelofeducation = 'No education';
/*ELSE 
SET NEW.Levelofeducation = 'No education';*/
END IF;
END;
// DELIMITER ;
--
DELIMITER //
CREATE TRIGGER Update_Before_Information
/*AFTER*/BEFORE UPDATE ON Information
FOR EACH ROW
BEGIN
IF (YEAR(CURRENT_DATE()) != NEW.Age + YEAR(NEW.Datebirth)) /*OR (YEAR(CURRENT_DATE()) != NEW.Age + YEAR(OLD.Datebirth) AND NEW.Datebirth = OLD.Datebirth)*/ THEN
SIGNAL SQLSTATE '45000'
SET MESSAGE_TEXT = 'Date birth is not valid with the age you gave.';
END IF;
IF (NEW.Firstname REGEXP '^[A-Za-z ]+$' AND NEW.Lastname REGEXP '^[A-Za-z ]+$') THEN
SET NEW.Firstname = CONCAT(UPPER(SUBSTRING(NEW.Firstname, 1, 1)), LOWER(SUBSTRING(NEW.Firstname, 2, LENGTH(NEW.Firstname) - 1)));
SET NEW.Lastname = CONCAT(UPPER(SUBSTRING(NEW.Lastname, 1, 1)), LOWER(SUBSTRING(NEW.Lastname, 2, LENGTH(NEW.Lastname) - 1)));
END IF;
IF (NEW.Levelofeducation = '4') THEN
SET NEW.Levelofeducation = 'Lyceum';
ELSEIF (NEW.Levelofeducation = '5') THEN
SET NEW.Levelofeducation = 'Institute of vocational training';
ELSEIF (NEW.Levelofeducation = '6') THEN
SET NEW.Levelofeducation = 'Bachelor''s degree';
ELSEIF (NEW.Levelofeducation = '7') THEN
SET NEW.Levelofeducation = 'Master''s degree';
ELSEIF (NEW.Levelofeducation = '8') THEN
SET NEW.Levelofeducation = 'PhD';
ELSEIF (NEW.Levelofeducation = 'N/A') THEN
SET NEW.Levelofeducation = 'No education';
/*ELSE 
SET NEW.Levelofeducation = 'No education';*/
END IF;
END;
// DELIMITER ;
--
INSERT INTO Information(Id, Firstname, Lastname, Age, Sex, Datebirth, Jobstatus, Salary) 
VALUES (1, 'Panagiotis', 'Chronopoulos', 28, 'M', '1997-03-27', TRUE, 1000.0);
INSERT INTO Information(Firstname, Lastname, Age, Datebirth) VALUES ('nikos', 'stergiou', 28, '1997-02-17');
INSERT INTO Information(Firstname, Lastname, Age, Sex, Datebirth, Jobstatus, Salary, Levelofeducation) VALUES ('Popi', 'theofanopoulou', 30, 'F', '1995-04-15', TRUE, 1000.0, '4');
INSERT INTO Information(Firstname, Lastname, Age, Sex, Datebirth, Jobstatus, Salary, Levelofeducation) VALUES ('Makis', 'arvanitis', 40, 'M', '1985-05-21', TRUE, 2000.0, '5');
INSERT INTO Information(Firstname, Lastname, Age, Sex, Datebirth, Jobstatus, Salary, Levelofeducation) VALUES ('Giwrgos', 'maggos', 27, 'M', '1998-10-05', TRUE, 3000.0, '6');
INSERT INTO Information(Firstname, Lastname, Age, Sex, Datebirth, Jobstatus, Salary, Levelofeducation) VALUES ('alexandros', 'Spyropoulos', 30, 'M', '1995-04-19', TRUE, 2500.0, '7');
INSERT INTO Information(Firstname, Lastname, Age, Sex, Datebirth, Jobstatus, Salary, Levelofeducation) VALUES ('niki', 'alexiou', 33, 'F', '1992-04-19', TRUE, 1500.0, '8');
COMMIT;
--
SET GLOBAL event_scheduler = ON;
--
DELIMITER //
CREATE EVENT IF NOT EXISTS Updateage
ON SCHEDULE -- AT NOW() + INTERVAL 1 MINUTE
EVERY 1 YEAR STARTS '2025-01-01 00:00:00'
DO
BEGIN
UPDATE Information SET Age = Age + 1; -- , Datebirth = DATE_SUB(Datebirth, INTERVAL 1 YEAR);
COMMIT;
END;
// DELIMITER ;
--
DELIMITER //
CREATE EVENT IF NOT EXISTS Addpartitions
ON SCHEDULE -- EVERY 1 MINUTE STARTS CURRENT_TIMESTAMP + INTERVAL 1 MINUTE -- AT NOW() + INTERVAL 1 MINUTE
EVERY 18 YEAR STARTS '2025-01-01 00:00:00'
DO
BEGIN
DECLARE Currentyear, Counter INTEGER;
DECLARE Sqlstatement TEXT;
DECLARE Partitioname TEXT;
SET Counter = (SELECT SUBSTRING(PARTITION_NAME, 2) AS Counter
FROM information_schema.PARTITIONS
WHERE TABLE_SCHEMA = 'Application'
ORDER BY PARTITION_DESCRIPTION DESC
LIMIT 1) + 1;
SET Currentyear = (SELECT CAST(PARTITION_DESCRIPTION AS UNSIGNED) AS Currentyear 
FROM information_schema.PARTITIONS
WHERE TABLE_SCHEMA = 'Application'
ORDER BY PARTITION_DESCRIPTION DESC
LIMIT 1) + 18;
SET Partitioname = CONCAT('p', Counter);
SET @Sqlstatement = CONCAT(
'ALTER TABLE Information ADD PARTITION (PARTITION ', Partitioname, ' VALUES LESS THAN (', Currentyear, ')',
'(SUBPARTITION p', Counter, '_dec,',
'SUBPARTITION p', Counter, '_jan,',
'SUBPARTITION p', Counter, '_feb,',
'SUBPARTITION p', Counter, '_mar,',
'SUBPARTITION p', Counter, '_apr,',
'SUBPARTITION p', Counter, '_may,',
'SUBPARTITION p', Counter, '_jun,',
'SUBPARTITION p', Counter, '_jul,',
'SUBPARTITION p', Counter, '_aug,',
'SUBPARTITION p', Counter, '_sept,',
'SUBPARTITION p', Counter, '_oct,',
'SUBPARTITION p', Counter, '_nov));');
PREPARE statement FROM @Sqlstatement;
EXECUTE statement;
DEALLOCATE PREPARE statement;
END;
// DELIMITER ;
--
SELECT * FROM Information ORDER BY Id ASC;
--
UPDATE Information SET firstname = "testfirstname", lastname = "testlastname" WHERE id = 11;
COMMIT;
--
SELECT * FROM Information ORDER BY Id ASC;
--
--
--
--
--
USE application;
--
ALTER EVENT Addpartitions ENABLE;
--
ALTER EVENT Addpartitions DISABLE;
--
DROP EVENT IF EXISTS Addpartitions;
--
ALTER EVENT Updateage ENABLE;
--
ALTER EVENT Updateage DISABLE;
--
DROP EVENT IF EXISTS Updateage;
--
SET GLOBAL event_scheduler = OFF;
--
DROP TRIGGER IF EXISTS Update_Before_Information;
--
DROP TRIGGER IF EXISTS Insert_Before_Information;
--
DELETE FROM information;
COMMIT;
--
TRUNCATE TABLE information;
--
ALTER TABLE information REMOVE PARTITIONING;
--
ALTER TABLE information DROP CONSTRAINT salary_jobstatus_chk;
--
ALTER TABLE information DROP CONSTRAINT firstname_lastname_chk;
--
ALTER TABLE information DROP CONSTRAINT sex_chk;
--
ALTER TABLE information DROP CONSTRAINT age_chk;
--
ALTER TABLE information MODIFY id INTEGER NOT NULL;
--
ALTER TABLE information DROP INDEX datebirth_indx;
--
ALTER TABLE information DROP PRIMARY KEY;
--
DROP TABLE IF EXISTS information;
--
DROP DATABASE IF EXISTS application;