-- Assignment 2 SQL for Car Company

-- Commands for efficiency and manageability
-- #################################################################

IF EXISTS(SELECT * FROM sys.sysobjects WHERE NAME='Payment' and TYPE='U')
	DROP TABLE Payment

IF EXISTS(SELECT * FROM sys.sysobjects WHERE NAME='Sale' and TYPE='U')
	DROP TABLE Sale

IF EXISTS(SELECT * FROM sys.sysobjects WHERE NAME='OrdersProduct' and TYPE='U')
	DROP TABLE OrdersProduct 

IF EXISTS(SELECT * FROM sys.sysobjects WHERE NAME='Orders' and TYPE='U')
	DROP TABLE Orders

IF EXISTS(SELECT * FROM sys.sysobjects WHERE NAME='Product' and TYPE='U')
	DROP TABLE Product 

IF EXISTS(SELECT * FROM sys.sysobjects WHERE NAME='Supplier' and TYPE='U')
	DROP TABLE Supplier

IF EXISTS(SELECT * FROM sys.sysobjects WHERE NAME='Salesperson' and TYPE='U')
	DROP TABLE Salesperson

IF EXISTS(SELECT * FROM sys.sysobjects WHERE NAME='Car' and TYPE='U')
	DROP TABLE Car

IF EXISTS(SELECT * FROM sys.sysobjects WHERE NAME='LU_Colour' and TYPE='U')
	DROP TABLE LU_Colour

IF EXISTS(SELECT * FROM sys.sysobjects WHERE NAME='Customer' and TYPE='U')
	DROP TABLE Customer



-- #################################################################
-- Create database structure
-- #################################################################

-- Lookup Table Colour
CREATE TABLE LU_Colour (
	ColourID INT PRIMARY KEY IDENTITY(1,1),
	ColourName VARCHAR(15) NOT NULL
)
	
	
-- Table Customer
CREATE TABLE Customer (
	CustomerID INT PRIMARY KEY IDENTITY(1,1),
	FirstName VARCHAR(20) NOT NULL,
	FamilyName VARCHAR(20) NOT NULL,
	Gender CHAR(1) CHECK (
		Gender IN ('M','F')
	),
	Address1 VARCHAR(20) NOT NULL,
	Address2 VARCHAR(20) NOT NULL,
	Address3 VARCHAR(20),
	Phone VARCHAR(10) NOT NULL
)


-- Table SalesPerson
CREATE TABLE Salesperson (
	SalespersonID INT PRIMARY KEY IDENTITY(1,1),
	FirstName VARCHAR(20) NOT NULL,
	FamilyName VARCHAR(20) NOT NULL,
	StartDate DATETIME NOT NULL,
	Phone VARCHAR(10) NOT NULL
)


-- Table Car
CREATE TABLE Car (
	RegistrationID VARCHAR(7) PRIMARY KEY,
	Make VARCHAR(10) NOT NULL,
	Model VARCHAR(15) NOT NULL,
	CarYear INT NOT NULL,
	NumOwners INT DEFAULT 0,
	Price MONEY NOT NULL,
	Kilometres INT NOT NULL,
	ColourID INT FOREIGN KEY REFERENCES LU_Colour(ColourID) NOT NULL
)


-- Table Sales with invoice# starting at 10000000
CREATE TABLE Sale (
	InvoiceID INT PRIMARY KEY IDENTITY(10000000,1),
	DateSold DATETIME NOT NULL,
	Price MONEY NOT NULL,
	SalespersonID INT FOREIGN KEY REFERENCES Salesperson(SalespersonID) NOT NULL,
	CustomerID INT FOREIGN KEY REFERENCES Customer(CustomerID) NOT NULL,
	RegistrationID  VARCHAR(7) FOREIGN KEY REFERENCES Car(RegistrationID) NOT NULL
)


-- Table Payment with invoice# starting at 90000000
CREATE TABLE Payment (
	PaymentInvoiceID INT PRIMARY KEY IDENTITY(90000000,1),
	PaymentDate DATETIME NOT NULL,
	Amount MONEY NOT NULL,
	CustomerID INT FOREIGN KEY REFERENCES Customer(CustomerID) NOT NULL,
	InvoiceID INT FOREIGN KEY REFERENCES Sale(InvoiceID) NOT NULL
)


-- Table Supplier
CREATE TABLE Supplier (
	SupplierID INT PRIMARY KEY IDENTITY(1,1),
	SupplierName VARCHAR(25) NOT NULL,
	Address1 VARCHAR(20) NOT NULL,
	Address2 VARCHAR(20) NOT NULL,
	Address3 VARCHAR(20),
	ContactPerson VARCHAR(20) NOT NULL,
	Phone VARCHAR(10) NOT NULL
)

-- Table Product
CREATE TABLE Product (
	ProductID INT PRIMARY KEY IDENTITY(1,1),
	Make VARCHAR(10) NOT NULL,
	Model VARCHAR(15) NOT NULL,
	ProductYear SMALLINT NOT NULL,
	Price MONEY NOT NULL
)


-- Table Order with order number starting at 50000000
CREATE TABLE Orders (
	OrderID INT PRIMARY KEY IDENTITY(50000000,1),
	OrderDate DATETIME NOT NULL,
	Total MONEY,
	SupplierID INT FOREIGN KEY REFERENCES Supplier(SupplierID) NOT NULL,
	SalespersonID INT FOREIGN KEY REFERENCES Salesperson(SalespersonID) NOT NULL
)


-- Table OrdersProduct
CREATE TABLE OrdersProduct (
	OrderID INT FOREIGN KEY REFERENCES Orders(OrderID) NOT NULL,
	ProductID INT FOREIGN KEY REFERENCES Product(ProductID) NOT NULL,
	Quantity SMALLINT DEFAULT 1 NOT NULL,
	SubTotal MONEY,
	PRIMARY KEY (OrderID, ProductID)
)



-- #################################################################
-- Data for the Database
-- #################################################################

