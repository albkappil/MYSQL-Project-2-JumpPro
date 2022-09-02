use sakila;

create table EmployeeInfo(
	EmpID int not NULL AUTO_INCREMENT PRIMARY Key,
    EmpFname VARCHAR(20),
    EmpLname VARCHAR(20),
    Department VARCHAR(20),
    Project VARCHAR(20),
    Address VARCHAR(20),
    DOB DATE,
    Gender VARCHAR(1)
);
create table EmployeePositions(
	EmpID int not NULL,
    EnpPosition VARCHAR(20),
    DateOfJoining DATE,
    Salary CHAR(20),
	foreign key(EmpID) references EmployeeInfo(EmpID)
	on delete cascade
	on update cascade
);

insert into EmployeeInfo(EmpFname, EmpLname, Department, Project, Address, DOB, Gender )
	values('Sanjay', 'Mehra', 'HR', 'P1', 'Hyderabad(HYD)', '1976-1-12', 'M'),
	('Ananya', 'Mishra', 'Admin', 'P2', 'Dehil(DEL)', '1968-02-05', 'F'),
    ('Rohan', 'Diwan', 'Account', 'P3', 'Mumbai(BOM)', '1980-01-01', 'M'),
    ('Sonia', 'Kulkkarni', 'HR', 'P1', 'Hyderabad(HYD)', '1992-02-05', 'F'),
    ('Ankit', 'Kapoor', 'Admin', 'P2', 'Dehil(DEL)', '1994-03-07', 'M');

insert into EmployeePositions(EmpID,EnpPosition, DateOfJoining, Salary)
		VALUES(1, 'Manager', '2022-01-05', 500000),
        (2, 'Executive', '2022-02-05', 75000),
        (3, 'Manager', '2022-01-05', 90000),
        (2, 'Lead', '2022-02-05', 85000),
        (1, 'Executive', '2022-01-05', 300000);
        
        

SELECT UPPER(EmpFname) AS EmpName From EmployeeInfo ;

SELECT COUNT(*) FROM EmployeeInfo Where Department = 'HR';

SELECT DateOfJoining From EmployeePositions;

SELECT substring(EmpLname, 1, 4) As EmpAbv From EmployeeInfo;

SELECT LEFT(Address,LOCATE('(',Address) - 1) From EmployeeInfo;

CREATE TABLE TabEmployeeInfo2 AS
SELECT  EmpFname, EmpLname, Department, Project, Address, DOB, Gender From EmployeeInfo;

Select * From EmployeeInfo WHERE Salary BETWEEN 50000 AND 100000;

SELECT EmpFname From EmployeeInfo Where substring(EmpFname,1,1) = 'S';

SELECT * From EmployeeInfo LIMIT 2;

SELECT CONCAT(EmpFname, ' ' , EmpLname) As FullName From EmployeeInfo;

Select * From EmployeeInfo Where DOB Between 1970-02-05 And 1975-31-12 Group by Gender;

Select * From EmployeeInfo Order by EmpLname DESC , Department ASC;

Select * From EmployeeInfo WHERE EmpLname REGEXP '^[a-zA-Z]{4}a$';

Select * From EmployeeInfo WHERE not EmpFname = "Sanjay" AND not EmpFname = "Sonia";

Select * From EmployeeInfo WHERE Address = "Dehil(DEL)" ;

Select * From EmployeeInfo WHERE Address = "Dehil(DEL)" ;

Select * From EmployeeInfo WHERE EmpID IN (Select EmpID From EmployeePositions WHERE EnpPosition = "Manager");

Select Department, COUNT(*) AS DeptCount From EmployeeInfo GROUP BY Department order by DeptCount ASC;

Select COUNT(EmpID) AS odd From EmployeeInfo GROUP BY Department order by DeptCount ASC;

SELECT Count(*) as EvenIDS FROM EmployeeInfo WHERE (EmpID % 2) = 0; # even
SELECT Count(*) as OddIDS FROM EmployeeInfo WHERE (EmpID % 2) > 0; # odd

Select * From EmployeeInfo WHERE EmpID IN (Select EmpID From EmployeePositions WHERE EXISTS (Select DateOfJoining From EmployeePositions)  );


select
  (SELECT MAX(Salary) FROM EmployeePositions) maxsalary,
  (SELECT MAX(Salary) FROM EmployeePositions
  WHERE Salary NOT IN (SELECT MAX(Salary) FROM EmployeePositions )) as 2nd_max_salary;
  
select
  (SELECT MIN(Salary) FROM EmployeePositions) minsalary,
  (SELECT MIN(Salary) FROM EmployeePositions
  WHERE Salary NOT IN (SELECT MIN(Salary) FROM EmployeePositions )) as 2nd_min_salary;
  
  Set @N:=5;
SELECT * FROM EmployeePositions Emp1 
WHERE (@N-1) = ( 
    SELECT COUNT(DISTINCT(Emp2.Salary)) 
    FROM  EmployeePositions Emp2 
    WHERE Emp2.Salary > Emp1.Salary);

#Duplicate Departments    
Select Department, COUNT(Department) FROM EmployeeInfo GROUP BY Department HAVING COUNT(Department) > 1;
  
Select DISTINCT * From EmployeeInfo E1,EmployeeInfo E2 WHERE E1.Department = E2.Department And E1.EmpID != E2.EmpID; 

Select * FROM EmployeeInfo WHERE EmpID >= 3 
Union
Select * FROM 
	(Select * FROM EmployeeInfo E1 ORDER BY E1.EmpID DESC) as E2
WHERE E2.EmpID >= 3;


SELECT Salary FROM EmployeePositions Emp1 
WHERE (3-1) = ( 
    SELECT COUNT(DISTINCT(Emp2.Salary)) 
    FROM  EmployeePositions Emp2 
    WHERE Emp2.Salary > Emp1.Salary);
    
Select * From EmployeeInfo WHERE EmpID = 1 union
Select * From EmployeeInfo WHERE EmpID = (Select Max(EmpID) From EmployeeInfo) ;   

SELECT Department, COUNT(EmpID) as EmpNum From EmployeeInfo Group by Department Having COUNT(EmpID) < 2;

SELECT EnpPosition, Sum(Salary) From EmployeePositions GROUP BY EnpPosition;

select *
from (select t.*, ntile(2) over(order by EmpID) nt from EmployeeInfo t) t
where nt = 1;
