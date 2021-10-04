--====================================================================================================
-- INFO6002 - Assignment 2 - Part 3																	--
-- Sayeed Bin Hossain																				--
-- ID: 3340471																						--
--====================================================================================================

DROP DATABASE Pizza_test
go

CREATE DATABASE Pizza_test
go

USE Pizza_test
go


--CUSTOMER TABLE
CREATE TABLE Customer(	
CustomerID			INT IDENTITY(1,1),
FName				CHAR(20) NOT NULL,				
LName				CHAR(20) NOT NULL,							
Phone				CHAR(20),
CustomerStatus		CHAR(10) NOT NULL,
PRIMARY KEY(CustomerID),
);
go

INSERT INTO Customer VALUES ('Sayeed', 'Hossain', '123', 'Verified');
INSERT INTO Customer VALUES ('Parmida', 'Hamidi', '456', 'Verified');
INSERT INTO Customer VALUES ('Prioty', 'Tasnim', '789', 'Verified');
INSERT INTO Customer VALUES ('Elon', 'Musk', '987', 'Verified');
INSERT INTO Customer VALUES ('Jeff', 'Bezos', '654', 'Verified');
INSERT INTO Customer VALUES ('Mark', 'Zuckerberg', '321', 'Verified');
INSERT INTO Customer VALUES ('Smiley', 'Kellie', '', 'Verified');
INSERT INTO Customer VALUES ('Sad', 'Joe', '', 'Verified');
go

SELECT * FROM Customer;


--CUSTOMER INFO Table
CREATE TABLE CustomerInfo(
CustomerID			INT NOT NULL,
HomeAddress			VARCHAR(250) NOT NULL,
PRIMARY KEY(CustomerID, HomeAddress),
FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID) ON UPDATE CASCADE ON DELETE CASCADE
);
go


INSERT INTO CustomerInfo VALUES ('1', '1A Newcastle');
INSERT INTO CustomerInfo VALUES ('2', '2B Callaghan');
INSERT INTO CustomerInfo VALUES ('3', '3C Charlestown');
INSERT INTO CustomerInfo VALUES ('4', '4D Wallsend');
INSERT INTO CustomerInfo VALUES ('5', '5E Lambton');
INSERT INTO CustomerInfo VALUES ('6', '6F Hamilton');
go

SELECT * FROM CustomerInfo;


--PHONE CUSTOMER TABLE
CREATE TABLE PhoneCustomer(
CustomerID			INT NOT NULL,
PRIMARY KEY(CustomerID),
FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID) ON UPDATE CASCADE ON DELETE CASCADE
);
go

INSERT INTO PhoneCustomer VALUES ('001');
INSERT INTO PhoneCustomer VALUES ('002');
go

SELECT * FROM PhoneCustomer;


--MEMBER TABLE
CREATE TABLE Member(
CustomerID			INT NOT NULL,
username			VARCHAR(20) NOT NULL,
email				VARCHAR(20) NOT NULL,
PRIMARY KEY(CustomerID),
FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID) ON UPDATE CASCADE ON DELETE CASCADE
);
go

INSERT INTO Member VALUES ('003', 'sh001', 'sh001@yummymail.com');
INSERT INTO Member VALUES ('004', 'ph002', 'ph002@yummymail.com');
go

SELECT * FROM Member;

--GUEST TABLE
CREATE TABLE Guest(
CustomerID			INT NOT NULL,
PRIMARY KEY(CustomerID),
FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID) ON UPDATE CASCADE ON DELETE CASCADE
);
go

INSERT INTO Guest VALUES ('005');
INSERT INTO Guest VALUES ('006');
go

SELECT * FROM Guest;

--Category TABLE 
CREATE TABLE Category(		
categoryID			INT IDENTITY(1,1) NOT NULL,
categoryName		VARCHAR(50) NOT NULL,	
Primary Key (categoryID)
);
go

