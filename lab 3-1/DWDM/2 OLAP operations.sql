CREATE TABLE Sales2 (
    Sale_ID INT PRIMARY KEY,
    Date DATE,
    Region VARCHAR(20),
    City VARCHAR(20),
    Product VARCHAR(20),
    Category VARCHAR(20),
    Sales_Amount DECIMAL(10,2),
    Year INT
);


INSERT INTO Sales2 VALUES (1, '2024-01-05', 'East', 'Kolkata', 'Laptop', 'Electronics', 50000, 2024);
INSERT INTO Sales2 VALUES (2, '2024-02-10', 'East', 'Kolkata', 'Mobile', 'Electronics', 20000, 2024);
INSERT INTO Sales2 VALUES (3, '2024-03-15', 'East', 'Bhubaneswar', 'Laptop', 'Electronics', 55000, 2024);
INSERT INTO Sales2 VALUES (4, '2024-04-20', 'West', 'Mumbai', 'TV', 'Electronics', 30000, 2024);
INSERT INTO Sales2 VALUES (5, '2024-05-25', 'West', 'Pune', 'Laptop', 'Electronics', 52000, 2024);
INSERT INTO Sales2 VALUES (6, '2023-11-15', 'East', 'Kolkata', 'Laptop', 'Electronics', 48000, 2023);



-- OLAP Operation 1: ROLL-UP (City → Region)
SELECT Region, SUM(Sales_Amount) AS Total_Sales
FROM sales2
GROUP BY Region;


-- OLAP Operation 2: DRILL-DOWN (Region → City)
SELECT Region, City, SUM(Sales_Amount) AS Total_Sales
FROM sales2
GROUP BY Region, City;


-- OLAP Operation 3: SLICE (Filter Year = 2024)
SELECT * FROM Sales2
WHERE Year = 2024;


-- OLAP Operation 4: DICE (Filter Region = 'East' AND Category = 'Electronics')
SELECT * FROM Sales2
WHERE Region = 'East' AND Category = 'Electronics';


-- OLAP Operation 5: PIVOT (Product-wise Sales for 2023 and 2024)
SELECT Product,
    SUM(CASE WHEN Year = 2023 THEN Sales_Amount ELSE 0 END) AS Sales_2023,
    SUM(CASE WHEN Year = 2024 THEN Sales_Amount ELSE 0 END) AS Sales_2024
FROM sales2
GROUP BY Product;


