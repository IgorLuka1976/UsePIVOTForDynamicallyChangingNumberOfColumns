---Important
USE AdventureWorks2019
GO

DECLARE @listOFDays NVARCHAR(MAX),@startDate DATE, @endDate DATE,@filter NVARCHAR(MAX)

SET @startDate='20110414'
SET @endDate='20110701'

------Create List with dates

;WITH allDates
AS
(
SELECT DISTINCT
  TransactionDate
FROM Production.TransactionHistoryArchive
WHERE TransactionDate>=@startDate AND TransactionDate<@endDate
)
SELECT 
   @listOFDays= STRING_AGG('['+CONVERT(VARCHAR(MAX),CONVERT(DATE,TransactionDate))+']', ',')-- AS csv 
 FROM allDates

------Create List for filter

;WITH allDates
AS
(
SELECT DISTINCT
  TransactionDate
FROM Production.TransactionHistoryArchive
WHERE TransactionDate>=@startDate AND TransactionDate<@endDate
)
SELECT 
   @filter= STRING_AGG('['+CONVERT(VARCHAR(MAX),CONVERT(DATE,TransactionDate))+'] IS NULL', ' AND ')-- AS csv 
 FROM allDates

 ------For Get Dinamic columns use Select in EXECUTE 'SELECT... '

EXECUTE('
;WITH allRows
AS
(
SELECT 
	 ReferenceOrderID,'+@listOFDays+'
FROM
(
SELECT 
     ReferenceOrderID      
    ,CONVERT(DATE,TransactionDate) AS TransactionDate     
    ,Quantity*ActualCost AS payments      
FROM Production.TransactionHistoryArchive
) p  
PIVOT  
(  
SUM (payments)  
FOR TransactionDate IN  ('+@listOFDays+')  
) AS pvt 
)
SELECT *
FROM allRows
WHERE NOT('+@filter+')
')