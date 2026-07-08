-- Sorgu 1: Her bir çalışanın  toplam kaç adet sipariş sattığını listeleyen sorgu.

SELECT EmployeeID
FROM Orders 
GROUP BY EmployeeID;
GO

-- Sorgu 2: Kargo firmalarının toplam kaçar adet sipariş taşıdığını bulan sorgu.

SELECT ShipVia,
	   COUNT(*) AS 'Total Shipped Orders'
FROM Orders 
GROUP BY ShipVia;
GO

-- Sorgu 3: Şirketin stoğunda bulunan toplam ürün çeşidi sayısını ve ortalama ürün fiyatını raporlayan sorgu.

SELECT COUNT(ProductID) AS 'Total Product Variety',
	   AVG(UnitPrice) AS 'Average Product Price'
FROM Products WHERE UnitsInStock != 0;
GO

-- Sorgu 4: Her bir ülkeden  toplam kaç farklı müşterimiz olduğunu listeleyen ve çoktan aza sıralayan sorgu.

SELECT Country,
	   COUNT(CustomerID) As 'Customer Count'
FROM Customers 
GROUP BY Country 
ORDER BY 'Customer Count' DESC;
GO

-- Sorgu 5: Hangi kategoride toplam kaç adet ürünümüz olduğunu ve o kategorideki en pahalı ürünün fiyatını bulan sorgu.

SELECT CategoryID,
       COUNT(ProductID) AS 'Product Count',
       MAX(UnitPrice) AS 'Most Expensive Price'
FROM Products
GROUP BY CategoryID;
GO

-- Sorgu 6: Şirketin şu ana kadar elde ettiği en yüksek, en düşük ve ortalama kargo taşıma ücretini raporlayan sorgu.

SELECT MAX(Freight) AS 'Maximum Freight',
       MIN(Freight) AS 'Minimum Freight',
       AVG(Freight) AS 'Average Freight'
FROM Orders;
GO

-- Sorgu 7: Her bir bölgedeki toplam çalışan sayısını bulan sorgu.

SELECT Region, 
       COUNT(EmployeeID) AS 'Employee Count'
FROM Employees
GROUP BY Region;
GO

-- Sorgu 8: Ürünleri fiyatı 50 birimden pahalı olan ve ucuz olanlar diye gruplayıp kaçar çeşit olduğunu listeleyen sorgu.

SELECT CASE 
            WHEN UnitPrice > 50 THEN 'Expensive Products (50+)'
            ELSE 'Economic Products (0-50)'
       END AS 'Price Category',
       COUNT(ProductID) AS 'Product Count'
FROM Products
WHERE UnitsInStock != 0
GROUP BY CASE 
            WHEN UnitPrice > 50 THEN 'Expensive Products (50+)'
            ELSE 'Economic Products (0-50)'
         END;
GO

