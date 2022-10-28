CREATE DATABASE eCommerce
use eCommerce

-- Query untuk pembuatan TABLE Customer
CREATE TABLE Customer(
	CustomerID CHAR(5) NOT NULL PRIMARY KEY,
	CONSTRAINT cekCustomerID 
	CHECK(CustomerID LIKE 'CU[0-9][0-9][0-9]'),

	CustomerName VARCHAR(50) NOT NULL,

	CustomerGender VARCHAR(10),
	CONSTRAINT cekCustomerGender 
	CHECK(CustomerGender = 'Male' or CustomerGender = 'Female'),

	CustomerPhone VARCHAR(13),

	CustomerAddress VARCHAR(100)
)

-- Query untuk pembuatan TABLE Staff
CREATE TABLE Staff(
	StaffID CHAR(5) NOT NULL PRIMARY KEY,
	CONSTRAINT cekStaffID 
	CHECK(StaffID LIKE 'SF[0-9][0-9][0-9]'),
	
	StaffName VARCHAR(50) NOT NULL,

	StaffGender VARCHAR(10),
	CONSTRAINT cekStaffGender 
	CHECK(StaffGender = 'Male' or StaffGender = 'Female'),

	StaffPhone VARCHAR(13),

	StaffAddress VARCHAR(100),

	StaffSalary NUMERIC(11,2),

	StaffPosition VARCHAR(20)
)

-- Query untuk pembuatan TABLE ItemType
CREATE TABLE ItemType(
	ItemTypeID CHAR(5) NOT NULL PRIMARY KEY,
	CONSTRAINT cekItemTypeID
	CHECK(ItemTypeID LIKE 'IT[0-9][0-9][0-9]'),

	ItemTypeName VARCHAR(50) NOT NULL,
)

-- Query untuk pembuatan TABLE Item
CREATE TABLE Item(
	ItemID CHAR(5) NOT NULL PRIMARY KEY,
	
	-- ItemTypeID disini adalah Foreign Key
	ItemTypeID CHAR(5) REFERENCES ItemType ON UPDATE CASCADE ON DELETE CASCADE,

	ItemName VARCHAR(50) NOT NULL,

	Price NUMERIC(11,2),

	Quantity INTEGER,

	CONSTRAINT cekItemID
	CHECK(ItemID LIKE 'IM[0-9][0-9][0-9]')
)

-- Query untuk pembuatan TABLE HeaderSellTransaction
CREATE TABLE HeaderSellTransaction(
	TransactionID CHAR(5) NOT NULL PRIMARY KEY,
	
	-- CustomerID disini adalah Foreign Key
	CustomerID CHAR(5) NOT NULL REFERENCES Customer ON UPDATE CASCADE ON DELETE CASCADE,

	-- StaffID disini adalah Foreign Key
	StaffID CHAR(5) REFERENCES Staff ON UPDATE CASCADE ON DELETE CASCADE,

	TransactionDate DATE,

	PaymentType VARCHAR(20),

	CONSTRAINT cekTransactionID
	CHECK(TransactionID LIKE 'TR[0-9][0-9][0-9]')
)

-- Query untuk pembuatan TABLE DetailSellTransaction
CREATE TABLE DetailSellTransaction(
	-- TransactionID disini adalah Foreign Key
	TransactionID CHAR(5) REFERENCES HeaderSellTransaction ON UPDATE CASCADE ON DELETE CASCADE,

	-- ItemID disini adalah Foreign Key
	ItemID CHAR(5) REFERENCES Item ON UPDATE CASCADE ON DELETE CASCADE,

	SellQuantity INTEGER,

	PRIMARY KEY(TransactionID, ItemID)
)
-- Query untuk menghapus TABLE DetailSellTransaction
DROP TABLE DetailSellTransaction

-- Query untuk menambahkan kolom pada TABLE Item
ALTER TABLE Item
ADD "Description" VARCHAR(100)

-- Query untuk menghapus kolom pada TABLE Item
ALTER TABLE Item
DROP COLUMN	"Description"

-- Query untuk menampilkan data

-- SELECT kolom1, kolom2,...
-- FROM nama_table 

SELECT *
FROM Staff

SELECT *
FROM Customer

SELECT *
FROM Item

SELECT *
FROM ItemType

SELECT *
FROM HeaderSellTransaction

SELECT *
FROM DetailSellTransaction

-- Left adalah function mengambil karakter dari kiri.
-- Left = LEFT(nama_kolom, berapa digit)
SELECT [Jenis Kelamin] = LEFT(StaffGender,1)
FROM Staff

-- Right adalah function mengambil karakter dari kanan.
-- Right = RIGHT(nama_kolom, berapa digit)
SELECT [Test Right] = RIGHT(StaffName,2)
FROM Staff

-- Reverse adalah function membalikan kalimat.
-- Reverse = REVERSE(nama_kolom)
SELECT [Balik Nama] = REVERSE(StaffName)
FROM Staff

-- Charindex adalah mencari satu karakter pada satu kolom.
-- Charindex = CHARINDEX('mau_cari_apa', nama_kolom)
SELECT [Index Huruf O] = CHARINDEX('o',StaffName)
FROM Staff
--Where adalah perintah untuk menambahkan kondisi.
WHERE StaffPhone = '080152852175'