INSERT INTO Category VALUES ('Traditional Pizza');
INSERT INTO Category VALUES ('Value Pizza');
INSERT INTO Category VALUES ('Family Pizza');
INSERT INTO Category VALUES ('Couple Pizza');
go 

SELECT * FROM Category;


--MENU ITEM TABLE 
CREATE TABLE MenuItem(		
ItemNO				INT IDENTITY(1,1) NOT NULL,
ItemName			VARCHAR(50) NOT NULL,	
itemDescription		VARCHAR(250),
categoryID			INT NOT NULL,
Primary Key (ItemNo),
FOREIGN KEY (categoryID) REFERENCES Category(categoryID) ON UPDATE CASCADE ON DELETE CASCADE
);
go


INSERT INTO MenuItem VALUES ('Chicken Pizza', 'Nice Description of a Chicken Pizza', '1');
INSERT INTO MenuItem VALUES ('Vegan Pizza', 'Nice Description of a vegan Pizza', '2');
INSERT INTO MenuItem VALUES ('Meat Lovers Pizza', 'Nice description of a meat lovers pizza', '3');
go 

SELECT * FROM MenuItem;


--MENU ITEM DETAILS TABLE 
CREATE TABLE MenuItemDetails(		
ItemNO				INT NOT NULL,
Size				VARCHAR(50) NOT NULL,	
Price				INT Not Null,
Primary Key (ItemNo, Size),
FOREIGN KEY (ItemNo) REFERENCES MenuItem(ItemNo) ON UPDATE CASCADE ON DELETE CASCADE
);
go


INSERT INTO MenuItemDetails VALUES ('1', 'Small', '10');
INSERT INTO MenuItemDetails VALUES ('1', 'Medium', '15');
INSERT INTO MenuItemDetails VALUES ('1', 'Large', '20');
INSERT INTO MenuItemDetails VALUES ('2', 'Small', '10');
INSERT INTO MenuItemDetails VALUES ('2', 'Medium', '15');
INSERT INTO MenuItemDetails VALUES ('2', 'Large', '20');
go

SELECT * FROM MenuItemDetails;


-- INGREDIENTS CONTAINS TABLE
CREATE TABLE Ingredient(	
Code						INT IDENTITY(1,1) NOT NULL,
IngName						VARCHAR(50) NOT NULL,
IngType						VARCHAR(50) NOT NULL,	
IngDescription				VARCHAR(250),
CurrentStockLevel			INT NOT NULL,
SuggestedStockLevel			INT NOT NULL,
ReOrderLevel				INT NOT NULL,	
LastStockTake				DATE NOT NULL
Primary Key (Code) 
);
go

INSERT INTO Ingredient VALUES ('Salt', 'Spice', 'Important Ingredient 1', '4', '10', '5', '2021-01-01');
INSERT INTO Ingredient VALUES ('Pepper', 'Spice', 'Important Ingredient 2', '5', '10', '5', '2021-01-01');
INSERT INTO Ingredient VALUES ('Chicken', 'Meat', 'Important Ingredient 3', '6', '10', '5', '2021-01-01');
INSERT INTO Ingredient VALUES ('Cheese', 'Cheese', 'Important Ingredient 4', '6', '10', '5', '2021-01-01');
INSERT INTO Ingredient VALUES ('Vegan', 'Vegetable', 'Not Important Ingredient 5', '6', '10', '5', '2021-01-01');
go

SELECT * FROM Ingredient;


-- MENU ITEM CONTAINS TABLE
CREATE TABLE MenuItemContains(	
ItemNO				INT NOT NULL,
IngredientsNo		INT NOT NULL,	
Quantity			INT NOT NULL
PRIMARY KEY (ItemNo, IngredientsNo),
FOREIGN KEY (ItemNo) REFERENCES MenuItem(ItemNo) ON UPDATE CASCADE ON DELETE CASCADE, 
FOREIGN KEY (IngredientsNo) REFERENCES Ingredient (Code) ON UPDATE CASCADE ON DELETE CASCADE 
);
go