-- Insert Colour Data - 10 rows
INSERT INTO LU_Colour(ColourName) VALUES ('Red')
INSERT INTO LU_Colour(ColourName) VALUES ('Black')
INSERT INTO LU_Colour(ColourName) VALUES ('Silver')
INSERT INTO LU_Colour(ColourName) VALUES ('White')
INSERT INTO LU_Colour(ColourName) VALUES ('Blue')
INSERT INTO LU_Colour(ColourName) VALUES ('Purple')
INSERT INTO LU_Colour(ColourName) VALUES ('Yellow')
INSERT INTO LU_Colour(ColourName) VALUES ('Paua')
INSERT INTO LU_Colour(ColourName) VALUES ('Orange')
INSERT INTO LU_Colour(ColourName) VALUES ('Green')




-- #################################################################
-- Insert Car Data
INSERT INTO Car (RegistrationID, Make, Model, CarYear, NumOwners, Price, Kilometres, ColourID) VALUES ('GKN534', 'Mazda', '626', 2014, 2, 14599, 59633,1)
INSERT INTO Car (RegistrationID, Make, Model, CarYear, NumOwners, Price, Kilometres, ColourID) VALUES ('ALP394', 'Nissan', 'Bluebird', 2012, 1, 15995, 59000, 2) 
INSERT INTO Car (RegistrationID, Make, Model, CarYear, NumOwners, Price, Kilometres, ColourID) VALUES ('NT6776', 'Toyota', 'Corolla', 2015, 1, 24990, 20565, 8) 
INSERT INTO Car (RegistrationID, Make, Model, CarYear, NumOwners, Price, Kilometres, ColourID) VALUES ('KGH334', 'Toyota', 'Rav4', 2014, 1, 36990, 6509, 3) 
INSERT INTO Car (RegistrationID, Make, Model, CarYear, NumOwners, Price, Kilometres, ColourID) VALUES ('PHG902', 'Toyota', 'Rav4', 2016, 0, 46990, 14, 6) 
INSERT INTO Car (RegistrationID, Make, Model, CarYear, NumOwners, Price, Kilometres, ColourID) VALUES ('GLM123', 'Honda', 'Accord', 2010, 2, 9995, 119000, 4) 
INSERT INTO Car (RegistrationID, Make, Model, CarYear, NumOwners, Price, Kilometres, ColourID) VALUES ('OM1122', 'Mazda', '323', 2012, 1, 12995, 89000, 5) 
INSERT INTO Car (RegistrationID, Make, Model, CarYear, NumOwners, Price, Kilometres, ColourID) VALUES ('RS3456', 'Mazda', '323', 2013, 1, 13995, 110000, 1) 
INSERT INTO Car (RegistrationID, Make, Model, CarYear, NumOwners, Price, Kilometres, ColourID) VALUES ('ZHU123', 'Nissan', 'Note', 2009, 2, 9995, 89000, 3) 
INSERT INTO Car (RegistrationID, Make, Model, CarYear, NumOwners, Price, Kilometres, ColourID) VALUES ('PRH345', 'Honda', 'Accord', 2014, 1, 41885, 5500, 9) 
INSERT INTO Car (RegistrationID, Make, Model, CarYear, NumOwners, Price, Kilometres, ColourID) VALUES ('SUT143', 'Nissan', 'Bluebird', 2013, 1, 17995, 61000, 6) 
INSERT INTO Car (RegistrationID, Make, Model, CarYear, NumOwners, Price, Kilometres, ColourID) VALUES ('GBR553', 'Nissan', 'X-Trail', 2016, 0, 39995, 12, 3) 
INSERT INTO Car (RegistrationID, Make, Model, CarYear, NumOwners, Price, Kilometres, ColourID) VALUES ('LQRT67', 'Toyota', 'Yaris', 2015, 1, 20990, 6825, 2) 
INSERT INTO Car (RegistrationID, Make, Model, CarYear, NumOwners, Price, Kilometres, ColourID) VALUES ('SALES1', 'BMW', '525i', 2009, 1, 27440, 39400, 7) 
INSERT INTO Car (RegistrationID, Make, Model, CarYear, NumOwners, Price, Kilometres, ColourID) VALUES ('LMV541', 'BMW', 'M3', 2010, 2, 54990, 77000, 2) 
INSERT INTO Car (RegistrationID, Make, Model, CarYear, NumOwners, Price, Kilometres, ColourID) VALUES ('NIS123', 'Nissan', 'Pulsar', 2016, 0, 24989, 3, 9) 
INSERT INTO Car (RegistrationID, Make, Model, CarYear, NumOwners, Price, Kilometres, ColourID) VALUES ('TGY683', 'Nissan', 'Navara', 2016, 0, 54989, 13, 1) 
INSERT INTO Car (RegistrationID, Make, Model, CarYear, NumOwners, Price, Kilometres, ColourID) VALUES ('GTF098', 'Honda', 'Accord', 2012, 1, 12995, 110000, 9) 
INSERT INTO Car (RegistrationID, Make, Model, CarYear, NumOwners, Price, Kilometres, ColourID) VALUES ('OMG765', 'Mazda', '323', 2014, 1, 17995, 59000, 7) 
INSERT INTO Car (RegistrationID, Make, Model, CarYear, NumOwners, Price, Kilometres, ColourID) VALUES ('LOL201', 'Nissan', 'Bluebird', 2013, 1, 19995, 41000, 1) 
INSERT INTO Car (RegistrationID, Make, Model, CarYear, NumOwners, Price, Kilometres, ColourID) VALUES ('YTY561', 'Honda', 'Crossroad', 2010, 2, 25500, 95500, 2) 
INSERT INTO Car (RegistrationID, Make, Model, CarYear, NumOwners, Price, Kilometres, ColourID) VALUES ('MMH291', 'Nissan', 'Altima', 2013, 1, 25995, 5000, 1) 
INSERT INTO Car (RegistrationID, Make, Model, CarYear, NumOwners, Price, Kilometres, ColourID) VALUES ('YQTA23', 'Toyota', 'Yaris', 2014, 1, 18990, 36000, 8) 
INSERT INTO Car (RegistrationID, Make, Model, CarYear, NumOwners, Price, Kilometres, ColourID) VALUES ('OUP887', 'BMW', '525i', 2010, 1, 32440, 29400, 9) 
INSERT INTO Car (RegistrationID, Make, Model, CarYear, NumOwners, Price, Kilometres, ColourID) VALUES ('QPL322', 'BMW', 'M3', 2010, 1, 44990, 69000, 3) 
INSERT INTO Car (RegistrationID, Make, Model, CarYear, NumOwners, Price, Kilometres, ColourID) VALUES ('ZQP311', 'Nissan', 'Skyline', 2012, 2, 22980, 65040, 3) 
INSERT INTO Car (RegistrationID, Make, Model, CarYear, NumOwners, Price, Kilometres, ColourID) VALUES ('QPLO31', 'Nissan', 'Skyline', 2014, 1, 38500, 6500, 1) 
INSERT INTO Car (RegistrationID, Make, Model, CarYear, NumOwners, Price, Kilometres, ColourID) VALUES ('POOE23', 'Honda', 'Accord', 2013, 1, 13995, 120000, 7) 
INSERT INTO Car (RegistrationID, Make, Model, CarYear, NumOwners, Price, Kilometres, ColourID) VALUES ('PLKI21', 'Mazda', '323', 2014, 1, 16995, 79000, 2) 
INSERT INTO Car (RegistrationID, Make, Model, CarYear, NumOwners, Price, Kilometres, ColourID) VALUES ('HWY231', 'Nissan', 'Bluebird', 2013, 2, 19995, 39000, 1) 
INSERT INTO Car (RegistrationID, Make, Model, CarYear, NumOwners, Price, Kilometres, ColourID) VALUES ('SHEEPS', 'Holden', 'Commodore SsV', 2013, 1, 29995, 49000, 3) 
INSERT INTO Car (RegistrationID, Make, Model, CarYear, NumOwners, Price, Kilometres, ColourID) VALUES ('TPGEAR', 'Nissan', 'Bluebird', 2011, 2, 12995, 89000, 4) 
INSERT INTO Car (RegistrationID, Make, Model, CarYear, NumOwners, Price, Kilometres, ColourID) VALUES ('YTT342', 'Honda', 'VTR250F', 2011, 2, 9995, 89000, 1) 
INSERT INTO Car (RegistrationID, Make, Model, CarYear, NumOwners, Price, Kilometres, ColourID) VALUES ('GO4T53', 'Honda', 'CB900F Hornet', 2010, 2, 7995, 95000, 5) 
INSERT INTO Car (RegistrationID, Make, Model, CarYear, NumOwners, Price, Kilometres, ColourID) VALUES ('GO4T99', 'Honda', 'Jazz', 2011, 2, 7995, 89000, 4) 
INSERT INTO Car (RegistrationID, Make, Model, CarYear, NumOwners, Price, Kilometres, ColourID) VALUES ('EATPOO', 'BMW', 'Z4', 2012, 1, 39995, 49000, 4) 
INSERT INTO Car (RegistrationID, Make, Model, CarYear, NumOwners, Price, Kilometres, ColourID) VALUES ('KFK122', 'Ford', 'Falcon', 2013, 1, 24995, 59000, 3) 
INSERT INTO Car (RegistrationID, Make, Model, CarYear, NumOwners, Price, Kilometres, ColourID) VALUES ('KER123', 'Mazda', 'Familia', 2010, 2, 8995, 85900, 1) 
INSERT INTO Car (RegistrationID, Make, Model, CarYear, NumOwners, Price, Kilometres, ColourID) VALUES ('PKR111', 'Mazda', 'Familia', 2010, 2, 7995, 95000, 5) 
INSERT INTO Car (RegistrationID, Make, Model, CarYear, NumOwners, Price, Kilometres, ColourID) VALUES ('FJW125', 'Holden', 'Commodore', 2015, 1, 39999, 15000, 4) 



