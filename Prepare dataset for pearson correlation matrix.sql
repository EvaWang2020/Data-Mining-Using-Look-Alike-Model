USE SQLBook;
GO

WITH Seed AS(
        SELECT   ZipCode,
	 	         AVG(TotalPrice)  AS AVG_Totalprice 
        FROM Orders 
		GROUP BY  ZipCode
)

SELECT 
	     o.*,
		 s.AVG_Totalprice 
FROM Seed s INNER JOIN ZipCensus o
ON o.zcta5=s.ZipCode