INSERT INTO MenuItemContains VALUES ('1', '1', '2');
INSERT INTO MenuItemContains VALUES ('1', '2', '2');
INSERT INTO MenuItemContains VALUES ('1', '3', '5');
INSERT INTO MenuItemContains VALUES ('1', '4', '3');
go

SELECT * FROM MenuItemContains;


-- SUPPLIER INFO TABLE
CREATE TABLE Supplier(
SupplierID					INT IDENTITY(1,1) NOT NULL,
SupplierName				VARCHAR(50) NOT NULL,
SupplierAddress				VARCHAR(250) NOT NULL,
Phone						CHAR(20) NOT NULL,
Email						VARCHAR(250) NOT NULL,
ContactPerson				VARCHAR(50) NOT NULL,
PRIMARY KEY (SupplierID) 
);
go

INSERT INTO Supplier VALUES ('Coles', 'Newcastle', '123', 'iamcoles@coles.com', 'Olivia Coles');
INSERT INTO Supplier VALUES ('Woolworths', 'Charlestown', '456', 'iamwoolworths@woolworths.com', 'Ruby Woolworths');
INSERT INTO Supplier VALUES ('Aldi', 'Maitland', '789', 'iamaldi@aldi.com', 'Emily Aldi');
go

SELECT * FROM Supplier;


-- SUPPLIES TABLE
CREATE TABLE Supplies(
IngredientsNo				INT NOT NULL,
SupplierID					INT NOT NULL,
Quantity					INT NOT NULL,
PRIMARY KEY (IngredientsNo, SupplierId),
FOREIGN KEY (IngredientsNo) REFERENCES Ingredient (Code) ON UPDATE CASCADE ON DELETE CASCADE, 
FOREIGN KEY (SupplierID) REFERENCES Supplier (SupplierID) ON UPDATE CASCADE ON DELETE CASCADE 
);
go

INSERT INTO Supplies VALUES ('1', '1', '10');
INSERT INTO Supplies VALUES ('2', '1', '10');
INSERT INTO Supplies VALUES ('3', '1', '10');
INSERT INTO Supplies VALUES ('1', '2', '10');
INSERT INTO Supplies VALUES ('2', '2', '10');
INSERT INTO Supplies VALUES ('3', '2', '10');
go

SELECT * FROM Supplies;



-- INGREDIENTS ORDER TABLE
CREATE TABLE IngredientsOrder(
OrderNo						INT IDENTITY(1,1) NOT NULL,
DateOfOrder					DATE NOT NULL,
OrderStatus					VARCHAR(20) NOT NULL,
TotalAmount					DECIMAL(5,2) NOT NULL,
SupplierID					INT NOT NULL,
PRIMARY KEY (OrderNo),
FOREIGN KEY (SupplierID) REFERENCES Supplier (SupplierID) ON UPDATE CASCADE ON DELETE CASCADE 
);
go


INSERT INTO IngredientsOrder VALUES ('2021-01-01', 'Processing', '10.56', '001');
INSERT INTO IngredientsOrder VALUES ('2021-01-01', 'Sent', '50.60', '002');
INSERT INTO IngredientsOrder VALUES ('2021-01-01', 'Processing', '70.95', '003');
go

SELECT * FROM IngredientsOrder;


-- INGREDIENTS ORDER CONTAINS TABLE
CREATE TABLE IngredientsOrderContains(
IngredientsNo				INT NOT NULL,
OrderNo						INT NOT NULL,
Quantity					INT NOT NULL,
Price						DECIMAL(5,2) NOT NULL,
PRIMARY KEY (IngredientsNo, OrderNo),
FOREIGN KEY (IngredientsNo) REFERENCES Ingredient (Code) ON UPDATE CASCADE ON DELETE CASCADE, 
FOREIGN KEY (OrderNo) REFERENCES IngredientsOrder (OrderNo) ON UPDATE CASCADE ON DELETE CASCADE 
);
go


