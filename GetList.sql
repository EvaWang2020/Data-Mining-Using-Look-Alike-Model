USE SQLBook;
GO

WITH Seed AS(
        SELECT    z.* ,
		          o.OrderDate,
		          o.TotalPrice
        FROM    ZipCensus Z INNER JOIN  Orders o 
	    ON z.zcta5=o.ZipCode
)
SELECT *
FROM Seed


