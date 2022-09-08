use sakila;

create table EmployeeDetails(
	EmpID int not NULL PRIMARY Key,
    EmpFullname VARCHAR(20),
    ManagerId int,
	DateOfJoining DATE,
    City VARCHAR(20)
);
create table EmployeeSalary(
	EmpID int not NULL,
    Project VARCHAR(2),
    Salary CHAR(20),
    Variable int,
	foreign key(EmpID) references EmployeeDetails(EmpID)
	on delete cascade
	on update cascade
);

insert into EmployeeDetails(EmpID, EmpFullname, ManagerId, DateOfJoining, City )
	values(121, 'John Snow', 321, '2014-01-31', "Toronto"),
	(321, 'Walter White', 986, '2015-01-30', "California"),
    (421, 'Kuldeep Rana', 876, '2016-11-27', "New Delhi"),
    (422, 'sam Rana', 872, '2016-10-27', "Plano"),
    (423, 'john Rana', 872, '2016-12-27', "Plano");
   

insert into EmployeeSalary(EmpID,Project, Salary, Variable)
		VALUES(121,'P1' , 8000, 500),
        (321, 'P2' , 10000, 1000),
        (421, 'P1', 12000, 0),
       (422, 'P4', 13000, 0),
        (423, 'P3', 13000, 0);
        
        
#1 
SELECT * From EmployeeDetails Where City = "California" OR ManagerId = 321;
#2
Select * From EmployeeDetails WHERE EmpFullname REGEXP '^[a-zA-Z0-9]{2}hn*';
#3
Select EmpID From EmployeeDetails WHERE EmpID in (Select EmpID From EmployeeSalary);
#4
Select EmpFullName, 
CHAR_LENGTH(EmpFullName) - CHAR_LENGTH( REPLACE ( EmpFullName, 'n', '') ) 
        AS `count` 
From EmployeeDetails;
#5
Select * From EmployeeSalary WHERE Salary BETWEEN 5000 AND 10000;
#6
Select * From EmployeeDetails WHERE Exists (Select Salary From EmployeeSalary);
#7
SELECT  EmployeeDetails.EmpFullName, EmployeeSalary.Salary 
From EmployeeDetails
Cross JOIN EmployeeSalary ON EmployeeDetails.EmpID = EmployeeSalary.EmpID;
#8
Select * From EmployeeDetails WHERE EmpID in (Select ManagerId From EmployeeDetails);
#9
DELETE t1 FROM EmployeeSalary t1, EmployeeSalary t2 WHERE t1.Salary = t2.Salary AND t1.EmpID > t2.EmpID;

Set @N:=5;
SELECT Salary FROM EmployeeSalary Emp1 
WHERE (@N-1) = ( 
    SELECT COUNT(DISTINCT(Emp2.Salary)) 
    FROM  EmployeeSalary Emp2 
    WHERE Emp2.Salary < Emp1.Salary);

SELECT Salary FROM EmployeeSalary Emp1 
WHERE (3-1) = ( 
    SELECT COUNT(DISTINCT(Emp2.Salary)) 
    FROM  EmployeeSalary Emp2 
    WHERE Emp2.Salary < Emp1.Salary);

