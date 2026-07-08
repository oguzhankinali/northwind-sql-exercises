--Tarih_ve_Metin_Fonksiyonlari

-- Tüm çalışanların adını, soyadını, unvanını, yaşını ve şirketteki çalışma yılını hesaplayan sorgu.
SELECT FirstName + ' ' + LastName as 'Employee', 
	   Title,
	   DATEDIFF(year,BirthDate, GetDate()) as 'Age',
	   DATEDIFF(year,HireDate, GetDate()) as 'Work year'
FROM Employees
GO

-- Sorgu 2: Çalışanların adını ve soyadını tek bir kolonda birleştirip yanına kurumsal e-postalarını otomatik üreten sorgu.
SELECT FirstName + ' ' + LastName AS 'Employee Full Name',
       LOWER(FirstName + '.' + LastName + '@northwind.com') AS 'Corporate Email'
FROM Employees;
GO

-- Sorgu 3: Şirkete 1993 yılının başından sonra katılmış olan çalışanların listesini getiren sorgu.

SELECT FirstName, LastName, HireDate
FROM Employees
WHERE YEAR(HireDate) >= 1993;
GO

-- Sorgu 4: Kargo firmalarının isimlerini büyük harfe çevirerek listeleyen sorgu.
SELECT UPPER(CompanyName) AS 'LOGISTICS COMPANY'
FROM Shippers;
GO

--Sorgu 5: Doğum günü bu ay olan çalışanları listele.
SELECT FirstName, LastName, BirthDate
FROM Employees
WHERE MONTH(BirthDate) = MONTH(GetDate());
GO
