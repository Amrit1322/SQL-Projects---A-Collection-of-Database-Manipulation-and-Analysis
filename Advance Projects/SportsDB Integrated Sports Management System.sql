


     /*1. Create a scalar function that receives a parameter for OrderID and returns the total cost of the
      entire order, as calculated from the SportOrderDetail table (quantity * price, added up for all items
      on the order).*/

	 CREATE FUNCTION fn_CalcOrderdetail
		(@orderID INT)
		RETURNS DECIMAL(6,2)
		AS
		BEGIN

		  DECLARE @output DECIMAL(6,2)

		  SELECT @output =  SUM(DetailQuantity * DetailUnitPrice)
		  FROM SportOrderDetail
		  WHERE OrderID = @orderID

		  RETURN @output

		END
		GO


		/*2. To test your function, write a SELECT statement which displays the OrderID, OrderDate, and
        OrderNetTotal from the SportOrder table, along with a calculated column named "CalculatedTotal"
        which uses the function from question 1 to calculate and display the totals.*/


		SELECT  OrderID, OrderDate,OrderNetTotal,dbo.fn_CalcOrderdetail(OrderID) AS [Total]
	   FROM SportOrder
	   GO

	   /*3. Create the necessary triggers on the SportOrderDetail table, needed to automatically maintain the
       correct value in SportOrder.OrderNetTotal whenever an action query is performed on
      SportOrderDetail (i.e. any INSERT, UPDATE, or DELETE of Detail records). Hint: your triggers can
       make use of your function from question 1.*/

	    CREATE TRIGGER tr_OrderDetails
	    ON  SportOrderDetail
	    AFTER INSERT, UPDATE, DELETE
	    AS    

	    SELECT * FROM inserted
	    SELECT  OrderID, OrderDate,OrderNetTotal,dbo.fn_CalOrderID(OrderID) AS [CalculatedTotal]
	    FROM SportOrder

	    GO

		/*4. Create a set of standard stored procedures for the SportEmployee table. This includes writing
         SelectAll, SelectByID, Insert, Update, and Delete procedures. Ensure that your standard stored
           procedures follow the guidelines and conventions discussed in class*/

     --a
        CREATE PROCEDURE usp_SportEmployeeSelectAll

		AS
		BEGIN
			SET NOCOUNT ON
			SELECT [EmployeeID],[EmployeeLastName], [EmployeeFirstName], [EmployeeMI], [EmployeeDOB], [EmployeeManagerID], [EmployeeHireDate], [EmployeeHomePhone], [EmployeePhotoFilename], [EmployeePhotoBinary], [EmployeeCommission], [DepartmentID],[EmployeeUsername]
			FROM SportEmployee
		END
		GO



	--b
		CREATE PROCEDURE usp_SportEmployeeSelectByID
		@employeeID INT
		AS
		BEGIN
			SET NOCOUNT ON
			SELECT *
			FROM SportEmployee
			WHERE EmployeeID = @employeeID
		END
		GO

		--c

		  CREATE PROCEDURE usp_SportEmployeeInsert
		   @EmployeeLastName VARCHAR(30),
		   @EmployeeFirstName VARCHAR(30) = NULL,
		   @EmployeeMI VARCHAR(30) = NULL,
		   @EmployeeDOB DATETIME = NULL,
		   @EmployeeManagerID BIGINT = NULL,
		   @EmployeeHireDate DATETIME = NULL,
		   @EmployeeHomePhone VARCHAR(20) = NULL,
		   @EmployeePhotoFilename VARCHAR(30) = NULL,
		   @EmployeePhotoBinary IMAGE = NULL,
		   @EmployeeCommission DECIMAL(18,0),
		   @DepartmentID BIGINT = NULL,
		   @EmployeeUsername VARCHAR(35) = NULL,
		   @EmployeePassword VARCHAR(20) = NULL,
		   @EmployeeID BIGINT OUTPUT
		AS

		BEGIN

		   SET NOCOUNT OFF

		   INSERT INTO SportEmployee (EmployeeLastName,EmployeeFirstName, EmployeeMI,EmployeeDOB,EmployeeManagerID,
		   EmployeeHireDate,EmployeeHomePhone,EmployeePhotoFilename,EmployeePhotoBinary,EmployeeCommission,DepartmentID,
		   EmployeeUsername,EmployeePassword)

			VALUES (@EmployeeLastName,@EmployeeFirstName,@EmployeeMI,@EmployeeDOB,@EmployeeManagerID,@EmployeeHireDate,
			@EmployeeHomePhone,@EmployeePhotoFilename,@EmployeePhotoBinary,@EmployeeCommission,@DepartmentID,
			@EmployeeUsername,@EmployeePassword)

		   SELECT @EmployeeID = SCOPE_IDENTITY() WHERE @@ROWCOUNT = 1
		END
		GO