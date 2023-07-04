CREATE DATABASE projects;
USE projects;

SELECT * FROM hr;

-- Change emp_id column name
ALTER TABLE hr 
CHANGE COLUMN ï»¿id emp_id VARCHAR(20) NULL;

DESCRIBE hr;

SELECT birthdate FROM hr;

SET SQl_safe_updates=0;

-- Standardised date format for birthdate column
UPDATE hr 
SET  birthdate = CASE
	WHEN birthdate LIKE '%/%' THEN DATE_FORMAT(STR_TO_DATE(birthdate, '%m/%d/%Y'), '%Y-%m-%d')
	WHEN birthdate LIKE '%-%' THEN DATE_FORMAT(STR_TO_DATE(birthdate, '%m-%d-%Y'), '%Y-%m-%d')
	ELSE NULL
END;

ALTER TABLE hr
MODIFY COlUMN birthdate DATE;

-- Standardised date format for hire_date column
UPDATE hr
SET hire_date = CASE
	WHEN hire_date likE '%/%' THEN DAtE_FORMAT(STR_TO_DATE(hire_date, '%m/%d/%Y'), '%Y-%m-%d')
    WHEN hire_date LIKE '%-%' THEN DAtE_FORMAT(STR_TO_DATE(hire_date, '%m-%d-%Y'), '%Y-%m-%d')
    ELSE NULL
END;

ALTER TABLE hr
MODIFY COlUMN hire_date DATE;

-- standardised date format for termdate column
UPDATE hr
SET termdate = IF(termdate IS NOT NULL AND termdate != '', DATE(STR_TO_DATE(termdate, '%Y-%m-%d %H:%i:%s UTC')), '0000-00-00')
WHERE TRUE;

SELECT termdate FROM hr;

SET SQl_mode = 'ALLOW_INVALID_DATES';

ALTER TABLE hr
MODIFY COlUMN termdate DATE;

-- Add age column
ALTER TABLE hr
ADD COlUMN age INT;

UPDATE hr
SET age = timestampdiff(YEAR, birthdate, curdate());

SELECT age FROM hr;

SELECT 
	min(age) AS Youngest, 
    max(age) AS Oldest
FROM hr;

SELECT count(*) FROM hr WHERE age<18;