-- #################################################################
-- Insert Customer Data
INSERT INTO Customer (FirstName, FamilyName, Gender, Address1, Address2, Address3, Phone) VALUES ('Katniss', 'Everdeen', 'F', '45 Dinsdale Rd', 'Frankton', 'Hamilton', '8123456')
INSERT INTO Customer (FirstName, FamilyName, Gender, Address1, Address2, Address3, Phone) VALUES ('Peeta', 'Mallark', 'M', '123 Anglesea St', 'Maeora', 'Hamilton', '8111111')
INSERT INTO Customer (FirstName, FamilyName, Gender, Address1, Address2, Address3, Phone) VALUES ('Gale', 'Hawthorne', 'M', '717 River Rd', 'Melville', 'Hamilton', '8221122')
INSERT INTO Customer (FirstName, FamilyName, Gender, Address1, Address2, Address3, Phone) VALUES ('Haymitch', 'Avern', 'M', '24 Duke St', 'Park View', 'Cambridge', '8881888')
INSERT INTO Customer (FirstName, FamilyName, Gender, Address1, Address2, Address3, Phone) VALUES ('Primrose', 'Suzci', 'F', 'RD1', 'Park View', 'Cambridge', '8112211')
INSERT INTO Customer (FirstName, FamilyName, Gender, Address1, Address2, Address3, Phone) VALUES ('Effie', 'Trinket', 'F', '655 Tristram St', 'Frankton', 'Hamilton', '8181818')
INSERT INTO Customer (FirstName, FamilyName, Gender, Address1, Address2, Address3, Phone) VALUES ('Hamilon', 'Hardna', 'M', '23 Lake Rd', 'Frankton', 'Hamilton', '8151156')
INSERT INTO Customer (FirstName, FamilyName, Gender, Address1, Address2, Address3, Phone) VALUES ('Kermin', 'Shaldon', 'M', '23 Rimu St', 'Maeroa', 'Hamilton', '8113121')
INSERT INTO Customer (FirstName, FamilyName, Gender, Address1, Address2, Address3, Phone) VALUES ('Sukki', 'Rightson', 'F', '252 Fast Rd', 'Silverdale', 'Hamilton', '8222322')
INSERT INTO Customer (FirstName, FamilyName, Gender, Address1, Address2, Address3, Phone) VALUES ('Mathew', 'Allen', 'M', '45 Shelfin St', 'West Side View', 'Cambridge', '8816988')
INSERT INTO Customer (FirstName, FamilyName, Gender, Address1, Address2, Address3, Phone) VALUES ('Frank', 'Smith', 'M', '45 Dinsdale Rd', 'Dinsdale', 'Hamilton', '8183456')
INSERT INTO Customer (FirstName, FamilyName, Gender, Address1, Address2, Address3, Phone) VALUES ('Tody', 'Ever', 'M', '49 Queen St', 'Park View', 'Cambridge', '8823346')
INSERT INTO Customer (FirstName, FamilyName, Gender, Address1, Address2, Address3, Phone) VALUES ('Toby', 'Deen', 'M', '45 Queen St', 'Hamilton Central', 'Hamilton', '8623456')
INSERT INTO Customer (FirstName, FamilyName, Gender, Address1, Address2, Address3, Phone) VALUES ('Pip', 'Jett', 'M', '423 Anglesea St', 'Hamilton Central', 'Hamilton', '8456123')
INSERT INTO Customer (FirstName, FamilyName, Gender, Address1, Address2, Address3, Phone) VALUES ('John', 'Mack', 'M', '43 Cresent St', 'Melville', 'Hamilton', '8443143')