INSERT INTO IngredientsOrderContains VALUES ('1', '1', '10', '4.00');
INSERT INTO IngredientsOrderContains VALUES ('2', '1', '10', '2.00');
INSERT INTO IngredientsOrderContains VALUES ('3', '1', '5', '3.50');
INSERT INTO IngredientsOrderContains VALUES ('1', '2', '10', '5.00');
INSERT INTO IngredientsOrderContains VALUES ('2', '2', '10', '3.00');
INSERT INTO IngredientsOrderContains VALUES ('3', '3', '5', '3.00');
go

SELECT * FROM IngredientsOrderContains;


-- EMPLOYEE TABLE
CREATE TABLE Employee(
employeeNo					INT IDENTITY(1,1) NOT NULL,
firstName					VARCHAR(20) NOT NULL,
lastName					VARCHAR(20) NOT NULL,
EmployeeAddress				VARCHAR(250) NOT NULL,
contactNo					VARCHAR(250) NOT NULL,
TFN							CHAR(20) NOT NULL,
BankCode					CHAR(10) NOT NULL,
BankName					VARCHAR(20) NOT NULL,
AccNo						CHAR(20) NOT NULL,
paymentRate					DECIMAL(5,2) NOT NULL,
EmployeeStatus				Varchar(250) NOT NULL,
EmployeeDescription			VARCHAR(250),
Primary Key (employeeNo), 
);
go


INSERT INTO Employee VALUES ('Lionel', 'Messi', 'Barcelona', '0101', '123', 'BankCode1', 'Commonwealth', 'LM001', '21.78', 'Part-Time', 'Instore');
INSERT INTO Employee VALUES ('Cristiano', 'Ronaldo', 'Turin', '0102', '234', 'BankCode2', 'Westpac', 'CR002', '21.78', 'Part-Time', 'Instore');
INSERT INTO Employee VALUES ('Eden', 'Hazard', 'Madrid', '0103', '345', 'BankCode3', 'NAB', 'EH003', '21.78', 'Full-Time', 'Driver');
INSERT INTO Employee VALUES ('Mohammad', 'Salah', 'Liverpool', '0104', '456', 'BankCode4', 'ANZ', 'MS004', '21.78', 'Full-Time', 'Driver');
go 

SELECT * FROM Employee;


--INSTORE TABLE
CREATE TABLE Instore(
employeeNo					INT NOT NULL,
Primary Key (employeeNo),
FOREIGN KEY (employeeNo) REFERENCES Employee (employeeNo) ON UPDATE CASCADE ON DELETE CASCADE, 
);
go

INSERT INTO Instore VALUES ('1');
INSERT INTO Instore VALUES ('2');
go

SELECT * FROM Instore;


-- DRIVER TABLE
CREATE TABLE Driver(
employeeNo					INT NOT NULL,
LicenseNumber				VARCHAR(10),
Primary Key (employeeNo),
FOREIGN KEY (employeeNo) REFERENCES Employee (employeeNo) ON UPDATE CASCADE ON DELETE CASCADE, 
);
go

INSERT INTO Driver VALUES ('3', 'A123');
INSERT INTO Driver VALUES ('4', 'A456');
go

SELECT * FROM Driver;


--SHIFT TABLE
CREATE TABLE Shifts(
ShiftID						INT IDENTITY(1,1) NOT NULL,
StartDate					DATE NOT NULL,
StartTime					TIME(0) NOT NULL,
EndDate						DATE NOT NULL,
EndTime						TIME(0) NOT NULL,
Primary Key (ShiftID),
);
go

INSERT INTO Shifts VALUES ('2021-01-01', '09:00:00', '2021-01-02', '17:00:00');
INSERT INTO Shifts VALUES ('2021-01-03', '09:00:00', '2021-01-04', '17:00:00');
INSERT INTO Shifts VALUES ('2021-01-05', '09:00:00', '2021-01-06', '17:00:00');
INSERT INTO Shifts VALUES ('2021-01-07', '09:00:00', '2021-01-08', '17:00:00');
go

