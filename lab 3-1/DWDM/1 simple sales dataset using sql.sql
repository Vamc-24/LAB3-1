-- star schema 
-- product dimension
CREATE TABLE product ( productID INT,
                        productname VARCHAR);

-- customer dimensions
CREATE TABLE customer ( customerID INT,
                        customername VARCHAR);

-- Time dimensions
CREATE TABLE Time ( TimeID INT,
                    Month VARCHAR);

-- Fact table
CREATE TABLE Sales ( saleID INT,
                    productID INT,
                    customerID INT,
                    TimeID INT,
                    Quantity INT,
                    Amount DECIMAL);




-- sample data 
INSERT INTO product VALUES  (1,'Laptop'),
                            (2,'Mouse'),
                            (3,'Printer');

INSERT INTO customer VALUES (101,'Alice'),
                            (102,'Bob'),
                            (103,'Eve');

INSERT INTO Time VALUES (1001,'January'),
                        (1002,'February'),
                        (1003,'March');


INSERT INTO sales VALUES (1,1,101,1001,2,2000.00),
                         (2,2,102,1002,5,150.00),
                         (3,3,103,1003,1,300.00),
                         (4,1,102,1002,1,1000.00),
                         (5,2,101,1001,3,90.00),
                         (6,3,102,1003,2,600.00);




-- star schema o/p query
SELECT s.saleID,p.productname,c.customername,t.Month,s.Quantity,s.Amount
FROM sales s
JOIN product p on s.productid=p.productid
JOIN customer c on s.customerid=c.customerid
JOIN Time t on s.timeid=t.timeid;