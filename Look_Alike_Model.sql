USE SQLBook;
GO


WITH Seed AS(
        SELECT
			o.ZipCode,
			z.pctInCollege,
			z.pctChild,
			z.MedianAge,
			z.pctMales,
			z.pctWorkAtHome,
			z.pctAsian1,
			z.pctEmployedFemales,
			z.MedianEarnings,
			o.OrderDate,
			o.TotalPrice
        FROM Orders o INNER JOIN ZipCensus z
		ON z.zcta5=o.ZipCode
),
aggregation AS(
       SELECT   	 
		    ZipCode,
			AVG (TotalPrice) as AvgSpending,
			NTILE (10) OVER (ORDER BY AVG (TotalPrice) ) as Decile,
			ROW_NUMBER() OVER (ORDER BY AVG (TotalPrice)) as RowNumber		
       FROM Seed
	   GROUP BY ZipCode	   
),
Ntile AS(
       SELECT 
	        a.Decile,
	        ROUND(AVG(s.pctInCollege),2) as CollegePcnt,
	        AVG(s.pctChild) as pctChild,
			AVG(s.MedianAge) as MedianAge,
			AVG(s.pctMales) as pctMales,
			AVG(s.pctWorkAtHome) as WorkatHomePcnt,
			AVG(s.pctAsian1) as pctAsian1,
			AVG(s.pctEmployedFemales) as EmployedFemalesPcnt,
			AVG(s.MedianEarnings) as MedianEarnings
       FROM Seed s INNER JOIN aggregation a
	   ON s.ZipCode=a.ZipCode
	   GROUP BY a.Decile
),
aggragationRelated AS(
       SELECT
			o.ZipCode,			
			AVG(z.pctAsian1) as AsianPcnt,			
			AVG(z.MedianEarnings) as MedianEarnings,	
			AVG(z.pctInCollege) as CollegePcnt			
        FROM Orders o INNER JOIN ZipCensus z
		ON z.zcta5=o.ZipCode
		GROUP BY o.ZipCode
),
ozm AS (
      SELECT  
		    AVG(AsianPcnt) as AvgAsianPcnt,
		    STDEV(AsianPcnt) as StdAsianPcnt,
		    AVG(MedianEarnings) as AvgMedianEarnings,
	        STDEV(MedianEarnings) as StdMedianEarnings,
		    AVG(CollegePcnt) as AvgCollegePcnt,
	        STDEV(CollegePcnt) as StdCollegePcnt
      FROM  AggragationRelated
),
ozs AS(
      SELECT  a.ZipCode,
	        (a.AsianPcnt-ozm.AvgAsianPcnt)/ozm.StdAsianPcnt as  Zscore_AsianPcnt,
			(a.MedianEarnings-ozm.AvgMedianEarnings)/ozm.StdMedianEarnings as  Zscore_MedianEarnings,
			(a.CollegePcnt	-ozm.AvgCollegePcnt	)/ozm.StdCollegePcnt  as  Zscore_CollegePcnt	
	  FROM AggragationRelated a CROSS JOIN ozm
),
distance AS (
       SELECT ozs.ZipCode AS PostalCode,
	          p.ZipCode AS TopPostalCode,
             SQRT(SQUARE (ozs.Zscore_AsianPcnt- p.Zscore_AsianPcnt)+SQUARE (ozs.Zscore_MedianEarnings- p.Zscore_MedianEarnings)+SQUARE (ozs.Zscore_CollegePcnt- p.Zscore_CollegePcnt)) as Distance
       FROM ozs  CROSS JOIN (
	       SELECT ozs. * FROM ozs
		   WHERE ozs.ZipCode=(SELECT ZipCode FROM aggregation WHERE RowNumber=1)) p  
)
SELECT  d.Distance,d.PostalCode,d.TopPostalCode,FORMAT(a.AsianPcnt,'P2') as Asican_Percentage,a.MedianEarnings,	FORMAT(a.CollegePcnt,'P2') as CollegePercentage	
FROM distance d
INNER JOIN AggragationRelated a
ON d.PostalCode=a.ZipCode
WHERE d.Distance IS NOT NULL
ORDER BY d.Distance ASC;
GO