-- #################################################################
-- Insert Sales Person Data
INSERT INTO Salesperson (FirstName, FamilyName, StartDate, Phone) VALUES ('Michael', 'Knapp', CONVERT(DATETIME, '10-06-2015',103), '0213390823')
INSERT INTO Salesperson (FirstName, FamilyName, StartDate, Phone) VALUES ('Kelly', 'Knapp', CONVERT(DATETIME, '10-07-2015',103), '0213390823')
INSERT INTO Salesperson (FirstName, FamilyName, StartDate, Phone) VALUES ('Bradley', 'Palmer', CONVERT(DATETIME, '24-08-2015',103), '0219878123')
INSERT INTO Salesperson (FirstName, FamilyName, StartDate, Phone) VALUES ('Karen', 'Craften', CONVERT(DATETIME, '21-08-2015',103), '0213940903')
INSERT INTO Salesperson (FirstName, FamilyName, StartDate, Phone) VALUES ('Kane', 'Hunter', CONVERT(DATETIME, '12-03-2016',103), '0212132231')
INSERT INTO Salesperson (FirstName, FamilyName, StartDate, Phone) VALUES ('John', 'Wrights', CONVERT(DATETIME, '20-03-2016',103), '0210998212')



-- #################################################################
-- Insert Sales data using combination of INSERT...SELECT and UPDATE Commands
INSERT INTO Sale(DateSold, Price, SalespersonID, CustomerID, RegistrationID) SELECT CONVERT(DATETIME, '17-06-2015',103), Car.Price, 1, 1, 'GKN534' FROM Car WHERE Car.RegistrationID = 'GKN534'
INSERT INTO Sale(DateSold, Price, SalespersonID, CustomerID, RegistrationID) SELECT CONVERT(DATETIME, '27-06-2015',103), Car.Price, 1, 2, 'ALP394' FROM Car WHERE Car.RegistrationID = 'ALP394'
INSERT INTO Sale(DateSold, Price, SalespersonID, CustomerID, RegistrationID) SELECT CONVERT(DATETIME, '07-07-2015',103), Car.Price, 1, 3, 'NT6776' FROM Car WHERE Car.RegistrationID = 'NT6776'
INSERT INTO Sale(DateSold, Price, SalespersonID, CustomerID, RegistrationID) SELECT CONVERT(DATETIME, '11-07-2015',103), Car.Price, 1, 4, 'KGH334' FROM Car WHERE Car.RegistrationID = 'KGH334'
INSERT INTO Sale(DateSold, Price, SalespersonID, CustomerID, RegistrationID) SELECT CONVERT(DATETIME, '17-07-2015',103), Car.Price, 2, 5, 'PHG902' FROM Car WHERE Car.RegistrationID = 'PHG902'
INSERT INTO Sale(DateSold, Price, SalespersonID, CustomerID, RegistrationID) SELECT CONVERT(DATETIME, '19-07-2015',103), Car.Price, 1, 6, 'GLM123' FROM Car WHERE Car.RegistrationID = 'GLM123'
INSERT INTO Sale(DateSold, Price, SalespersonID, CustomerID, RegistrationID) SELECT CONVERT(DATETIME, '07-08-2015',103), Car.Price, 2, 7, 'OM1122' FROM Car WHERE Car.RegistrationID = 'OM1122'
INSERT INTO Sale(DateSold, Price, SalespersonID, CustomerID, RegistrationID) SELECT CONVERT(DATETIME, '10-08-2015',103), Car.Price, 2, 8, 'RS3456' FROM Car WHERE Car.RegistrationID = 'RS3456'
INSERT INTO Sale(DateSold, Price, SalespersonID, CustomerID, RegistrationID) SELECT CONVERT(DATETIME, '27-08-2015',103), Car.Price, 3, 9, 'ZHU123' FROM Car WHERE Car.RegistrationID = 'ZHU123'
INSERT INTO Sale(DateSold, Price, SalespersonID, CustomerID, RegistrationID) SELECT CONVERT(DATETIME, '01-10-2015',103), Car.Price, 3, 10, 'PRH345' FROM Car WHERE Car.RegistrationID = 'PRH345'
INSERT INTO Sale(DateSold, Price, SalespersonID, CustomerID, RegistrationID) SELECT CONVERT(DATETIME, '11-10-2015',103), Car.Price, 1, 11, 'SUT143' FROM Car WHERE Car.RegistrationID = 'SUT143'
INSERT INTO Sale(DateSold, Price, SalespersonID, CustomerID, RegistrationID) SELECT CONVERT(DATETIME, '10-11-2015',103), Car.Price, 3, 12, 'GBR553' FROM Car WHERE Car.RegistrationID = 'GBR553'
INSERT INTO Sale(DateSold, Price, SalespersonID, CustomerID, RegistrationID) SELECT CONVERT(DATETIME, '11-12-2015',103), Car.Price, 4, 13, 'LQRT67' FROM Car WHERE Car.RegistrationID = 'LQRT67'
INSERT INTO Sale(DateSold, Price, SalespersonID, CustomerID, RegistrationID) SELECT CONVERT(DATETIME, '12-12-2015',103), Car.Price, 4, 14, 'SALES1' FROM Car WHERE Car.RegistrationID = 'SALES1'
INSERT INTO Sale(DateSold, Price, SalespersonID, CustomerID, RegistrationID) SELECT CONVERT(DATETIME, '12-01-2016',103), Car.Price, 3, 15, 'LMV541' FROM Car WHERE Car.RegistrationID = 'LMV541'
INSERT INTO Sale(DateSold, Price, SalespersonID, CustomerID, RegistrationID) SELECT CONVERT(DATETIME, '15-01-2016',103), Car.Price, 4, 1, 'NIS123' FROM Car WHERE Car.RegistrationID = 'NIS123'
INSERT INTO Sale(DateSold, Price, SalespersonID, CustomerID, RegistrationID) SELECT CONVERT(DATETIME, '17-03-2016',103), Car.Price, 5, 2, 'TGY683' FROM Car WHERE Car.RegistrationID = 'TGY683'
INSERT INTO Sale(DateSold, Price, SalespersonID, CustomerID, RegistrationID) SELECT CONVERT(DATETIME, '20-03-2016',103), Car.Price, 2, 3, 'GTF098' FROM Car WHERE Car.RegistrationID = 'GTF098'
INSERT INTO Sale(DateSold, Price, SalespersonID, CustomerID, RegistrationID) SELECT CONVERT(DATETIME, '20-04-2016',103), Car.Price, 5, 4, 'OMG765' FROM Car WHERE Car.RegistrationID = 'OMG765'



