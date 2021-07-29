/*
    Name: Natalie Bedel
    DTSC660: Data and Database Managment with SQL
    Assignment 5
*/

--------------------------------------------------------------------------------
/*				                 Banking DDL           		  		          */
--------------------------------------------------------------------------------
CREATE TABLE branch (
	branch_name varchar(40),
	branch_city varchar(40),
	assets decimal(18,2),
CONSTRAINT branch_pkey PRIMARY KEY (branch_name)
);
	
CREATE TABLE customer(
	ID varchar(5) NOT NULL,
	customer_name varchar(40), 
	customer_street varchar(40), 
	customer_city varchar(40) DEFAULT 'Pittsburgh',
CONSTRAINT customer_pkey PRIMARY KEY (ID)
);

CREATE TABLE loan(
	loan_number varchar(9), 
	branch_name varchar(35), 
	amount decimal(18,2) CHECK (amount > 0.00), 
CONSTRAINT loan_pkey PRIMARY KEY (loan_number)
);

CREATE TABLE borrower(
	ID varchar(5) NOT NULL, 
	loan_number varchar(9),
CONSTRAINT borrower_pkey PRIMARY KEY (ID, loan_number),
CONSTRAINT borrower_fkey FOREIGN KEY (loan_number) REFERENCES loan (loan_number) ON DELETE CASCADE
);

CREATE TABLE account(
	account_number varchar(9), 
	branch_name varchar(35), 
	balance decimal(18,2) CHECK (balance > 0.00),
CONSTRAINT account_pkey PRIMARY KEY (account_number)
);

CREATE TABLE depositor(
	ID varchar(5) NOT NULL, 
	account_number varchar(9),
CONSTRAINT depositor_pkey PRIMARY KEY (ID, account_number),
CONSTRAINT depositor_fkey FOREIGN KEY (account_number) REFERENCES account (account_number)ON UPDATE CASCADE
);


--------------------------------------------------------------------------------
/*				                  Question 1           		  		          */
--------------------------------------------------------------------------------

CREATE OR REPLACE FUNCTION Calculate_Monthly_Payment(
	mortgage_amount BIGINT, 
	APR DECIMAL(18, 6), 
	years INTEGER)
	
RETURNS DECIMAL(18, 6)
LANGUAGE plpgsql
AS

$$

DECLARE i DECIMAL(18,6);
SET i = APR/12;
DECLARE n INTEGER;
SET n = years*12;

RETURN (mortage_amount *i * POWER(1+i,n)) / (POWER(1+i, n) - 1);

END
$$

--------------------------------------------------------------------------------
/*				                  Question 2           		  		          */
--------------------------------------------------------------------------------
INSERT INTO branch (branch_name, branch_city, assets)
VALUES ('Brooklyn Bank','Brooklyn','2506789.00');

INSERT INTO branch (branch_name, branch_city, assets)
VALUES ('First Bank of Brooklyn','Brooklyn','4738291.00');

INSERT INTO branch (branch_name, branch_city, assets)
VALUES ('Brooklyn Bridge Bank','Brooklyn','3216549.00');

INSERT INTO branch (branch_name, branch_city, assets)
VALUES ('Bronx Federal Credit Union','Bronx','1425365.00');

INSERT INTO branch (branch_name, branch_city, assets)
VALUES ('Big Bronx Bank','Bronx','5632897.00');

INSERT INTO branch (branch_name, branch_city, assets)
VALUES ('Upper East Federal Credit Union','Manhattan','9385274.00');

INSERT INTO branch (branch_name, branch_city, assets)
VALUES ('Yonkahs Bankahs','Yonkers','2356967.00');

-- Insert Values into customer --

INSERT INTO customer (ID, customer_name, customer_street, customer_city)
VALUES ('12345', 'Billy Boi', '123 Easy Street', 'Bronx');

INSERT INTO customer (ID, customer_name, customer_street, customer_city)
VALUES ('54321', 'Teddy Tiger', '56 East Baltimore Road', 'Brooklyn');

INSERT INTO customer (ID, customer_name, customer_street, customer_city)
VALUES ('98524', 'Betty Bench', '123 Easy Street', 'Bronx');

INSERT INTO customer (ID, customer_name, customer_street, customer_city)
VALUES ('24357', 'Walter Halter', '67 Stupid Street', 'Brooklyn');

INSERT INTO customer (ID, customer_name, customer_street, customer_city)
VALUES ('73194', 'Wendy Winks', '78 Gold Street', 'Harrison');

INSERT INTO customer (ID, customer_name, customer_street, customer_city)
VALUES ('74185', 'Lauren Lawn', '3 Gravy Avenue', 'Yonkers');

INSERT INTO customer (ID, customer_name, customer_street, customer_city)
VALUES ('95124', 'Peter Pretender', '85 West Fourth Road', 'Manhattan');

INSERT INTO customer (ID, customer_name, customer_street, customer_city)
VALUES ('86753', 'Susan Sits', '123 Easy Street', 'Bronx');

INSERT INTO customer (ID, customer_name, customer_street, customer_city)
VALUES ('77776', 'Hank Handles', '2 Ford Drive', 'Harrison');

-- Insert Values into loan

INSERT INTO loan (loan_number, branch_name, amount)
VALUES ('462882645', 'Brooklyn Bridge Bank', '7500.00');

INSERT INTO loan (loan_number, branch_name, amount)
VALUES ('888512347', 'Bronx Federal Credit Union', '11500.00');

