CREATE TABLE ProductDetail (
  OrderID INT,
  CustomerName VARCHAR(100),
  Products VARCHAR(255)
);

INSERT INTO ProductDetail VALUES
(101, 'John Doe', 'Laptop, Mouse'),
(102, 'Jane Smith', 'Tablet, Keyboard, Mouse'),
(103, 'Emily Clark', 'Phone');




-- Create a helper numbers table for splitting (1 to 3)
CREATE TEMPORARY TABLE numbers (n INT);
INSERT INTO numbers VALUES (1),(2),(3);

-- Query to split products into multiple rows (1NF)
SELECT 
  pd.OrderID,
  pd.CustomerName,
  TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(pd.Products, ',', n.n), ',', -1)) AS Product
FROM ProductDetail pd
JOIN numbers n ON CHAR_LENGTH(pd.Products) - CHAR_LENGTH(REPLACE(pd.Products, ',', '')) >= n.n - 1
ORDER BY pd.OrderID, n.n;






CREATE TABLE OrderDetails (
  OrderID INT,
  CustomerName VARCHAR(100),
  Product VARCHAR(100),
  Quantity INT,
  PRIMARY KEY(OrderID, Product)
);

INSERT INTO OrderDetails VALUES
(101, 'John Doe', 'Laptop', 2),
(101, 'John Doe', 'Mouse', 1),
(102, 'Jane Smith', 'Tablet', 3),
(102, 'Jane Smith', 'Keyboard', 1),
(102, 'Jane Smith', 'Mouse', 2),
(103, 'Emily Clark', 'Phone', 1);






-- Table 1: Orders (OrderID, CustomerName)
CREATE TABLE Orders (
  OrderID INT PRIMARY KEY,
  CustomerName VARCHAR(100)
);

INSERT INTO Orders (OrderID, CustomerName)
SELECT DISTINCT OrderID, CustomerName FROM OrderDetails;

-- Table 2: OrderItems (OrderID, Product, Quantity)
CREATE TABLE OrderItems (
  OrderID INT,
  Product VARCHAR(100),
  Quantity INT,
  PRIMARY KEY (OrderID, Product),
  FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);

INSERT INTO OrderItems (OrderID, Product, Quantity)
SELECT OrderID, Product, Quantity FROM OrderDetails;
