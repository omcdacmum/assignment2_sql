create database assignment2;

use assignment2;

 -- Create a table students with columns: id (INT), name (VARCHAR, NOT NULL), and age (INT with default 18)
 drop table students;
 create table students(
 id int not null ,
 name varchar(20) not null ,
 age int check(age>=18) default(18)
 );
 insert into students values(10,"om",19);
 select* from students;
 
 -- Q2.Insert into students: (1, NULL, 20). What will happen?
 
 insert into students values(1,null,20); -- colunmn name not null
 
 
 -- Q3.Insert into students: (2, 'Ravi'). What will be stored in age?
 
 insert into students values(2,"ravi"); -- count does not match column count
 
 -- Q4. Why will the following query fail? INSERT INTO students (id) VALUES (3);
  
  INSERT INTO students(id) VALUES (3); -- count does not match column count
  
   -- Q5.Modify the students table so that the age column default changes from 18 to 21.
   
 insert into students values(10,"om",default);
 select*from students;
 
 
 
 -- Q7.Create a table department with columns: dept_id (INT, PRIMARY KEY), dept_name (VARCHAR).
 
 create table department (
 dept_id int primary key,
 dept_name varchar(20)
 );
 -- Q8.Insert (1,'IT') and (1,'HR'). What error will you get?
 insert into department values((1,'IT'),(1,'HR')); -- you can not insert 
 
 -- Q9. Can a table have two PRIMARY KEYS? Demonstrate with a query.
-- no table can not nave two primary keys it can be unique and not null 

-- Q10.Create a table enrollment with composite primary key (student_id, course_id).

drop table enrollment;

-- Q11 
CREATE TABLE enrollment (
    stu_id INT,
    course_id INT,
    course_name VARCHAR(30),
    PRIMARY KEY (stu_id, course_id)
);

-- Valid insert
INSERT INTO enrollment (stu_id, course_id, course_name)
VALUES (101, 1, 'DBMS');

-- Invalid insert: same stu_id and course_id
INSERT INTO enrollment (stu_id, course_id, course_name)
VALUES (101, 1, 'DBMS');  -- ❌ This will throw a "Duplicate entry" error


-- Q12.Create a table users with columns: user_id (INT, PRIMARY KEY, AUTO_INCREMENT), email (VARCHAR, UNIQUE)

create TABLE users(
user_id int primary key auto_increment,
email varchar(20) unique
);
drop table users;
insert into users values(123,"abc@gmail.com");
select * from users;



-- Q13.Insert ('abc@mail.com') twice. What error occurs?
 insert into users values(124,"abc@gmail.com"); -- duplicate entry error

-- Q14.Does the following query work? Why?
INSERT INTO users (email) VALUES (NULL);
INSERT INTO users (email) VALUES (NULL);
-- unique can take null values

-- Q15.Create a table products with UNIQUE constraint on (sku, region).
CREATE TABLE products (
    product_id INT PRIMARY KEY,
    sku VARCHAR(20),
    region VARCHAR(30),
    UNIQUE (sku, region)  -- no duplicate SKU in the same region 
);
insert into products values(123,"sku123","mum"),(124,"sku123","pune"); -- valid

select * from products;


-- Q16.Insert (sku='A1', region='US') twice. What error? 

insert into products values(123,"sku123","mum"),(124,"sku123","mum"); -- notvalid

-- Q17.Create a table department with primary key dept_id. Then create employee table with foreign key dept_id referencing department.

create table dept
(
dept_id int primary key
);

create table emp_fk(
emp_id int primary key,
name varchar(30),
dept_id int,
foreign key (dept_id) references dept(dept_id)
on delete cascade
);


-- Q18.Insert into employee (emp_id=1, name='Asha', dept_id=99) when no such dept exists. What error?
INSERT INTO emp_fk VALUES (1, 'om', 99);


-- Q19.Delete dept_id=1 from department when employees exist. What error without ON DELETE CASCADE?

DELETE FROM emp_fk WHERE dept_id = 1;
DELETE FROM dept WHERE dept_id = 1;



-- Q20Recreate employee table with ON DELETE CASCADE. What happens if you delete department 1?

CREATE TABLE department (
  dept_id INT PRIMARY KEY,
  dept_name VARCHAR(50)
);

CREATE TABLE employee (
  emp_id INT PRIMARY KEY,
  emp_name VARCHAR(50),
  dept_id INT,
  FOREIGN KEY (dept_id) REFERENCES department(dept_id)
    ON DELETE CASCADE
);

