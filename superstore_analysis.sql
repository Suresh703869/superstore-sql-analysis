LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/train.csv'
INTO TABLE train
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;
SELECT COUNT(*) FROM train;
SELECT * FROM train LIMIT 5;
SELECT ProductName, SUM(Sales) AS total_sales
FROM train
GROUP BY ProductName
ORDER BY total_sales DESC
LIMIT 10;
SELECT DATE_FORMAT(STR_TO_DATE(OrderDate, '%d/%m/%Y'), '%Y-%m') AS month,
       SUM(Sales) AS total_sales
FROM train
GROUP BY month
ORDER BY month;
SELECT CustomerName, SUM(Sales) AS total_spend
FROM train
GROUP BY CustomerName
ORDER BY total_spend DESC
LIMIT 10;
SELECT DATE_FORMAT(STR_TO_DATE(OrderDate, '%d/%m/%Y'), '%Y-%m') AS month,
       SUM(Sales) AS total_sales
FROM train
GROUP BY month
ORDER BY month;
SELECT DATE_FORMAT(STR_TO_DATE(OrderDate, '%d/%m/%Y'), '%Y-%m') AS month,
       SUM(Sales) AS monthly_sales,
       SUM(SUM(Sales)) OVER (ORDER BY DATE_FORMAT(STR_TO_DATE(OrderDate, '%d/%m/%Y'), '%Y-%m')) AS running_total
FROM train
GROUP BY month
ORDER BY month;
SELECT Category, ProductName, SUM(Sales) AS total_sales,
       RANK() OVER (PARTITION BY Category ORDER BY SUM(Sales) DESC) AS category_rank
FROM train
GROUP BY Category, ProductName
ORDER BY Category, category_rank
LIMIT 20;
SELECT DATE_FORMAT(STR_TO_DATE(OrderDate, '%d/%m/%Y'), '%Y-%m') AS month,
       SUM(Sales) AS monthly_sales,
       SUM(SUM(Sales)) OVER (ORDER BY DATE_FORMAT(STR_TO_DATE(OrderDate, '%d/%m/%Y'), '%Y-%m')) AS running_total
FROM train
GROUP BY month
ORDER BY month;