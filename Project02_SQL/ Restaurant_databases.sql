CREATE TABLE "customers" (
  "CustomerId"	INTEGER UNIQUE,
  "Name"	TEXT NOT NULL,
  "Address"	TEXT NOT NULL,
  "Phone"	TEXT NOT NULL,
  PRIMARY KEY("CustomerId")
);

INSERT INTO customers VALUES
(1, 'Arya', '120 S Orange Ave, 2170', '09 332-3232'),
  (2, 'Music', '302 S 700 E',             '09 622-4200'),
  (3, 'Miew', '212 Berger Street', '09 924-7272'),
(4, 'Ohm', '11, Place Bellecour',             '09 770 3000'),
  (5, 'Emma', 'Celsiusg. 9', '09 870 2000');

CREATE TABLE "menus" (
  "MenuId"	INTEGER,
  "Name"	TEXT NOT NULL,
  "Desciption"	TEXT,
  "UnitPrice"	REAL NOT NULL,
  PRIMARY KEY("MenuId")
);

INSERT INTO menus VALUES
  (1, 'Potato Pizza', 'A fest of nutritous soft potato and bacon', 179),
  (2, 'Super Combo Pizza', 'Our signature blend of fresh 9 toppings',  399),
  (3, 'Bulgogi Pizza', 'Loded with Korean-style bulgogi', 259),
  (4, 'Hawiian Delight Pizza', 'An exotic blend of sweet and sour pineapple ham and mozzarelle cheese', 299),
  (5, 'Lemon Coffee', 'Coffee with fresh lemon mix', 69),
  (6, 'Tea', 'From fresh tea leaves can be served hot or cold', 45),
  (7, 'Water', 'Water', 20),
  (8, 'Vanilla Ice Cream', '1 Scoope vanilla favor with 1 topping', 85);

CREATE TABLE "orders" (
  "OrderId"	INTEGER,
  "CustomerId"	INTEGER NOT NULL,
  "OrderDate"	DATETIME NOT NULL,
  "Total"	INTEGER NOT NULL,
  PRIMARY KEY("OrderId")
);

INSERT INTO orders VALUES
  (1, 2, '2023-01-01 12:00:00', 248),
  (2, 4, '2023-01-02 12:00:00', 763),
  (3, 5, '2023-01-03 12:00:00', 364),
  (4, 1, '2023-01-06 12:00:00', 404),
  (5, 1, '2023-01-11 12:00:00', 543),
  (6, 3, '2023-02-01 12:00:00', 529),
  (7, 2, '2023-02-01 12:00:00', 507),
  (8, 5, '2022-02-03 12:00:00', 309);

CREATE TABLE "order_items" (
  "OrderItemId"	INTEGER,
  "OrderId"	INTEGER NOT NULL,
  "MenuId"	INTEGER NOT NULL,
  "UnitPrice"	REAL NOT NULL,
  "Quantity"	INTEGER NOT NULL,
  PRIMARY KEY("OrderItemId")
);

INSERT INTO order_items VALUES
  (1, 1, 1, 179, 1),
  (2, 1, 5, 69, 1),
  (3, 2, 2, 399, 1),
  (4, 2, 4, 299, 1),
  (5, 2, 6, 45, 1),
  (6, 2, 7, 20, 1),
  (7, 3, 3, 259, 1),
  (8, 3, 7, 20, 1),
  (9, 3, 8, 85, 1),
  (10, 4, 4, 299, 1),
  (11, 4, 7, 20, 1),
  (12, 4, 8, 85, 1),
  (13, 5, 1, 179, 1),
  (14, 5, 3, 259, 1),
  (15, 5, 7, 20, 1),
  (16, 5, 8, 85, 1),
  (17, 6, 2, 399, 1),
  (18, 6, 6, 45, 1),
  (19, 6, 8, 85, 1),
  (20, 7, 1, 179, 1),
  (21, 7, 3, 259, 1),
  (22, 7, 5, 69, 1),
  (23, 8, 1, 179, 1), 
  (24, 8, 6, 45, 1),
  (25, 8, 8, 85, 1);

.mode box
-- JOIN Syntax
SELECT 
  orders.OrderId as OrderID,
  customers.Name as Customer_Name,
  orders.OrderDate as Order_Date,
  menus.Name as Menu_Name,
  order_items.UnitPrice as UnitPrice,
  order_items.Quantity as Quantity
FROM customers
INNER JOIN orders
 ON customers.CustomerId = orders.CustomerId
INNER JOIN order_items
 ON order_items.OrderId = orders.OrderId
INNER JOIN menus
 ON menus.MenuId = order_items.MenuId;

-- Subqueries or WITH 
SELECT CustomerId, Name FROM (
  SELECT * FROM customers
  WHERE CustomerId BETWEEN 3 AND 5) as t1
INNER JOIN (
  SELECT * from orders
  WHERE STRFTIME("%Y-%m", OrderDate) = "2023-02"
  ) as t2
ON t1.CustomerId = t2.CustomerId
GROUP BY 1;

-- Aggregate Functions
SELECT 
  customers.CustomerId as CustomerId,
  customers.Name as Customer_Name,
  COUNT(orders.OrderId) as Count_orderid,
  AVG(orders.Total) as Avg_total,
  MIN(orders.Total) as Min_total,
  MAX(orders.Total) as Max_total
FROM customers
  INNER JOIN orders ON customers.CustomerId = orders.CustomerId
  INNER JOIN order_items ON order_items.OrderId = orders.OrderId
  INNER JOIN menus ON menus.MenuId = order_items.MenuId
GROUP BY 1;
  
SELECT * from orders
WHERE STRFTIME("%Y-%m", OrderDate = "2023-02"
) as t2