INSERT INTO department VALUES (1, 'HR'), (2, 'Finance');
INSERT INTO employee VALUES (101, 'Om', 1), (102, 'Raj', 1), (103, 'Neha', 2);

delete from department where dept_id=1;
select * from employee;

-- Q21.Use ON DELETE SET NULL in the foreign key. What happens when parent is deleted?
drop table employee,department;
CREATE TABLE department (
  dept_id INT PRIMARY KEY,
  dept_name VARCHAR(50)
);

CREATE TABLE employee (
  emp_id INT PRIMARY KEY,
  emp_name VARCHAR(50),
  dept_id INT,
  FOREIGN KEY (dept_id) REFERENCES department(dept_id)
    ON DELETE set null
);
INSERT INTO department VALUES (1, 'HR'), (2, 'Finance');
INSERT INTO employee VALUES (101, 'Om', 1), (102, 'Raj', 1), (103, 'Neha', 2);

delete from department where dept_id=1;
select *  from employee;


-- 22 This removes the foreign key constraint but does not drop the column itself.
ALTER TABLE employee
DROP FOREIGN KEY dept_id;
-- This removes the foreign key constraint but does not drop the column itself.




-- Q23.Add a new foreign key constraint fk_manager in employee table referencing itself (manager_id).
ALTER TABLE employee
ADD COLUMN manager_id INT;
ALTER TABLE employee
ADD CONSTRAINT fk_manager
FOREIGN KEY (manager_id) REFERENCES employee(emp_id)
ON DELETE SET NULL
ON UPDATE CASCADE;





-- 24.Create table accounts with balance >= 0 using CHECK.
create table account(
id int primary key ,
balance int check (balance>=0)
);
drop table account;
insert into account values(0);-- it will give you error
insert into account values(10000);

 Insert into account values(id=1, balance=-100); -- it is adding the minus one
 select * from account;
 
 -- Q26.Modify the constraint so that balance must be between 100 and 1,000,000.
 drop table acc;
 create table acc(
id int primary key ,
balance int check (balance>=100 and balance <=1000000)
);

-- Q27.Try to insert (id=2, balance=50). What error do you get?

insert into acc values(1,50); -- constraint voilation

-- Q28.Create table invoices with invoice_id AUTO_INCREMENT PRIMARY KEY. Insert 3 rows. What will be the IDs?



create table invoices (

invoice_id int auto_increment primary key
);

insert into invoices values(1);
insert into invoices values(2);
insert into invoices values(3);

-- Q29.Delete last row. Insert again. Will AUTO_INCREMENT reuse the deleted number?

delete from invoices where invoice_id=3;
INSERT INTO invoices VALUES (DEFAULT);
select * from invoices;




-- Write queries to:
-- Add a UNIQUE constraint on phone column in users.
-- Drop the UNIQUE constraint from users.

create TABLE users(
user_id int primary key auto_increment,
email varchar(20) unique,
phone int unique
);	

ALTER TABLE users
ADD COLUMN name VARCHAR(50);
 
ALTER TABLE users
DROP INDEX phone;


-- Q31.Create a table library with a composite primary key 
-- (book_id, branch_id) and a UNIQUE constraint on (isbn, branch_id).

create table library (
book_id int ,
branch_id int ,
isbn varchar(50),
primary key(book_id,branch_id),
unique(isbn,branch_id)
);
-- Q32.Insert (book_id=1, branch_id=101, isbn='A123') twice. What error occurs?
insert into library values(1,101,"A123");
insert into library values(1,101,"A123");-- duplicate entry 1-101 primary key


-- Q33.Insert (book_id=1, branch_id=102, isbn='A123'). Will it work? Why?
insert into library values(1,102,"A123"); -- yes it works 

-- Q34.Can you have a table with PRIMARY KEY and multiple UNIQUE constraints? Write a query.
-- Absolutely — you can have a table with a PRIMARY KEY and multiple UNIQUE constraints
CREATE TABLE employees101 (
  emp_id INT PRIMARY KEY,
  email VARCHAR(50) UNIQUE,
  phone BIGINT,
  ssn CHAR(11),
  UNIQUE (phone),
  UNIQUE (ssn)
);


-- Q35.Try to create a table with both PRIMARY KEY(id) and UNIQUE(id). What happens?
CREATE TABLE employees102 (
  emp_id INT PRIMARY KEY,
  UNIQUE (emp_id)
);