INSERT INTO loan (loan_number, branch_name, amount)
VALUES ('646469321', 'Upper East Federal Credit Union', '8550.00');

INSERT INTO loan (loan_number, branch_name, amount)
VALUES ('774485962', 'Yonkahs Bankahs', '2000.00');

INSERT INTO loan (loan_number, branch_name, amount)
VALUES ('919137375', 'Brooklyn Bank', '5000.00');

-- Insert Values into borrower

INSERT INTO borrower (ID, loan_number)
VALUES ('54321','888512347');

INSERT INTO borrower (ID, loan_number)
VALUES ('95124','888512347');

INSERT INTO borrower (ID, loan_number)
VALUES ('24357','919137375');

INSERT INTO borrower (ID, loan_number)
VALUES ('77776','462882645');

INSERT INTO borrower (ID, loan_number)
VALUES ('98524','774485962');

-- Insert Values into account

INSERT INTO account (account_number, branch_name, balance)
VALUES ('142375689', 'First Bank of Brooklyn', '2003.64');

INSERT INTO account (account_number, branch_name, balance)
VALUES ('741852963', 'Yonkahs Bankahs', '5263.23');

INSERT INTO account (account_number, branch_name, balance)
VALUES ('159263487', 'Brooklyn Bank', '1425.98');

INSERT INTO account (account_number, branch_name, balance)
VALUES ('963852741', 'Upper East Federal Credit Union', '2598.36');

INSERT INTO account (account_number, branch_name, balance)
VALUES ('846275315', 'Brooklyn Bridge Bank', '688.12');

INSERT INTO account (account_number, branch_name, balance)
VALUES ('258258963', 'Bronx Federal Credit Union', '3256.21');

INSERT INTO account (account_number, branch_name, balance)
VALUES ('232154689', 'Big Bronx Bank', '4152.87');

INSERT INTO account (account_number, branch_name, balance)
VALUES ('222456197', 'Bronx Federal Credit Union', '1234.56');

INSERT INTO account (account_number, branch_name, balance)
VALUES ('774436581', 'Brooklyn Bank', '8259.34');

-- Insert Values into depositor

INSERT INTO depositor (ID, account_number)
VALUES ('77776', '774436581');

INSERT INTO depositor (ID, account_number)
VALUES ('24357', '222456197');

INSERT INTO depositor (ID, account_number)
VALUES ('86753', '232154689');

INSERT INTO depositor (ID, account_number)
VALUES ('74185', '258258963');

INSERT INTO depositor (ID, account_number)
VALUES ('12345', '142375689');

INSERT INTO depositor (ID, account_number)
VALUES ('73194', '741852963');

INSERT INTO depositor (ID, account_number)
VALUES ('12345', '846275315');

INSERT INTO depositor (ID, account_number)
VALUES ('77776', '963852741');

INSERT INTO depositor (ID, account_number)
VALUES ('12345', '159263487');

    ------------------------------- Part (a) ------------------------------
    SELECT ID, customer_name
	  FROM customer, loan, account
	  WHERE loan.loan_number IS NOT NULL AND account.account_number IS NULL;  
    ------------------------------- Part (b) ------------------------------
	
	SELECT ID, customer_name
	  FROM customer
	  WHERE customer_street IN
	  	(SELECT customer_street
		FROM customer
		WHERE customer.ID = '12345');


    ------------------------------- Part (c) ------------------------------
        SELECT branch_name
		FROM branch
		WHERE branch_city IN
			(SELECT branch_city
			FROM branch
			WHERE branch.branch_city = 'Harrison');

    ------------------------------- Part (d) ------------------------------
 	SELECT customer_name
	FROM customer, branch
	WHERE branch_city IN
		(SELECT customer_name
		FROM customer, branch
		WHERE branch_city = 'Brooklyn')

--------------------------------------------------------------------------------
/*				                  Question 3           		  		          */
--------------------------------------------------------------------------------

    --  Erase this comment, and paste your solution here.

--------------------------------------------------------------------------------
/*				                  Question 4           		  		          */
--------------------------------------------------------------------------------

CREATE TABLE instructor_course_nums (instructor_id number, name varchar2(100),total_course_t number);

CREATE TABLE instructor (id number,name varchar2(100),dept_name varchar2(100),salary number);

CREATE TABLE teaches (id number, course_id number,sec_id number, semester varchar2(100),year number);

INSERT INTO teaches values (1,1,1,1,2020);
INSERT INTO teaches values (1,2,2,1,2020);
INSERT INTO teaches values (1,3,2,1,2020);
COMMIT;

CREATE OR REPLACE PROCEDURE calculate_instr_course (p_instructor_id number)
AS 
l_instructor_name varchar2(100);
l_courses number;
l_exist_Count number;
BEGIN
SELECT name INTO l_instructor_name FROM instructor WHERE id = p_instructor_id;
SELECT COUNT(*) INTO l_courses FROM teaches WHERE id = p_instructor_id;

SELECT COUNT (*) INTO l_Exist_count FROM instructor_course_nums WHERE instructor_id= p_instructor_id;

IF l_Exist_count > 0
THEN
UPDATE instructor_course_nums
SET total_course_t = l_courses
WHERE instructor_id = p_instructor_id;
ELSE
INSERT INTO instructor_course_nums values (p_instructor_id,l_instructor_name,l_courses);
END IF;

COMMIT;

EXEC calculate_instr_course (1);