SELECT * FROM Shifts;


-- INSTORE SHIFT TABLE
CREATE TABLE InstoreShift(
ShiftID						INT NOT NULL,
PRIMARY KEY (ShiftID), 
FOREIGN KEY (ShiftID) REFERENCES Shifts (ShiftID) ON UPDATE CASCADE ON DELETE CASCADE 
);
go

INSERT INTO InstoreShift VALUES ('1');
INSERT INTO InstoreShift VALUES ('2');
INSERT INTO InstoreShift VALUES ('3');;
go

SELECT * FROM InstoreShift;


-- DRIVER SHIFT TABLE
CREATE TABLE DriverShift(
ShiftID						INT NOT NULL,
PRIMARY KEY (ShiftID), 
FOREIGN KEY (ShiftID) REFERENCES Shifts (ShiftID) ON UPDATE CASCADE ON DELETE CASCADE 
);
go

INSERT INTO DriverShift VALUES ('001');
INSERT INTO DriverShift VALUES ('002');
INSERT INTO DriverShift VALUES ('003');
go

SELECT * FROM DriverShift;


-- INSTORE WORKS TABLE
CREATE TABLE InstoreWorks(
ShiftID						INT NOT NULL,
employeeNo					INT NOT NULL,
PRIMARY KEY (ShiftID, employeeNo), 
FOREIGN KEY (ShiftID) REFERENCES InstoreShift (ShiftID) ON UPDATE CASCADE ON DELETE CASCADE, 
FOREIGN KEY (employeeNo) REFERENCES Instore (employeeNo) ON UPDATE CASCADE ON DELETE CASCADE 
);
go

INSERT INTO InstoreWorks VALUES ('1', '1');
INSERT INTO InstoreWorks VALUES ('1', '2');
INSERT INTO InstoreWorks VALUES ('2', '1');
go

SELECT * FROM InstoreWorks;


-- DRIVER WORKS TABLE
CREATE TABLE DriverWorks(
ShiftID						INT NOT NULL,
employeeNo					INT NOT NULL,
totalDeliveries				INT NOT NULL,
paymentRatePerDelivery		Decimal(5,2),
PRIMARY KEY (ShiftID, employeeNo), 
FOREIGN KEY (ShiftID) REFERENCES DriverShift (ShiftID) ON UPDATE CASCADE ON DELETE CASCADE, 
FOREIGN KEY (employeeNo) REFERENCES Driver (employeeNo) ON UPDATE CASCADE ON DELETE CASCADE 
);
go

INSERT INTO DriverWorks VALUES ('1', '3', '10', '2');
INSERT INTO DriverWorks VALUES ('1', '4', '20', '2');
INSERT INTO DriverWorks VALUES ('2', '3', '15', '2');
go

SELECT * FROM DriverWorks;


-- STAFF PAYMENT TABLE
CREATE TABLE EmployeePayment(
PaymentID					INT IDENTITY(1,1) NOT NULL,
employeeNo					INT NOT NULL,
GrossPayment				DECIMAL(5,2) NOT NULL,
TaxWithheld					DECIMAL(5,2) NOT NULL,
TotalAmountPaid				DECIMAL(5,2) NOT NULL,
PaymentDate					DATE NOT NULL,
StartDate					DATE NOT NULL,
EndDate						DATE NOT NULL,
PRIMARY KEY (PaymentID), 
FOREIGN KEY (employeeNo) REFERENCES Employee (employeeNo) ON UPDATE CASCADE ON DELETE CASCADE
);
go


INSERT INTO EmployeePayment VALUES ('001', '100.00', '10.00', '90.00', '2021-01-01', '2020-12-01', '2021-01-01');
INSERT INTO EmployeePayment VALUES ('002', '200.00', '10.00', '190.00', '2021-01-01', '2020-12-01', '2021-01-01');
INSERT INTO EmployeePayment VALUES ('003', '300.00', '10.00', '290.00', '2021-01-01', '2020-12-01', '2021-01-01');
go

