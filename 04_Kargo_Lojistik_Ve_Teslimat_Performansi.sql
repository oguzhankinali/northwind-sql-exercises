
-- 1. Kargo Firmalarının Ortalama Teslimat Süreleri
SELECT 
    s.ShipperID,
    s.CompanyName AS KargoFirmasi,
    COUNT(o.OrderID) AS TasinanToplamSiparis,
    AVG(DATEDIFF(day, o.OrderDate, o.ShippedDate)) AS OrtalamaKargoyaVerilmeSuresi,
    AVG(DATEDIFF(day, o.OrderDate, o.RequiredDate)) AS MusterininIstedigiMaksimumSure
FROM Shippers s
INNER JOIN Orders o ON s.ShipperID = o.ShipVia
WHERE o.ShippedDate IS NOT NULL
GROUP BY s.ShipperID, s.CompanyName;

-- 2. Taahhüt Edilen Tarihi Geçen Siparişlerin Ülke Bazlı Dağılımı
SELECT 
    o.ShipCountry AS HedefUlke,
    COUNT(o.OrderID) AS GecikenSiparisAdedi,
    ROUND(SUM(od.UnitPrice * od.Quantity * (1 - od.Discount)), 2) AS GecikmeMaliyeti
FROM Orders o
INNER JOIN [Order Details] od ON o.OrderID = od.OrderID
WHERE o.RequiredDate < o.ShippedDate
GROUP BY o.ShipCountry
ORDER BY GecikenSiparisAdedi DESC;

-- 3. Ülke Bazında Ortalama Kargo Maliyeti Raporu
SELECT 
    o.ShipCountry AS HedefUlke,
    COUNT(o.OrderID) AS ToplamSevkEdilenSiparis,
    ROUND(AVG(o.Freight), 2) AS OrtalamaKargoMaliyeti,
    ROUND(SUM(o.Freight), 2) AS ToplamKargoMaliyeti
FROM Orders o
GROUP BY o.ShipCountry
ORDER BY ToplamKargoMaliyeti DESC;

-- 4. Personel Bazlı Teslimat Performansı 
SELECT 
    e.EmployeeID,
    e.FirstName + ' ' + e.LastName AS CalisanAdSoyad,
    COUNT(o.OrderID) AS YonettigiToplamSiparis,
    AVG(DATEDIFF(day, o.OrderDate, o.ShippedDate)) AS OrtalamaKargolamaSuresiGunu
FROM Employees e
INNER JOIN Orders o ON e.EmployeeID = o.EmployeeID
WHERE o.ShippedDate IS NOT NULL
GROUP BY e.EmployeeID, e.FirstName, e.LastName
ORDER BY OrtalamaKargolamaSuresiGunu ASC;