
-- create
CREATE TABLE EMPLOYEE (
  empId INTEGER PRIMARY KEY,
  name TEXT NOT NULL,
  dept TEXT NOT NULL
);

-- insert
INSERT INTO EMPLOYEE VALUES (0001, 'Clark', 'Sales');
INSERT INTO EMPLOYEE VALUES (0002, 'Dave', 'Accounting');
INSERT INTO EMPLOYEE VALUES (0003, 'Ava', 'Sales');

-- fetch 
SELECT * FROM EMPLOYEE WHERE dept = 'Sales';

-- Create departments table
CREATE TABLE departments (
id INT AUTO_INCREMENT PRIMARY KEY,
name VARCHAR(100)
);
-- Insert sample data into departments table
INSERT INTO departments (name) VALUES
('IT'),
('HR'),
('Finance'),
('Marketing'),
('Operations');
-- Create employees table
CREATE TABLE employees (
id INT AUTO_INCREMENT PRIMARY KEY,
name VARCHAR(100),
age INT,
department_id INT,
joining_date DATE,
FOREIGN KEY (department_id) REFERENCES departments(id)
);
-- Insert sample data into employees table with 10000 employees
INSERT INTO employees (name, age, department_id, joining_date)
SELECT
CONCAT('Employee', numbers.number),
25 + MOD((tens.a-1) * 10 + (hundreds.a-1) * 100 + numbers.number*numbers.number, 30), -- age between 25 and 54
1 + MOD((tens.a-1) * 10 + (hundreds.a-1) * 100 + numbers.number, 5), -- department_id between 1 and 5
DATE_SUB(CURDATE(), INTERVAL (tens.a-1) * 10 + (hundreds.a-1) * 100 + numbers.number DAY) -- joining_date within the last year
FROM
(SELECT 1 AS number
UNION ALL SELECT 2
UNION ALL SELECT 3
UNION ALL SELECT 4
UNION ALL SELECT 5
UNION ALL SELECT 6
UNION ALL SELECT 7
UNION ALL SELECT 8
UNION ALL SELECT 9
UNION ALL SELECT 10) AS numbers
CROSS JOIN
(SELECT 1 AS a
UNION ALL SELECT 2
UNION ALL SELECT 3
UNION ALL SELECT 4
UNION ALL SELECT 5
UNION ALL SELECT 6
UNION ALL SELECT 7
UNION ALL SELECT 8
UNION ALL SELECT 9
UNION ALL SELECT 10) AS tens
CROSS JOIN
(SELECT 1 AS a
UNION ALL SELECT 2
UNION ALL SELECT 3
UNION ALL SELECT 4
UNION ALL SELECT 5
UNION ALL SELECT 6
UNION ALL SELECT 7
UNION ALL SELECT 8
UNION ALL SELECT 9
UNION ALL SELECT 10) AS hundreds;
-- Write a query to calculate the average age of employees in each department.
-- Write a query to find the department with the highest number of employees whose age is above 40.
-- Write a query to retrieve the count of employees who have in joined in last 100 days.
-- Write a query to update the joining date of all employees in the HR department to the yesterday.
-- Write a query to retrieve the count of employees who have in joined in last 100 days.
SELECT d.name as department_name,avg(e.age) as average_age 
FROM employees e join departments d on e.department_id = d.id
group by d.name;

with high_dep_cnt as(select d.name as department_name,count(*) as employee_count_abv_40 from employees e join departments d on e.department_id = d.id
where  e.age>40
group by d.name
order by count(*) desc)
select * from high_dep_cnt where employee_count_abv_40=(select max(employee_count_abv_40) from high_dep_cnt;

select count(*) as employee_count from employees
where joining_date>=CURDATE()- INTERVAL 100 DAY;

with department_id as(select e.department_id from employees e join departments d on e.department_id = d.id where d.name='HR' limit 1)
update employees
set joining_date = CURDATE() - INTERVAL 1 DAY
where department_id in (select department_id from department_id);

select count(*) as employee_count from employees
where joining_date>=CURDATE()- INTERVAL 100 DAY;