SELECT * FROM EmployeePayment;



--DRIVER PAYMENT TABLE
CREATE TABLE DeliveryPayment(
PaymentID					INT NOT NULL,
ShiftID						INT NOT NULL,
PRIMARY KEY (PaymentID),
FOREIGN KEY (PaymentId) REFERENCES EmployeePayment (PaymentID) ON UPDATE CASCADE ON DELETE CASCADE, 
FOREIGN KEY (ShiftID) references DriverShift(ShiftID) ON UPDATE CASCADE ON DELETE CASCADE 
);
go

INSERT INTO DeliveryPayment VALUES ('001', '001');
INSERT INTO DeliveryPayment VALUES ('002', '001');
INSERT INTO DeliveryPayment VALUES ('003', '001');
go

SELECT * FROM DeliveryPayment;


--INSTORE PAYMENT TABLE
CREATE TABLE InstorePayment(
PaymentID					INT NOT NULL,
ShiftID						INT NOT NULL,
PRIMARY KEY (PaymentID),
FOREIGN KEY (PaymentID) REFERENCES EmployeePayment (PaymentID) ON UPDATE CASCADE ON DELETE CASCADE, 
FOREIGN KEY (ShiftID) references InstoreShift(ShiftID) ON UPDATE CASCADE ON DELETE CASCADE 
);
go

INSERT INTO InstorePayment VALUES ('001', '001');
INSERT INTO InstorePayment VALUES ('002', '001');
INSERT INTO InstorePayment VALUES ('003', '001');
go

SELECT * FROM InstorePayment;


--ORDERS TABLE 
CREATE TABLE Orders(
OrderNo				INT IDENTITY(1,1) NOT NULL,		
CustomerID			INT NOT NULL,				
OrderDate			DATE,			
OrderTime			TIME,
employeeNo 			INT NOT NULL,	
subtotal			DECIMAL(5,2),
discountAmount		DECIMAL(5,2),
tax					DECIMAL(5,2),
TotalAmountDue		DECIMAL(5,2),
OrderStatus			CHAR(20),			
TypeofOrder 		VARCHAR(20),				
OrderDescription 	VARCHAR(50),
PaymentMethod		CHAR(20),
preorderDate		DATE,
preorderTime		TIME,
PRIMARY KEY(OrderNo),
FOREIGN KEY (employeeNo) REFERENCES Instore(employeeNo) ON UPDATE CASCADE ON DELETE CASCADE,
FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID) ON UPDATE CASCADE ON DELETE CASCADE
);
go


INSERT INTO Orders VALUES ('001', '1/1/2021', '09:00:00', '001', '50.00', '20.00', '0.50', '30.50', 'Processing','Phone','No olives','Cash','', '');
INSERT INTO Orders VALUES ('007', '2/1/2021', '09:00:00', '001', '45.00', '00.00', '0.50', '45.50', 'Processing','Walkin','Extra Cheese','Cash','', '');
INSERT INTO Orders VALUES ('003', '3/1/2021', '09:00:00', '001', '30.00', '00.00', '0.50', '30.50', 'On the way','Phone','No Cheese','Cash','', '');
INSERT INTO Orders VALUES ('001', '4/1/2021', '09:00:00', '002', '30.00', '00.00', '0.50', '30.50', 'Ready','Phone','less salt','Card','', '');
INSERT INTO Orders VALUES ('008', '5/1/2021', '09:00:00', '002', '45.00', '00.00', '0.50', '45.50', 'Ready','Walkin','Extra pepper','Card','', '');
INSERT INTO Orders VALUES ('003', '6/1/2021', '09:00:00', '002', '50.00', '00.00', '0.50', '50.50', 'Processing','Phone','No tomato','Card','', '');
INSERT INTO Orders VALUES ('003', '7/1/2021', '09:00:00', '002', '50.00', '00.00', '0.50', '50.50', 'Processing','Online','No tomato','Card', '', '');
go

SELECT * FROM Orders;


