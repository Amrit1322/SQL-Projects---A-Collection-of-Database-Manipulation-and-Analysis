--NAME- Amritpal Singh
--DATE- 16-02-2022
--LAB2T-SQL Programming
--create and use a new database
USE master
GO

IF  EXISTS (SELECT name FROM sys.databases WHERE name = N'username_Company')
BEGIN
	ALTER DATABASE username_Company
	SET OFFLINE WITH ROLLBACK IMMEDIATE
	ALTER DATABASE username_Company
	SET ONLINE
	DROP DATABASE username_Company
END
GO

CREATE DATABASE username_Company
GO

USE username_Company
GO


--drop the tables if they already exist
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[EMPLOYEE]') AND type in (N'U'))
	DROP TABLE [dbo].[EMPLOYEE]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DEPARTMENT]') AND type in (N'U'))
	DROP TABLE [dbo].[DEPARTMENT]
GO

CREATE TABLE DEPARTMENT
(
	deptCode	CHAR(4)				PRIMARY KEY,
	deptName	VARCHAR(30)			NOT NULL,
	deptBudget	DECIMAL(10,2)		
)
INSERT INTO DEPARTMENT 
	(deptCode, deptName, deptBudget) 
VALUES 
	('ACCT','Accounting',200000),
	('ISYS','Information Systems',500000),
	('MKTG','Marketing',170000),
	('PERS','Personnel',80000);

CREATE TABLE EMPLOYEE
(
	empID		INT IDENTITY(1,1)	PRIMARY KEY,
	empFirst	VARCHAR(25)			NOT NULL,
	empLast		VARCHAR(30)			NOT NULL,
	empTitle	VARCHAR(25),
	empSalary	DECIMAL(9,2),		
	empStart	DATE,
	deptCode	CHAR(4)				REFERENCES DEPARTMENT(deptCode)		
)
INSERT INTO EMPLOYEE 
	(empFirst, empLast, empTitle, empSalary, empStart, deptCode)
VALUES 
	('Marissa','Greene','Accountant',59000,'1991/6/6', 'ACCT'),
	('Ethan','Black','Analyst',75000,'1989/10/2', 'ISYS'),
	('Robert','Jones','Programmer',47000,'1981/11/3', 'ISYS'),
	('Lisa','Malette','Manager',85000,'1995/9/6', 'ACCT'),
	('Miles','Franklin','Admin Assistant',50500,'1990/7/9', 'ACCT'),
	('Clara','Albertson','Technician',46000,'1984/1/1', 'ISYS'),
	('Vera','Bartlett','Manager',60000,'1996/9/10', 'MKTG'),
	('Ned','Horton','Programmer',100001,'1990/10/9', 'ISYS')


	--1. Create a User-Defined Data Type to represent a "Last Evaluation Date". This data type will be used to store the date at which the record was last evaluated. Values for this type must be dates between March 1, 1980 and today's date. The field values may be null, and newly inserted values 
	--should default to March 1, 1980. Complete all the steps required to create this UDDT and its associated objects.

	CREATE TYPE [LastEvaluationDate]
			FROM DATE 
			GO

			CREATE RULE evaluation
			AS
			   @a BETWEEN '1980/03/01' AND GETDATE() 
			GO

			EXECUTE sp_bindrule 'evaluation','LastEvaluationDate'

			CREATE DEFAULT def_evaluation
			AS 
			   '1980/03/01'
			GO

			EXECUTE sp_bindefault 'def_evaluation','LastEvaluationDate'


--2. Add a deptEvaluation column to the existing Department table. This new field should use your
--UDDT from question 1. Do not drop and re-create the table – instead, alter what already exists.
---After adding the new column, insert the following record into the table:
---Code: SALE Name: Sales Budget: $450,000.00
----Write a SELECT statement to display all Department records, for verification.

        ALTER TABLE DEPARTMENT
			ADD deptEvaluation [LastEvaluationDate]

			INSERT INTO DEPARTMENT 
			   (deptCode, deptName, deptBudget) 
			VALUES 
			   ('SALE','Sales',450000)

			   SELECT deptCode, deptName, deptBudget,deptEvaluation
			FROM DEPARTMENT

