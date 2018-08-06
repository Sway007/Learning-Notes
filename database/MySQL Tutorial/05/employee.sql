drop database if exists employee;
create database employee;

use employee;

create table department
(
  department_id int not null auto_increment primary key,
  name varchar(20)  
) type=InnoDB;

create table employee
(
  employee_id int not null auto_increment primary key,
  name varchar(80),
  job varchar(15),
  department_id int not null references department(department_id)
) type=InnoDB;

create table employee_skills
(
  employee_id int not null references employee(employee_id),
  skill varchar(15) not null,
  primary key (employee_id, skill)
) type=InnoDB;

create table client
(
  client_id int not null auto_increment primary key,
  name varchar(40),
  address varchar(100),
  contact_person varchar(80),
  contact_number char(12)
) type=InnoDB;

create table assignment
(
  client_id int not null references client(client_id),
  employee_id int not null references employee(employee_id),
  workdate date not null,
  hours float,
  primary key (client_id, employee_id, workdate)
) type=InnoDB;