--PAYMENT INFO TABLE
CREATE TABLE CustomerPaymentInfo(
OrderNo				INT NOT NULL,
OrderApprovalNumber	INT IDENTITY(1,1) NOT NULL,
PRIMARY KEY(OrderNo),
FOREIGN KEY(OrderNo) REFERENCES Orders(OrderNo) ON UPDATE CASCADE ON DELETE CASCADE
);
go

INSERT INTO CustomerPaymentInfo VALUES ('004');
INSERT INTO CustomerPaymentInfo VALUES ('005');
INSERT INTO CustomerPaymentInfo VALUES ('006');
go

SELECT * FROM CustomerPaymentInfo;


--ORDER CONTAINS TABLE
CREATE TABLE OrderContains(
OrderNo				INT NOT NULL,		
ItemNO				INT NOT NULL,				
Quantity			INT NOT NULL,
PRIMARY KEY (OrderNo, ItemNo), 
FOREIGN KEY(OrderNo) REFERENCES Orders (OrderNo) ON UPDATE CASCADE ON DELETE CASCADE, 
FOREIGN KEY (ItemNo) REFERENCES MenuItem (ItemNo) ON UPDATE CASCADE ON DELETE CASCADE 
);
go

INSERT INTO OrderContains VALUES ('001', '001', '2');
INSERT INTO OrderContains VALUES ('001', '002', '1');
INSERT INTO OrderContains VALUES ('002', '001', '1');
go

SELECT * FROM OrderContains;


--WALKIN ORDER TABLE 
CREATE TABLE WalkinOrder(
OrderNo				INT NOT NULL,
customerName		Varchar(50),
PRIMARY KEY (OrderNo), 
FOREIGN KEY (OrderNo) REFERENCES Orders(OrderNo) ON UPDATE CASCADE ON DELETE CASCADE 
);
go

INSERT INTO WalkinOrder VALUES ('002', 'Smiley Kellie');
INSERT INTO WalkinOrder VALUES ('005', 'Sad Joe');
go

SELECT * FROM WalkinOrder;


--PHONE ORDER TABLE
CREATE TABLE PhoneOrder(
OrderNo				INT NOT NULL,					
PRIMARY KEY (OrderNo), 
FOREIGN KEY (OrderNo) REFERENCES Orders (OrderNo) ON UPDATE CASCADE ON DELETE CASCADE
);
go

INSERT INTO PhoneOrder VALUES ('001');
INSERT INTO PhoneOrder VALUES ('003');
INSERT INTO PhoneOrder VALUES ('004');
INSERT INTO PhoneOrder VALUES ('006');
go

SELECT * FROM PhoneOrder;

--ONLINE ORDER TABLE
CREATE TABLE OnlineOrder(
OrderNo				INT NOT NULL,					
PRIMARY KEY (OrderNo), 
FOREIGN KEY (OrderNo) REFERENCES Orders (OrderNo) ON UPDATE CASCADE ON DELETE CASCADE
);
go

INSERT INTO OnlineOrder VALUES ('007');
go

SELECT * FROM OnlineOrder;


-- PICKUP TABLE
CREATE TABLE Pickup(
OrderNo				INT NOT NULL,									
PRIMARY KEY (OrderNo), 
FOREIGN KEY (OrderNo) REFERENCES PhoneOrder (OrderNo) ON UPDATE CASCADE ON DELETE CASCADE 
);
go

INSERT INTO Pickup VALUES ('001');
INSERT INTO Pickup VALUES ('004');
go 

SELECT * FROM Pickup;


-- DELIVERY TABLE
CREATE TABLE Delivery(
OrderNo				INT NOT NULL,		
DeliveryTime		TIME(0) NOT NULL,				
DeliveryAddress		VARCHAR(50) NOT NULL,	
DriverID			INT NOT NULL,				
PRIMARY KEY (OrderNo), 
FOREIGN KEY (OrderNo) REFERENCES PhoneOrder (OrderNo) ON UPDATE NO ACTION ON DELETE NO ACTION, 
FOREIGN KEY (DriverID) REFERENCES Driver (employeeNo) ON UPDATE NO ACTION ON DELETE NO ACTION 
);
go

