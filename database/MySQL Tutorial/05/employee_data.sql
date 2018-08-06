use employee;

delete from department;
insert into department values
(42, 'Finance'),
(128, 'Research and Development'),
(NULL, 'Human Resources'),
(NULL, 'Marketing');

delete from employee;
insert into employee values
(7513,'Nora Edwards','Programmer',128),
(9842, 'Ben Smith', 'DBA', 42),
(6651, 'Ajay Patel', 'Programmer', 128),
(9006, 'Candy Burnett', 'Systems Administrator', 128);


delete from employee_skills;
insert into employee_skills values
(7513, 'C'),
(7513, 'Perl'),
(7513, 'Java'),
(9842, 'DB2'),
(6651, 'VB'),
(6651, 'Java'),
(9006, 'NT'),
(9006, 'Linux');

delete from client;
insert into client values
(NULL, 'Telco Inc', '1 Collins St Melbourne',  'Fred Smith', '95551234'),
(NULL, 'The Bank', '100 Bourke St Melbourne',  'Jan Tristan', '95559876');

delete from assignment;
insert into assignment values
(1, 7513, '2003-01-20', 8.5);