--3. Create a Computed Column in the Employee table to represent the employee's Union Dues. This
--column calculates the employee's union dues as 5% of their salary. It should not persist in the
--table. Write a SELECT statement to display the employee information including the union dues, as
--shown in the query output. Format the money values as currency.

        ALTER TABLE EMPLOYEE
			ADD empUnionDues AS empSalary * 0.05

			SELECT empFirst,empLast,empTitle,empSalary,empUnionDues
			FROM EMPLOYEE

		

--4. Declare two variables which store: a) the Accounting department's budget, and b) the total of all
--employee salaries for those who work in Accounting. Then, use these variables to calculate the
--percentage of budget that is being used for employee pay.
--For example, if the budget is $80,000 and employees are paid a total of $55,000, the percentageis 68.75%.
--Write T-SQL logic to respond as follows: If that amount is greater than 90%, generate an error
--which indicates that this department is approaching budget limitations. Otherwise, display the
--remaining amount in a SELECT result.
--After executing this code for the Accounting department, change it to the Information Systems
---department and execute again. Results for both are displayed below.

--A

DECLARE @dept_budget DECIMAL(12,2)
			 DECLARE @total_salaries DECIMAL(12,2)

			 SELECT @dept_budget = deptBudget 
			 FROM DEPARTMENT
			 WHERE deptCode ='ACCT'

			 SELECT @total_salaries = sum(empSalary) 
			 FROM EMPLOYEE
			 WHERE deptCode ='ACCT'

			 SET @dept_budget = @total_salaries / @dept_budget * 100

			 IF (@dept_budget > 90)
			  PRINT 'Department is approaching Budget Limitations'
			 ELSE 
			  SELECT @dept_budget AS PercentRemaining

	--B

	DECLARE @dept_budget DECIMAL(12,2)
			 DECLARE @total_salaries DECIMAL(12,2)

			 SELECT @dept_budget = deptBudget 
			 FROM DEPARTMENT
			 WHERE deptCode ='ISYS'

			 SELECT @total_salaries = sum(empSalary) 
			 FROM EMPLOYEE
			 WHERE deptCode ='ISYS'

			 SET @dept_budget = @total_salaries / @dept_budget * 100

			 IF (@dept_budget > 90)
			  PRINT 'Department is approaching Budget Limitations'
			 ELSE 
			  SELECT @dept_budget AS PercentUsed


--5. a) Write a query to display all records from the Department table, and include the two calculated
--fields (these are NOT computed columns) as below: (replace NULLs with 0)
--• TotalPay – the total amount paid to all employees in this department
--• LeftOver – the amount remaining when subtracting a department's total pay from its budget
      

			SELECT Dmp.deptCode, Dmp.deptName, deptBudget, deptEvaluation ,ISNULL(SUM(Emp.empSalary),0)AS [TotalPay],ISNULL((deptBudget-SUM(Emp.empSalary)),0) AS [LeftOver]
			FROM DEPARTMENT Dmp LEFT JOIN EMPLOYEE Emp
			ON Dmp.deptCode = Emp.deptCode 
			GROUP BY Dmp.deptName,deptBudget,Dmp.deptCode ,deptEvaluation
			ORDER BY Dmp.deptName

--b) Select from this query (as a subquery) in order to display information about departments having
--more than $100,000 left in their budget. Format the money values as Currency.  
			SELECT  Dmp.deptName, deptBudget ,ISNULL(SUM(Emp.empSalary),0)AS [TotalPay],ISNULL((deptBudget-SUM(Emp.empSalary)),0) AS [LeftOver]
			FROM DEPARTMENT Dmp LEFT JOIN EMPLOYEE Emp
			WHERE (deptBudget-SUM(Emp.empSalary)) > 100,000