-- #################################################################
-- Insert Payment Data
INSERT INTO Payment (PaymentDate, Amount, CustomerID, InvoiceID) VALUES (CONVERT(DATETIME, '27-07-2015',103), 1000, 1, 10000000)
INSERT INTO Payment (PaymentDate, Amount, CustomerID, InvoiceID) VALUES (CONVERT(DATETIME, '27-08-2015',103), 1000, 1, 10000000)
INSERT INTO Payment (PaymentDate, Amount, CustomerID, InvoiceID) VALUES (CONVERT(DATETIME, '27-09-2015',103), 1000, 1, 10000000)
INSERT INTO Payment (PaymentDate, Amount, CustomerID, InvoiceID) VALUES (CONVERT(DATETIME, '17-08-2015',103), 1000, 2, 10000001)
INSERT INTO Payment (PaymentDate, Amount, CustomerID, InvoiceID) VALUES (CONVERT(DATETIME, '17-09-2015',103), 1000, 2, 10000001)
INSERT INTO Payment (PaymentDate, Amount, CustomerID, InvoiceID) VALUES (CONVERT(DATETIME, '17-10-2015',103), 1000, 2, 10000001)
INSERT INTO Payment (PaymentDate, Amount, CustomerID, InvoiceID) VALUES (CONVERT(DATETIME, '17-11-2015',103), 1000, 2, 10000001)
INSERT INTO Payment (PaymentDate, Amount, CustomerID, InvoiceID) VALUES (CONVERT(DATETIME, '7-07-2015',103), 1000, 3, 10000002)
INSERT INTO Payment (PaymentDate, Amount, CustomerID, InvoiceID) VALUES (CONVERT(DATETIME, '11-07-2015',103), 1000, 4, 10000003)
INSERT INTO Payment (PaymentDate, Amount, CustomerID, InvoiceID) VALUES (CONVERT(DATETIME, '17-07-2015',103), 1000, 5, 10000004)
INSERT INTO Payment (PaymentDate, Amount, CustomerID, InvoiceID) VALUES (CONVERT(DATETIME, '19-08-2015',103), 1000, 6, 10000005)
INSERT INTO Payment (PaymentDate, Amount, CustomerID, InvoiceID) VALUES (CONVERT(DATETIME, '19-09-2015',103), 1000, 6, 10000005)
INSERT INTO Payment (PaymentDate, Amount, CustomerID, InvoiceID) VALUES (CONVERT(DATETIME, '19-10-2015',103), 1000, 6, 10000005)
INSERT INTO Payment (PaymentDate, Amount, CustomerID, InvoiceID) VALUES (CONVERT(DATETIME, '7-08-2015',103), 1000, 7, 10000006)
INSERT INTO Payment (PaymentDate, Amount, CustomerID, InvoiceID) VALUES (CONVERT(DATETIME, '7-01-2016',103), 1000, 7, 10000006)
INSERT INTO Payment (PaymentDate, Amount, CustomerID, InvoiceID) VALUES (CONVERT(DATETIME, '7-02-2016',103), 1000, 7, 10000006)
INSERT INTO Payment (PaymentDate, Amount, CustomerID, InvoiceID) VALUES (CONVERT(DATETIME, '10-09-2015',103), 1000, 8, 10000007)
INSERT INTO Payment (PaymentDate, Amount, CustomerID, InvoiceID) VALUES (CONVERT(DATETIME, '10-10-2015',103), 1000, 8, 10000007)
INSERT INTO Payment (PaymentDate, Amount, CustomerID, InvoiceID) VALUES (CONVERT(DATETIME, '10-11-2015',103), 1000, 8, 10000007)
INSERT INTO Payment (PaymentDate, Amount, CustomerID, InvoiceID) VALUES (CONVERT(DATETIME, '10-02-2016',103), 1000, 8, 10000007)



