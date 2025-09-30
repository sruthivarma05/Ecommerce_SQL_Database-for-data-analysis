CREATE DATABASE EcommerceDB;
USE EcommerceDB;

DROP TABLE IF EXISTS Orders;
DROP TABLE IF EXISTS Customers;

CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    Name VARCHAR(50),
    City VARCHAR(50)
);

CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    OrderDate DATE,
    Amount DECIMAL(10,2),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);
INSERT INTO Customers (CustomerID, Name, City) VALUES
(1, 'Siya', 'Mumbai'),
(2, 'Riya', 'Delhi'),
(3, 'Priya', 'Bangalore'),
(4, 'Diya', 'Hyderabad'),
(5, 'Manya', 'Chennai');

INSERT INTO Orders (OrderID, CustomerID, OrderDate, Amount) VALUES
(101, 1, '2025-01-10', 250.00),
(102, 2, '2025-01-12', 450.00),
(103, 1, '2025-02-01', 300.00),
(104, 3, '2025-02-15', 700.00),
(105, 4, '2025-03-05', 150.00),
(106, 2, '2025-03-20', 900.00),
(107, 5, '2025-04-01', 100.00);

SELECT Name, City
FROM Customers
WHERE City = 'Mumbai'
ORDER BY Name ASC;

SELECT CustomerID, SUM(Amount) AS TotalSpent, AVG(Amount) AS AvgSpent
FROM Orders
GROUP BY CustomerID
ORDER BY TotalSpent DESC;

-- INNER JOIN
SELECT c.Name, o.OrderID, o.Amount
FROM Customers c
INNER JOIN Orders o ON c.CustomerID = o.CustomerID;

-- LEFT JOIN
SELECT c.Name, o.OrderID, o.Amount
FROM Customers c
LEFT JOIN Orders o ON c.CustomerID = o.CustomerID;

-- RIGHT JOIN
SELECT c.Name, o.OrderID, o.Amount
FROM Customers c
RIGHT JOIN Orders o ON c.CustomerID = o.CustomerID;

SELECT Name
FROM Customers
WHERE CustomerID IN (
    SELECT CustomerID
    FROM Orders
    WHERE Amount > 500
);

SELECT CustomerID, SUM(Amount) AS TotalSpent, AVG(Amount) AS AvgOrder
FROM Orders
GROUP BY CustomerID
ORDER BY TotalSpent DESC;

CREATE OR REPLACE VIEW CustomerOrderSummary AS
SELECT c.Name, SUM(o.Amount) AS TotalSpent, COUNT(o.OrderID) AS OrdersCount
FROM Customers c
INNER JOIN Orders o ON c.CustomerID = o.CustomerID
GROUP BY c.Name;

-- Query the view
SELECT * FROM CustomerOrderSummary;

CREATE INDEX idx_orders_customerid ON Orders(CustomerID);
CREATE INDEX idx_orders_amount ON Orders(Amount);