-- Substring adalah mengambil string didalam string.
-- Substring = SUBSTRING(nama_kolom, start, berapa_digit)
SELECT [Index ke2 4 huruf] = SUBSTRING(StaffName, 2, 4)
FROM Staff

-- Menggabungkan Substring dan charindex untuk menemukan nama depan dari staffname.
-- -1 untuk menghapus spasi terakhir
SELECT [Kata Pertama] = SUBSTRING(StaffName,1, CHARINDEX(' ', StaffName)-1)
FROM Staff

-- Upper adalah membuat semua menjadi huruf besar
-- Upper = UPPER(nama_kolom)
SELECT [Nama Huruf Besar] = UPPER(StaffName)
FROM Staff

-- Lower adalah membuat semua menjadi huruf kecil
-- UppLowerer = LOWER(nama_kolom)
SELECT [Nama Huruf Kecil] = LOWER(StaffName)
FROM Staff

--MAX
SELECT [Gaji Terbesar] = MAX(StaffSalary)
FROM Staff

--MIN
SELECT [Gaji Terkecil] = MIN(StaffSalary)
FROM Staff

--AVG
SELECT [Gaji Rata-rata] = AVG(StaffSalary)
FROM Staff

--COUNT
SELECT COUNT(TransactionID)
FROM HeaderSellTransaction

--SUM
SELECT [Total Gaji] = SUM(StaffSalary)
FROM Staff

--DATE FUNCTION

-- DATENAME adalah mengetahui value terjadi pada tanggal berapa
-- DATENAME = DATENAME(interval, date)
-- interval = Day, weekday, month, year)
SELECT DATENAME(WEEKDAY, TransactionDate)
FROM HeaderSellTransaction

-- DATEDIFF adalah mengetahui selisih tanggal.
-- DATEDIFF = DATEDIFF(interval, tanggal_pertama, tanggal_kedua)
SELECT DATEDIFF(YEAR, '1945/08/17', '2020/08/17')

-- DATEADD adalah menambahkan data tanggal
-- DATEADD = DATEADD(interval, mau_tambah_berapa, date)
SELECT DATEADD(YEAR, 3, '1945/08/17')

-- ADVANCE FUNCTION

-- Cast adalah merubah typedata dari suatu kolom tapi hanya berubah di tampilan, databasenya tidak.
-- Cast = CAST(nama_kolom as tipe_data_yang_diinginkan)
SELECT [Gaji] = 'Rp' + CAST(StaffSalary AS VARCHAR)
FROM Staff

-- Convert adalah mengubah penulisan dari suatu data.
-- CONVERT block lalu tekan F1
-- Convert = CONVERT(tipe_data_yang_diinginkan, nama_kolom, kode_tujuan)
SELECT * 
FROM HeaderSellTransaction

SELECT [Tanggal Convert] = CONVERT(VARCHAR, TransactionDate, 107)
FROM HeaderSellTransaction

-- INSERT
-- menambahkan data 
SELECT * 
FROM Customer

BEGIN TRANSACTION
INSERT INTO Customer VALUES
('CU006', 'Alex', 'Male', '123123123', 'Jalan Bunga')
COMMIT

BEGIN TRANSACTION
INSERT INTO Customer (CustomerID, CustomerName) VALUES
('CU007', 'Alexa')
ROLLBACK

BEGIN TRANSACTION
INSERT INTO Customer VALUES
('CU007', 'Putri', 'Female', '12331231233', 'Jalan Kelopak')
COMMIT

BEGIN TRANSACTION
INSERT INTO Customer VALUES
('CU008', 'Rais', 'Male', '058058058', 'Jalan Melrose'),
('CU009', 'Yoga', 'Male', '090909090', 'Jalan Melrose')
COMMIT

-- DELETE
-- menghapus data
SELECT * 
FROM Customer

BEGIN TRANSACTION
DELETE FROM Customer 
WHERE CustomerName = 'Putri'
COMMIT

BEGIN TRANSACTION
DELETE FROM Customer
WHERE CustomerPhone = '123123123'
COMMIT

BEGIN TRANSACTION
DELETE FROM Customer
WHERE CustomerAddress = 'Jalan Melrose'
COMMIT

SELECT *
FROM HeaderSellTransaction

BEGIN TRANSACTION
DELETE FROM HeaderSellTransaction
WHERE DATENAME(DAY, TransactionDate) = 21
ROLLBACK

-- JOIN TABLE

SELECT CustomerName
FROM Customer cs, HeaderSellTransaction hst
WHERE cs.CustomerID = hst.CustomerID AND 
DATENAME(DAY, TransactionDate) = 21

-- LATIHAN

-- 1
SELECT *
FROM Customer

SELECT * 
FROM HeaderSellTransaction

BEGIN TRAN
UPDATE Customer
SET CustomerName = LEFT(CustomerName, CHARINDEX(' ', CustomerName)-1)
FROM Customer cs, HeaderSellTransaction hst
WHERE cs.CustomerID = hst.CustomerID AND 
DATENAME(DAY, TransactionDate) = 21
ROLLBACK