-- #################################################################
-- Insert Product Data
INSERT INTO Product (Make, Model, ProductYear, Price) VALUES ('Honda', 'Accord', 2010, 3000)
INSERT INTO Product (Make, Model, ProductYear, Price) VALUES ('Honda', 'Accord', 2012, 5000)
INSERT INTO Product (Make, Model, ProductYear, Price) VALUES ('Honda', 'Accord', 2013, 7000)
INSERT INTO Product (Make, Model, ProductYear, Price) VALUES ('Honda', 'Accord', 2014, 13000)
INSERT INTO Product (Make, Model, ProductYear, Price) VALUES ('Honda', 'CRZ', 2012, 4000) 
INSERT INTO Product (Make, Model, ProductYear, Price) VALUES ('Honda', 'Civic', 2015, 5000)
INSERT INTO Product (Make, Model, ProductYear, Price) VALUES ('Honda', 'Jazz', 2011, 2500)
INSERT INTO Product (Make, Model, ProductYear, Price) VALUES ('Honda', 'Jazz', 2012, 3500) 
INSERT INTO Product (Make, Model, ProductYear, Price) VALUES ('Honda', 'Crossroad', 2010, 8000) 
INSERT INTO Product (Make, Model, ProductYear, Price) VALUES ('Honda', 'VTR250F', 2011, 3000) 
INSERT INTO Product (Make, Model, ProductYear, Price) VALUES ('Honda', 'CB900F Hornet', 2010, 2500) 
INSERT INTO Product (Make, Model, ProductYear, Price) VALUES ('Toyota', 'Aurion', 2013, 10000) 
INSERT INTO Product (Make, Model, ProductYear, Price) VALUES ('Toyota', 'Hiace', 2014, 8000)
INSERT INTO Product (Make, Model, ProductYear, Price) VALUES ('Toyota', 'Hilux', 2012, 9000)
INSERT INTO Product (Make, Model, ProductYear, Price) VALUES ('Toyota', 'Camry', 2013, 12000)
INSERT INTO Product (Make, Model, ProductYear, Price) VALUES ('Toyota', 'Vitz', 2010, 8000)
INSERT INTO Product (Make, Model, ProductYear, Price) VALUES ('Toyota', 'Prius', 2012, 9000)
INSERT INTO Product (Make, Model, ProductYear, Price) VALUES ('Toyota', 'Corolla', 2015, 8000)
INSERT INTO Product (Make, Model, ProductYear, Price) VALUES ('Toyota', 'Yaris', 2014, 6000) 
INSERT INTO Product (Make, Model, ProductYear, Price) VALUES ('Toyota', 'Yaris', 2015, 7000) 
INSERT INTO Product (Make, Model, ProductYear, Price) VALUES ('Toyota', 'Rav4', 2014, 12000) 
INSERT INTO Product (Make, Model, ProductYear, Price) VALUES ('Toyota', 'Rav4', 2016, 14000) 
INSERT INTO Product (Make, Model, ProductYear, Price) VALUES ('Mazda', '323', 2012, 4000) 
INSERT INTO Product (Make, Model, ProductYear, Price) VALUES ('Mazda', '323', 2013, 4500) 
INSERT INTO Product (Make, Model, ProductYear, Price) VALUES ('Mazda', '323', 2014, 5500) 
INSERT INTO Product (Make, Model, ProductYear, Price) VALUES ('Mazda', '353', 2013, 5000) 
INSERT INTO Product (Make, Model, ProductYear, Price) VALUES ('Mazda', '353', 2014, 6000) 
INSERT INTO Product (Make, Model, ProductYear, Price) VALUES ('Mazda', '626', 2014, 5000) 
INSERT INTO Product (Make, Model, ProductYear, Price) VALUES ('Mazda', 'Familia', 2010, 2500) 
INSERT INTO Product (Make, Model, ProductYear, Price) VALUES ('Nissan', 'Muruno', 2014, 9000) 
INSERT INTO Product (Make, Model, ProductYear, Price) VALUES ('Nissan', 'Pulsar', 2016, 8000)
INSERT INTO Product (Make, Model, ProductYear, Price) VALUES ('Nissan', 'Bluebird', 2011, 4000)
INSERT INTO Product (Make, Model, ProductYear, Price) VALUES ('Nissan', 'Bluebird', 2012, 5000)
INSERT INTO Product (Make, Model, ProductYear, Price) VALUES ('Nissan', 'Bluebird', 2013, 6000)
INSERT INTO Product (Make, Model, ProductYear, Price) VALUES ('Nissan', 'X-Trail', 2016, 12000) 
INSERT INTO Product (Make, Model, ProductYear, Price) VALUES ('Nissan', 'Navara', 2016, 16000) 
INSERT INTO Product (Make, Model, ProductYear, Price) VALUES ('Nissan', 'Altima', 2013, 8000) 
INSERT INTO Product (Make, Model, ProductYear, Price) VALUES ('Nissan', 'Note', 2009, 3000) 
INSERT INTO Product (Make, Model, ProductYear, Price) VALUES ('Nissan', 'Skyline', 2014, 15000) 
INSERT INTO Product (Make, Model, ProductYear, Price) VALUES ('Nissan', 'Skyline', 2012, 7000) 
INSERT INTO Product (Make, Model, ProductYear, Price) VALUES ('Ford', 'Falcon', 2012, 7000) 
INSERT INTO Product (Make, Model, ProductYear, Price) VALUES ('Ford', 'Falcon', 2013, 8000) 
INSERT INTO Product (Make, Model, ProductYear, Price) VALUES ('Ford', 'Falcon', 2014, 9000) 
INSERT INTO Product (Make, Model, ProductYear, Price) VALUES ('BMW', '322', 2010, 15000)
INSERT INTO Product (Make, Model, ProductYear, Price) VALUES ('BMW', '727', 2013, 18000) 
INSERT INTO Product (Make, Model, ProductYear, Price) VALUES ('BMW', 'X5', 2014, 18000)
INSERT INTO Product (Make, Model, ProductYear, Price) VALUES ('BMW', '525i', 2009, 9000) 
INSERT INTO Product (Make, Model, ProductYear, Price) VALUES ('BMW', '525i', 2010, 10000) 
INSERT INTO Product (Make, Model, ProductYear, Price) VALUES ('BMW', 'M3', 2010, 17000) 
INSERT INTO Product (Make, Model, ProductYear, Price) VALUES ('BMW', 'Z4', 2012, 12000) 
INSERT INTO Product (Make, Model, ProductYear, Price) VALUES ('Holden', 'Commodore SsV', 2013, 10000) 
INSERT INTO Product (Make, Model, ProductYear, Price) VALUES ('Holden', 'Commodore', 2015, 13000) 
INSERT INTO Product (Make, Model, ProductYear, Price) VALUES ('Holden', 'Commodore XR6', 2011, 15000) 
INSERT INTO Product (Make, Model, ProductYear, Price) VALUES ('Holden', 'Commodore XR6', 2012, 17000) 
INSERT INTO Product (Make, Model, ProductYear, Price) VALUES ('Holden', 'Commodore XR6', 2013, 19000) 
INSERT INTO Product (Make, Model, ProductYear, Price) VALUES ('Holden', 'Clubsport', 2013, 19000) 
INSERT INTO Product (Make, Model, ProductYear, Price) VALUES ('Holden', 'Clubsport', 2014, 21000) 
INSERT INTO Product (Make, Model, ProductYear, Price) VALUES ('Holden', 'Clubsport', 2015, 22000) 