INSERT INTO Delivery VALUES ('001', '09:43:21', '1A Newcastle', '003');
INSERT INTO Delivery VALUES ('003', '09:43:21', '3C Charlestown', '003');
INSERT INTO Delivery VALUES ('006', '16:43:21', '3C Charlestown', '004');
go

SELECT * FROM Delivery;


-- Discount TABLE
CREATE TABLE Discount(
discountCode			VARCHAR(20) NOT NULL,		
discountDescription		VARCHAR(250),				
startDate				DATE NOT NULL,	
endDate					DATE NOT NULL,	
requirements			VARCHAR(250) NOT NULL,
discountPercentage		DECIMAL(5,2) NOT NULL,
PRIMARY KEY (discountCode), 
);
go



INSERT INTO Discount VALUES ('D001', 'New Year Feast', '2021-01-01', '2021-02-01', 'Valid for traditional pizzas only', '50');
INSERT INTO Discount VALUES ('D002', 'Valetine Feast', '2021-02-14', '2021-02-21', 'Valid for Couple pizzas only', '50');
INSERT INTO Discount VALUES ('D003', 'March Bazinga Feast', '2021-03-01', '2021-04-01', 'Valid for value pizzas only', '50');
go

SELECT * FROM Discount;

-- DiscountOn TABLE
CREATE TABLE DiscountOn(
discountCode			VARCHAR(20) NOT NULL,		
categoryID				INT NOT NULL,				
PRIMARY KEY (discountCode, categoryID), 
FOREIGN KEY (discountCode) REFERENCES Discount (discountCode) ON UPDATE NO ACTION ON DELETE NO ACTION, 
FOREIGN KEY (categoryID) REFERENCES Category (categoryID) ON UPDATE NO ACTION ON DELETE NO ACTION 
);
go

INSERT INTO DiscountOn VALUES ('D001', '1');
INSERT INTO DiscountOn VALUES ('D002', '4');
INSERT INTO DiscountOn VALUES ('D003', '2');
go

SELECT * FROM DiscountOn;


-- Promotion TABLE
CREATE TABLE Promotion(
promotionCode			VARCHAR(20) NOT NULL,		
promotiontDescription	VARCHAR(250),				
startDate				DATE NOT NULL,	
endDate					DATE NOT NULL,	
price					DECIMAL(5,2) NOT NULL,
itemQuantity			INT NOT NULL,
deliveryMethod			Varchar (20)
PRIMARY KEY (promotionCode), 
);
go


INSERT INTO Promotion VALUES ('P001', '2 Large Traditional Pizza', '2021-01-01', '2021-02-01', '20', '2', 'Delivery');
INSERT INTO Promotion VALUES ('P002', '2 Medium Couple', '2021-02-14', '2021-02-21', '20', '2', 'Pickup' );
INSERT INTO Promotion VALUES ('P003', '2 Large Value', '2021-03-01', '2021-04-01', '20', '2', 'Pickup');
go

SELECT * FROM Promotion;

-- PromotionOn TABLE
CREATE TABLE PromotionOn(
promotionCode			VARCHAR(20) NOT NULL,		
categoryID				INT NOT NULL,				
PRIMARY KEY (promotionCode, categoryID), 
FOREIGN KEY (promotionCode) REFERENCES Promotion (promotionCode) ON UPDATE NO ACTION ON DELETE NO ACTION, 
FOREIGN KEY (categoryID) REFERENCES Category (categoryID) ON UPDATE NO ACTION ON DELETE NO ACTION 
);
go

INSERT INTO PromotionOn VALUES ('P001', '1');
INSERT INTO PromotionOn VALUES ('P002', '4');
INSERT INTO PromotionOn VALUES ('P003', '2');
go

SELECT * FROM PromotionOn;

