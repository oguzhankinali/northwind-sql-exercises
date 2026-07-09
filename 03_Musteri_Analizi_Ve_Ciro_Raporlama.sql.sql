
-- 1. En Yüksek Ciro Yapan İlk 10 Müşteri ve Toplam Harcamaları
SELECT TOP 10 
    c.CustomerID,
    c.CompanyName,
    c.Country,
    COUNT(o.OrderID) AS ToplamSiparisAdedi,
    ROUND(SUM(od.UnitPrice * od.Quantity * (1 - od.Discount)), 2) AS ToplamNetCiro
FROM Customers c
INNER JOIN Orders o ON c.CustomerID = o.CustomerID
INNER JOIN [Order Details] od ON o.OrderID = od.OrderID
GROUP BY c.CustomerID, c.CompanyName, c.Country
ORDER BY ToplamNetCiro DESC;

-- 2. Yıllara Göre Toplam Sipariş Adedi ve Ciro Dağılımı
SELECT 
    YEAR(o.OrderDate) AS SatisYili,
    COUNT(DISTINCT o.OrderID) AS ToplamSiparisSayisi,
    ROUND(SUM(od.UnitPrice * od.Quantity * (1 - od.Discount)), 2) AS YillikNetCiro
FROM Orders o
INNER JOIN [Order Details] od ON o.OrderID = od.OrderID
GROUP BY YEAR(o.OrderDate)
ORDER BY SatisYili ASC;

-- 3. Hiç Sipariş Vermemiş Müşterilerin Tespiti 
SELECT 
    c.CustomerID, 
    c.CompanyName, 
    c.ContactName, 
    c.Phone
FROM Customers c
LEFT JOIN Orders o ON c.CustomerID = o.CustomerID
WHERE o.OrderID IS NULL;

-- 4. RFM Analizi Altyapısı: Müşterilerin Son Sipariş Tarihi ve Toplam Harcaması
SELECT 
    c.CustomerID,
    c.CompanyName,
    MAX(o.OrderDate) AS SonSiparisTarihi,
    DATEDIFF(day, MAX(o.OrderDate), '1998-05-06') AS KacGunOnceSiparisVerdi, -- Northwind son tarihine göre
    COUNT(o.OrderID) AS SiparisSıklığı,
    ROUND(SUM(od.UnitPrice * od.Quantity * (1 - od.Discount)), 2) AS ToplamBıraktığıCiro
FROM Customers c
INNER JOIN Orders o ON c.CustomerID = o.CustomerID
INNER JOIN [Order Details] od ON o.OrderID = od.OrderID
GROUP BY c.CustomerID, c.CompanyName
ORDER BY KacGunOnceSiparisVerdi DESC;