-- #################################################################
-- Insert Supplier Data
INSERT INTO Supplier (SupplierName, Address1, Address2, Address3, ContactPerson, Phone) VALUES ('XTREME Quality Cars Inc','22A Great North Rd','Pimbroke', 'Auckland', 'Murray Knapp', '096666432')



-- #################################################################
-- Insert Order Data
INSERT INTO Orders (OrderDate, SupplierID, SalespersonID) VALUES (CONVERT(DATETIME, '01-06-2015',103),1,1)
INSERT INTO Orders (OrderDate, SupplierID, SalespersonID) VALUES (CONVERT(DATETIME, '05-06-2015',103),1,1)
INSERT INTO Orders (OrderDate, SupplierID, SalespersonID) VALUES (CONVERT(DATETIME, '06-06-2015',103),1,1)
INSERT INTO Orders (OrderDate, SupplierID, SalespersonID) VALUES (CONVERT(DATETIME, '10-06-2015',103),1,1)
INSERT INTO Orders (OrderDate, SupplierID, SalespersonID) VALUES (CONVERT(DATETIME, '11-06-2015',103),1,1)
INSERT INTO Orders (OrderDate, SupplierID, SalespersonID) VALUES (CONVERT(DATETIME, '12-06-2015',103),1,1)
INSERT INTO Orders (OrderDate, SupplierID, SalespersonID) VALUES (CONVERT(DATETIME, '21-07-2015',103),1,2)
INSERT INTO Orders (OrderDate, SupplierID, SalespersonID) VALUES (CONVERT(DATETIME, '01-08-2015',103),1,2)
INSERT INTO Orders (OrderDate, SupplierID, SalespersonID) VALUES (CONVERT(DATETIME, '11-08-2015',103),1,2)
INSERT INTO Orders (OrderDate, SupplierID, SalespersonID) VALUES (CONVERT(DATETIME, '21-08-2015',103),1,2)