-- 2
BEGIN TRAN
UPDATE HeaderSellTransaction
SET PaymentType = 'Hutang'
FROM Customer cs, HeaderSellTransaction hst
WHERE cs.CustomerID = hst.CustomerID AND
cs.CustomerID = 'CU001'
ROLLBACK

-- 3
SELECT * 
FROM STAFF

BEGIN TRAN
DELETE Staff
WHERE StaffSalary < 7000000
ROLLBACK

-- 4
SELECT TransactionDate, CustomerName, ItemName, [Discount] = 0.2 * Price, PaymentType
FROM Customer cs, HeaderSellTransaction hst, DetailSellTransaction dst, Item im
WHERE cs.CustomerID = hst.CustomerID AND hst.TransactionID = dst.TransactionID AND
dst.ItemID = im.ItemID AND 
DATENAME(DAY, TransactionDate) = 22

-- AGGREGATE

-- MAX
SELECT MAX(StaffSalary)
FROM Staff

-- MIN
SELECT MIN(StaffSalary)
FROM Staff

-- AVG
SELECT AVG(StaffSalary)
FROM Staff

-- COUNT
SELECT COUNT(StaffSalary)
FROM Staff

-- SUM
SELECT SUM(StaffSalary)
FROM Staff


-- LATIHAN AGGREGATE

-- 1
SELECT [Maksimum Price] = MAX(Price), [Minimum Price] = MIN(Price), [Rata-Rata Price] = AVG(Price)
FROM Item

-- 2
SELECT [Gender] = LEFT(StaffGender, 1), [Rata-rata Salary] = AVG(StaffSalary)
FROM Staff
GROUP BY StaffGender

SELECT StaffPosition, [Rata-rata Salary] = AVG(StaffSalary)
FROM Staff
GROUP BY StaffPosition

-- 3
SELECT ItemTypeName, [Total Transaction] = COUNT(TransactionID)
FROM ItemType it, Item im, DetailSellTransaction dst
WHERE dst.ItemID = im.ItemID AND im.ItemTypeID = it.ItemTypeID
GROUP BY ItemTypeName

-- 4
SELECT TransactionID, [Total Quantity] = SUM(SellQuantity)
FROM DetailSellTransaction
GROUP BY TransactionID


-- ORDER BY
-- mengurutkan sesuatu

SELECT *
FROM Staff
-- ASCENDING = ASC (KECIL KE BESAR)
-- DISCENDING = DESC (BESAR KE KECIL)
ORDER BY StaffName DESC


-- HAVING
-- HAVING ADALAH WHERE VERSI AGGREGATE

SELECT ItemTypeID, SUM(Quantity)
FROM Item
GROUP BY ItemTypeID

SELECT ItemTypeID
FROM Item
GROUP BY ItemTypeID
HAVING SUM(Quantity) > 100


-- SUBQUERY
-- SUBQUERY ADALAH QUERY DI DALAM QUERY
-- BISA MENGGUNAKAN SUBQUERY UNTUK ME-RETURN ATAU MENGEMBALIKAN DATA YANG AKAN KITA GUNAKAN PADA QUERY UTAMANYA.

-- IN (FILTER)
-- MEMUNGKINKAN KITA UNTUK MENGUJI APAKAH VALUE YANG KITA CARI ADA DI DALAM IN

SELECT *
FROM Staff

SELECT *
FROM Staff
WHERE StaffPosition IN ('Cashier', 'Supervisor')

SELECT *
FROM Staff
WHERE StaffID IN (
	SELECT StaffID
	FROM Staff
	WHERE StaffSalary > 7000000
)

-- EXIST
-- OPERATOR YANG DIGUNAKAN UNTUK MENGETAHUI APAKAH SUBQUERY KITA MENGEMBALIKAN SESUATU
SELECT *
FROM Staff
WHERE EXISTS(
	SELECT StaffID
	WHERE StaffSalary > 7000000

)

-- ALIAS SUBQUERY
-- SUBQUERY YANG MEMILIKI ALIAS/NAMA LAIN
SELECT *
FROM Item

SELECT AVG(Price)
FROM Item

SELECT ItemName, Price
FROM Item, (SELECT [Rata2] = AVG(Price) FROM Item) as tt
WHERE Price > tt.Rata2


-- VIEW
-- VIRTUAL TABLE

SELECT *
FROM Staff
WHERE StaffGender = 'Male'

CREATE VIEW [List Staff Male] AS
SELECT *
FROM Staff
WHERE StaffGender = 'Male'

SELECT * FROM [List Staff Male]

DROP VIEW [List Staff Male]

CREATE VIEW [List Staff Female] AS
SELECT StaffName
FROM Staff
WHERE StaffGender = 'Female'

SELECT * FROM [List Staff Female]

ALTER VIEW [List Staff Female] AS
SELECT [Nama Depan] = LEFT(StaffName, CHARINDEX(' ', Staffname)-1),
		[Gender] = LEFT(StaffGender, 1)
FROM Staff
WHERE StaffGender = 'Female'


-- ROLE & PERMISSION