-- PRIMARY KEY already implies:
-- NOT NULL
-- UNIQUE
-- So adding UNIQUE (emp_id) again is unnecessary.
-- MySQL won’t throw an error, but it will create two indexes:
-- One for the PRIMARY KEY
-- One for the UNIQUE constraint

-- Q36.Create table exam_results with composite primary key (student_id, exam_id) 
--  and CHECK constraint marks BETWEEN 0 AND 100.

create table exam_results(
student_id int,
exam_id int,
marks int ,
primary key(student_id,exam_id),
check (marks BETWEEN 0 AND 100)
);



-- Create table orders referencing customers with ON UPDATE CASCADE.
-- Update customer_id in parent – what happens in child?

create table customer(
customer_id int primary key,
name varchar(50)
);
create table orders(  
order_id int primary key,
customer_id int,
foreign key (customer_id) REFERENCES customer(customer_id)
on update cascade
);

-- Q38.Try to use ON DELETE SET DEFAULT in a foreign key. What happens in MySQL?
create table customer(
customer_id int primary key,
name varchar(50)
);
create table orders(  
order_id int primary key,
customer_id int,
foreign key (customer_id) REFERENCES customer(customer_id)
ON DELETE SET DEFAULT
);

-- MySQL will throw an error. It does not support ON DELETE SET DEFAULT.



-- Q39.Create a self-referencing foreign key categories(parent_id) referencing categories(id). Insert parent and child categories.

create table shivam(

id int primary key,
name varchar(50),
parent_id int,
foreign key (parent_id) references shivam(id)
);



-- Insert parent category
INSERT INTO shivam (id, name, parent_id) VALUES (1, 'Electronics', NULL);

-- Insert child categories
INSERT INTO shivam (id, name, parent_id) VALUES (2, 'Mobiles', 1);
INSERT INTO shivam (id, name, parent_id) VALUES (3, 'Laptops', 1);

select * from shivam;



-- Q40.What happens if you delete a parent row in categories without ON DELETE CASCADE?

create table parent(
pid int primary key,
name varchar(50)
);
create table child(
cid int primary key,
pid int,
foreign key (pid) references parent(pid)
on delete cascade
);

insert into parent values(1,"om");
insert into parent values(2,"abc");

insert into child values(1,2);
insert into child values(2,2);

delete from parent where pid=2;

select * from child;
select * from parent;

-- ON DELETE clause	Throws error

-- Q41.Write a query to temporarily disable foreign key checks and insert invalid data.

SET FOREIGN_KEY_CHECKS = 0;
INSERT INTO child (cid, pid) VALUES (99, 999); -- 999 doesn't exist in parent


-- Q42.Write a query to re-enable foreign key checks.
SET FOREIGN_KEY_CHECKS = 1;


-- Q43.Explain with a query why indexes are automatically created when foreign keys are added.

SHOW INDEX FROM child;


-- Q44.Create a table employees with CHECK that salary > 20000.

create table empcheck(
id int primary key,
salary int 
check (salary>20000)
);

-- Q45.Insert (id=1, salary=15000). What error code will you get?

Insert into empcheck values(1, 15000); -- voileted check


-- Q46.Add a CHECK constraint on gender column so only 'M' or 'F' is allowed.

alter table empcheck
add column gender varchar(1);

alter table empcheck
add constraint 
check (gender in ("m","f"));



-- Q47.Try inserting gender='X'. What happens?

insert into empcheck values(1,20002,"x"); -- voileated 

-- Q48.Add a foreign key constraint on employee.dept_id referencing department.dept_id.

CREATE TABLE department1 (
  dept_id INT PRIMARY KEY,
  dept_name VARCHAR(50)
);

CREATE TABLE employee1 (
  emp_id INT PRIMARY KEY,
  emp_name VARCHAR(50),
  dept_id INT,
  FOREIGN KEY (dept_id) REFERENCES department(dept_id)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);




ALTER TABLE department1
DROP PRIMARY KEY;


-- Q50.Rename a foreign key constraint fk_emp_dept to fk_employee_department.

ALTER TABLE employee1
DROP FOREIGN KEY fk_emp_dept;

ALTER TABLE employee1
ADD CONSTRAINT fk_employee_department
FOREIGN KEY (dept_id) REFERENCES department1(dept_id)
ON DELETE CASCADE
ON UPDATE CASCADE;
SHOW CREATE TABLE employee1;








































 
 
 

 
   
   
   
   
   
   
   

  

 
 
 
 

 
 