-- #################################################################
-- Insert OrdersProduct Data
INSERT INTO OrdersProduct (OrderID, ProductID, Quantity) SELECT 50000000, Product.ProductID, 1 FROM Product WHERE Product.ProductID = 28
INSERT INTO OrdersProduct (OrderID, ProductID, Quantity) SELECT 50000000, Product.ProductID, 1 FROM Product WHERE Product.ProductID = 33
INSERT INTO OrdersProduct (OrderID, ProductID, Quantity) SELECT 50000000, Product.ProductID, 1 FROM Product WHERE Product.ProductID = 18
INSERT INTO OrdersProduct (OrderID, ProductID, Quantity) SELECT 50000000, Product.ProductID, 1 FROM Product WHERE Product.ProductID = 21
INSERT INTO OrdersProduct (OrderID, ProductID, Quantity) SELECT 50000000, Product.ProductID, 1 FROM Product WHERE Product.ProductID = 22
INSERT INTO OrdersProduct (OrderID, ProductID, Quantity) SELECT 50000000, Product.ProductID, 1 FROM Product WHERE Product.ProductID = 1
INSERT INTO OrdersProduct (OrderID, ProductID, Quantity) SELECT 50000000, Product.ProductID, 1 FROM Product WHERE Product.ProductID = 23
INSERT INTO OrdersProduct (OrderID, ProductID, Quantity) SELECT 50000000, Product.ProductID, 1 FROM Product WHERE Product.ProductID = 24
INSERT INTO OrdersProduct (OrderID, ProductID, Quantity) SELECT 50000000, Product.ProductID, 1 FROM Product WHERE Product.ProductID = 38
INSERT INTO OrdersProduct (OrderID, ProductID, Quantity) SELECT 50000000, Product.ProductID, 1 FROM Product WHERE Product.ProductID = 4
INSERT INTO OrdersProduct (OrderID, ProductID, Quantity) SELECT 50000001, Product.ProductID, 3 FROM Product WHERE Product.ProductID = 34
INSERT INTO OrdersProduct (OrderID, ProductID, Quantity) SELECT 50000001, Product.ProductID, 1 FROM Product WHERE Product.ProductID = 35
INSERT INTO OrdersProduct (OrderID, ProductID, Quantity) SELECT 50000001, Product.ProductID, 1 FROM Product WHERE Product.ProductID = 20
INSERT INTO OrdersProduct (OrderID, ProductID, Quantity) SELECT 50000001, Product.ProductID, 1 FROM Product WHERE Product.ProductID = 47
INSERT INTO OrdersProduct (OrderID, ProductID, Quantity) SELECT 50000001, Product.ProductID, 1 FROM Product WHERE Product.ProductID = 49
INSERT INTO OrdersProduct (OrderID, ProductID, Quantity) SELECT 50000001, Product.ProductID, 1 FROM Product WHERE Product.ProductID = 31
INSERT INTO OrdersProduct (OrderID, ProductID, Quantity) SELECT 50000001, Product.ProductID, 1 FROM Product WHERE Product.ProductID = 36
INSERT INTO OrdersProduct (OrderID, ProductID, Quantity) SELECT 50000001, Product.ProductID, 1 FROM Product WHERE Product.ProductID = 2
INSERT INTO OrdersProduct (OrderID, ProductID, Quantity) SELECT 50000001, Product.ProductID, 1 FROM Product WHERE Product.ProductID = 25
INSERT INTO OrdersProduct (OrderID, ProductID, Quantity) SELECT 50000001, Product.ProductID, 1 FROM Product WHERE Product.ProductID = 27
INSERT INTO OrdersProduct (OrderID, ProductID, Quantity) SELECT 50000002, Product.ProductID, 1 FROM Product WHERE Product.ProductID = 9
INSERT INTO OrdersProduct (OrderID, ProductID, Quantity) SELECT 50000002, Product.ProductID, 1 FROM Product WHERE Product.ProductID = 36
INSERT INTO OrdersProduct (OrderID, ProductID, Quantity) SELECT 50000002, Product.ProductID, 2 FROM Product WHERE Product.ProductID = 19
INSERT INTO OrdersProduct (OrderID, ProductID, Quantity) SELECT 50000002, Product.ProductID, 1 FROM Product WHERE Product.ProductID = 48
INSERT INTO OrdersProduct (OrderID, ProductID, Quantity) SELECT 50000002, Product.ProductID, 1 FROM Product WHERE Product.ProductID = 51
INSERT INTO OrdersProduct (OrderID, ProductID, Quantity) SELECT 50000003, Product.ProductID, 1 FROM Product WHERE Product.ProductID = 40
INSERT INTO OrdersProduct (OrderID, ProductID, Quantity) SELECT 50000003, Product.ProductID, 1 FROM Product WHERE Product.ProductID = 39
INSERT INTO OrdersProduct (OrderID, ProductID, Quantity) SELECT 50000003, Product.ProductID, 1 FROM Product WHERE Product.ProductID = 3
INSERT INTO OrdersProduct (OrderID, ProductID, Quantity) SELECT 50000003, Product.ProductID, 3 FROM Product WHERE Product.ProductID = 25
INSERT INTO OrdersProduct (OrderID, ProductID, Quantity) SELECT 50000004, Product.ProductID, 1 FROM Product WHERE Product.ProductID = 34
INSERT INTO OrdersProduct (OrderID, ProductID, Quantity) SELECT 50000004, Product.ProductID, 2 FROM Product WHERE Product.ProductID = 52
INSERT INTO OrdersProduct (OrderID, ProductID, Quantity) SELECT 50000004, Product.ProductID, 1 FROM Product WHERE Product.ProductID = 32
INSERT INTO OrdersProduct (OrderID, ProductID, Quantity) SELECT 50000004, Product.ProductID, 1 FROM Product WHERE Product.ProductID = 10
INSERT INTO OrdersProduct (OrderID, ProductID, Quantity) SELECT 50000004, Product.ProductID, 1 FROM Product WHERE Product.ProductID = 11
INSERT INTO OrdersProduct (OrderID, ProductID, Quantity) SELECT 50000005, Product.ProductID, 2 FROM Product WHERE Product.ProductID = 7
INSERT INTO OrdersProduct (OrderID, ProductID, Quantity) SELECT 50000005, Product.ProductID, 1 FROM Product WHERE Product.ProductID = 51
INSERT INTO OrdersProduct (OrderID, ProductID, Quantity) SELECT 50000005, Product.ProductID, 1 FROM Product WHERE Product.ProductID = 42
INSERT INTO OrdersProduct (OrderID, ProductID, Quantity) SELECT 50000005, Product.ProductID, 3 FROM Product WHERE Product.ProductID = 29
INSERT INTO OrdersProduct (OrderID, ProductID, Quantity) SELECT 50000005, Product.ProductID, 2 FROM Product WHERE Product.ProductID = 53
INSERT INTO OrdersProduct (OrderID, ProductID, Quantity) SELECT 50000006, Product.ProductID, 1 FROM Product WHERE Product.ProductID = 44
INSERT INTO OrdersProduct (OrderID, ProductID, Quantity) SELECT 50000006, Product.ProductID, 2 FROM Product WHERE Product.ProductID = 3
INSERT INTO OrdersProduct (OrderID, ProductID, Quantity) SELECT 50000006, Product.ProductID, 3 FROM Product WHERE Product.ProductID = 58
INSERT INTO OrdersProduct (OrderID, ProductID, Quantity) SELECT 50000006, Product.ProductID, 1 FROM Product WHERE Product.ProductID = 45
INSERT INTO OrdersProduct (OrderID, ProductID, Quantity) SELECT 50000006, Product.ProductID, 1 FROM Product WHERE Product.ProductID = 23
INSERT INTO OrdersProduct (OrderID, ProductID, Quantity) SELECT 50000007, Product.ProductID, 1 FROM Product WHERE Product.ProductID = 42
INSERT INTO OrdersProduct (OrderID, ProductID, Quantity) SELECT 50000007, Product.ProductID, 2 FROM Product WHERE Product.ProductID = 43
INSERT INTO OrdersProduct (OrderID, ProductID, Quantity) SELECT 50000007, Product.ProductID, 1 FROM Product WHERE Product.ProductID = 55
INSERT INTO OrdersProduct (OrderID, ProductID, Quantity) SELECT 50000008, Product.ProductID, 2 FROM Product WHERE Product.ProductID = 50
INSERT INTO OrdersProduct (OrderID, ProductID, Quantity) SELECT 50000008, Product.ProductID, 1 FROM Product WHERE Product.ProductID = 51
INSERT INTO OrdersProduct (OrderID, ProductID, Quantity) SELECT 50000009, Product.ProductID, 1 FROM Product WHERE Product.ProductID = 52
INSERT INTO OrdersProduct (OrderID, ProductID, Quantity) SELECT 50000009, Product.ProductID, 1 FROM Product WHERE Product.ProductID = 29
INSERT INTO OrdersProduct (OrderID, ProductID, Quantity) SELECT 50000009, Product.ProductID, 2 FROM Product WHERE Product.ProductID = 30
INSERT INTO OrdersProduct (OrderID, ProductID, Quantity) SELECT 50000009, Product.ProductID, 3 FROM Product WHERE Product.ProductID = 55
INSERT INTO OrdersProduct (OrderID, ProductID, Quantity) SELECT 50000009, Product.ProductID, 1 FROM Product WHERE Product.ProductID = 3
INSERT INTO OrdersProduct (OrderID, ProductID, Quantity) SELECT 50000009, Product.ProductID, 1 FROM Product WHERE Product.ProductID = 5
INSERT INTO OrdersProduct (OrderID, ProductID, Quantity) SELECT 50000009, Product.ProductID, 1 FROM Product WHERE Product.ProductID = 9


-- #################################################################
-- Update the OrdersProduct data and Update the Orders
UPDATE OrdersProduct SET SubTotal = Quantity * (SELECT Price FROM Product WHERE Product.ProductID =  OrdersProduct.ProductID)


UPDATE Orders SET Total = (
	SELECT SUM (SubTotal)
	FROM OrdersProduct
	WHERE Orders.OrderID = OrdersProduct.OrderID )
