USE Pizza_test
go

DROP PROCEDURE usp_createCustomerOrder 
GO

DROP TYPE itemsListType
go



CREATE TYPE itemsListType AS TABLE
(
itemNo INT NOT NULL,
quantity INT NOT NULL,
disProCode varchar(20))
go

CREATE PROCEDURE usp_createCustomerOrder 
	@customerId INT, 
	@iList itemsListType READONLY, -- input is TVP
	@fulfilmentType VARCHAR(20),
	@OrderType VARCHAR (20),
	@employeeID INT,
	@orderDate DATE,
	@orderTime TIME,
	@deliveryAddress VARCHAR(250),
	@EOFDate DATE,
	@EOFTime TIME,
	@orderNo INT OUTPUT

AS	
BEGIN
	DECLARE @tax DECIMAL(5,2)
	DECLARE @totalAmountDue DECIMAL(5,2)
	DECLARE @id INT
	
	INSERT INTO Orders VALUES (@customerId, @orderDate, @orderTime, @employeeID, NULL, NULL,NULL, NULL, 'Processing','Online','No tomato','Card', @EOFDate, @EOFTime);
	
	DECLARE @Subtotal DECIMAL(5,2) = (SELECT SUM(md.price) FROM @iList i, MenuItemDetails md WHERE i.itemNo=md.ItemNO AND md.Size='Large')
	DECLARE @discountAmount DECIMAL(5,2) = (SELECT SUM((md.price)*(d.discountPercentage/100)) FROM @iList i, Discount d, DiscountOn do, MenuItem m, MenuItemDetails md WHERE do.discountCode=d.discountCode AND do.categoryID=m.categoryID AND i.itemNo=m.ItemNO AND i.itemNo = md.ItemNO AND md.Size = 'Large')
	
	SET @tax = @Subtotal*0.10
	SET @totalAmountDue = @Subtotal-@tax-@discountAmount

	SELECT @orderNo = OrderNo
	FROM Orders
	WHERE CustomerID=@customerId AND OrderTime=@orderTime AND OrderDate=@orderDate

	--Inserting items in the orderContains table
		BEGIN
			INSERT INTO OrderContains(OrderNo, ItemNO, Quantity)
			SELECT o.orderNo, i.itemNo, i.quantity  
			FROM @iList i, Orders o
			WHERE CustomerID=@customerId AND OrderTime=@orderTime AND OrderDate=@orderDate
		END

		--Updating Ingredients 
		BEGIN
			UPDATE I 
			SET I.CurrentStockLevel = I.CurrentStockLevel-mc.quantity
			FROM @iList iL, Ingredient I, MenuItemContains mc
			WHERE iL.itemNo = mc.ItemNO
		END

	UPDATE Orders
	SET subtotal = @Subtotal
	WHERE CustomerID=@customerId AND OrderTime=@orderTime AND OrderDate=@orderDate

	UPDATE Orders
	SET tax = @tax
	WHERE CustomerID=@customerId AND OrderTime=@orderTime AND OrderDate=@orderDate

	UPDATE Orders
	SET TotalAmountDue = @totalAmountDue
	WHERE CustomerID=@customerId AND OrderTime=@orderTime AND OrderDate=@orderDate

	UPDATE Orders
	SET discountAmount = @discountAmount
	WHERE CustomerID=@customerId AND OrderTime=@orderTime AND OrderDate=@orderDate

END
go
-- Insert data into the TVP then execute the procedure
-- The procedure will add the contents of the TVP into the Register table


DECLARE @iList AS itemsListType

INSERT INTO @iList VALUES ('1', '1', 'D001')
INSERT INTO @iList VALUES ('2', '1', 'D003')
INSERT INTO @iList VALUES ('3', '1', NULL)


DECLARE @orderNo AS INT

-- Run SP to insert data into the Order table
--Test Case 1: This will work
EXEC usp_createCustomerOrder '1', @iList, 'Delivery', 'Phone', '1', '2021-07-01', '06:00:00', '1A Newcastle', '2021-07-01', '06:30:00', @orderNo OUT -- output parameter
PRINT 'Your order number is = ' + CAST(@orderNo AS CHAR)

--Test Case 2: This will not work (Promo not implemented)
DECLARE @iList1 AS itemsListType

INSERT INTO @iList1 VALUES ('1', '1', 'D001')
INSERT INTO @iList1 VALUES ('2', '1', 'D003')
INSERT INTO @iList1 VALUES ('3', '1', 'P001')


DECLARE @orderNo AS INT

EXEC usp_createCustomerOrder '1', @iList1, 'Delivery', 'Phone', '1', '2021-07-01', '06:01:00', '1A Newcastle', '2021-07-01', '06:30:00', @orderNo OUT -- output parameter
PRINT 'Your order number is = ' + CAST(@orderNo AS CHAR)
--See the inserted data
SELECT * FROM Orders
SELECT * FROM OrderContains
SELECT * FROM Ingredient
SELECT * FROM Discount
SELECT * FROM DiscountOn
SELECT * FROM menuItem
Select * from MenuItemContains
SELECT * FROM menuItemDetails
SELECT * FROM CATEGORY


DELETE FROM Orders WHERE OrderNo='41';
DELETE FROM Orders WHERE OrderNo='43';
UPDATE Ingredient 
SET CurrentStockLevel = 5