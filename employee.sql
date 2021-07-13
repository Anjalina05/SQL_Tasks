create database employees_database;

drop database employees_database;

## Creating the Tables ##
create table  employees_database.department
(
dept_id int not null auto_increment primary key,
dept_name varchar(20)
);

drop table employees_database.department;

create table  employees_database.bonus 
(
emp_id int not null references employee(employeeID),
bonus_year timestamp,
bonus_amount int(10)
);

drop table employees_database.bonus;

create table  employees_database.employees 
(
emp_id int not null auto_increment primary key,
emp_name varchar (20),
salary int (10) ,
joining_date timestamp,
dept_id int not null references department(departmentID)
);

drop table employees_database.employees;

alter table employees_database.employees add constraint fk_department_id FOREIGN KEY(dept_id)
references employees_database.department(dept_id)
;
alter table employees_database.bonus add constraint fk_employee_id FOREIGN KEY(emp_id)
references employees_database.employees(emp_id)
;

## Showing the empty table ##
select * from employees_database.employees;
select * from employees_database.bonus;
select * from employees_database.department;

## Inserting values ##
insert into employees_database.department values('01','IT'),('02','HR'),('03','Operations');
insert into employees_database.employees values('101', 'joy','10000','2010-01-19 03:14:07','01'),('102', 'sam','20000','2010-08-05 02:04:07','02'),('103', 'happy','10000','2008-01-10 09:14:07','02'),('104', 'harry','14000','2001-01-19 03:14:07','01'),('105', 'elly','20000','2009-10-20 02:14:08','03'),('106', 'joyce','25000','2010-05-04 02:10:07','03'),('107','meghan','35000','2008-12-08 01:10:05','01'),('108', 'eliza','25000','2008-01-19 03:14:07','01'),('109', 'ryan','28000','2000-06-28 10:15:07','01'),('110', 'jammy','21000','2008-02-19 10:14:07','01');
insert into employees_database.bonus values('103','2008-01-10 09:14:07','10000'),('103','2010-01-10 12:13:11','8530'),('105','2009-10-10 02:14:08','5000'),('105','2010-01-10 12:13:11','2500'),('105','2013-01-12 09:10:07','2690'),('106','2010-01-10 12:13:11','8000'),('103','2007-04-10 04:14:07','7000'),('107','2013-01-12 09:10:07','9000'),('103','2010-01-10 12:13:11','4500');

## Showing the table ##
select * from employees_database.employees;
select * from employees_database.bonus;
select * from employees_database.department;

                                                           ## ASSIGNMENT 1 ##

# 1. Employee Count, Average Salary by Department   
select dept_name, count(*), avg(salary) from employees_database.employees e inner join employees_database.department d
where e.dept_id = d.dept_id 
group by e.dept_id;

# 2. List of Employees getting highest salary in department
select dept_name, emp_name, salary from employees_database.employees e inner join employees_database.department d
on e.dept_id = d.dept_id where 
(e.dept_id, salary) in 
(select dept_id, max(salary) from employees_database.employees where dept_id = e.dept_id 
group by e.dept_id);

# 3. List of Employee getting highest bonus by year
select bonus_year, emp_name, max(bonus_amount) from employees_database.bonus b left join employees_database.employees e
on b.emp_id = e.emp_id
group by year(bonus_year);
                                                     