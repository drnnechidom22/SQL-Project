---Introduce data
SELECT *
FROM Projects.dbo.Sales

---Select all customers from a specific country, state and Product
SELECT *
FROM Projects.dbo.Sales
WHERE Country = 'Germany' and State = 'Bayern' and Product = 'Mountain Bottle Cage'

---Calculate the average age of customers
SELECT AVG(Customer_Age) AS Average_Customer_Age
FROM Projects.dbo.Sales

---Sum the profit and revenue by product category
SELECT Product_Category, SUM(Profit) AS Total_Profit, SUM(Revenue) AS Total_Revenue
FROM Projects.dbo.Sales
GROUP BY Product_Category

---Find the top-selling products by quantity sold
SELECT Product, SUM(Order_Quantity) AS Total_Quantity
FROM Projects.dbo.Sales
GROUP BY Product
ORDER BY Total_Quantity DESC

---Retrieve customers who made a purchase in a specific month or year
SELECT *
FROM Projects.dbo.Sales
WHERE Month = '9' and Year = '2013'

---Calculate the total cost and profit for each product
SELECT Product, SUM(Cost) AS Total_Cost, SUM(Profit) AS Total_Profit
FROM Projects.dbo.Sales
GROUP BY Product

---Group customers by age group and count the number of customers in each group
SELECT Age_Group, COUNT(*) AS Total_Customers
FROM Projects.dbo.Sales
GROUP BY Age_Group

---Identify countries or states with the highest revenue
SELECT Country, State, SUM(Revenue) AS Highest_Revenue
FROM Projects.dbo.Sales
GROUP BY Country, State
ORDER BY Highest_Revenue DESC

---Find the products with the highest profit margin
SELECT Product, (Profit/Cost) AS Profit_Margin
FROM Projects.dbo.Sales
ORDER BY Profit_Margin DESC

---Calculate the average unit price for each sub-category
SELECT Sub_Category, AVG(Unit_Price) AS Avg_Unit_Price
FROM Projects.dbo.Sales
GROUP BY Sub_Category
ORDER BY Avg_Unit_Price DESC