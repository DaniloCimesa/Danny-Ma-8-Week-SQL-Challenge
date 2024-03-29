

--1. What is the total sales for the 4 weeks before and after 2020-06-15? 
--What is the growth or reduction rate in actual values and percentage of sales?

DECLARE @WEEKDATE DATE
SET @WEEKDATE = (
SELECT
  DISTINCT WEEK_DATE
 FROM clean_weekly_sales
 WHERE WEEK_DATE='2020-06-15')
 
 SELECT
    SUM(CASE WHEN WEEK_DATE >=DATEADD(DAY, -28,@WEEKDATE) AND WEEK_DATE < @WEEKDATE THEN CONVERT (BIGINT, SALES) END) AS B4PRCCNT
,   SUM(CASE WHEN WEEK_DATE < DATEADD(DAY, +28,@WEEKDATE) AND WEEK_DATE >= @WEEKDATE THEN CONVERT (BIGINT, SALES) END) AS AFTRPRCCNT
,   SUM(CASE WHEN WEEK_DATE < DATEADD(DAY, +28,@WEEKDATE) AND WEEK_DATE >= @WEEKDATE THEN CONVERT (BIGINT, SALES) END) 
  -SUM(CASE WHEN WEEK_DATE >=DATEADD(DAY, -28,@WEEKDATE) AND WEEK_DATE < @WEEKDATE THEN CONVERT (BIGINT, SALES) END) AS VARR
,   FORMAT( (SUM(CASE WHEN WEEK_DATE < DATEADD(DAY, +28,@WEEKDATE) AND WEEK_DATE >= @WEEKDATE THEN CONVERT (BIGINT, SALES) END)*1.00
          - SUM(CASE WHEN WEEK_DATE >=DATEADD(DAY, -28,@WEEKDATE) AND WEEK_DATE < @WEEKDATE THEN CONVERT (BIGINT, SALES) END))/
          SUM(CASE WHEN WEEK_DATE >=DATEADD(DAY, -28,@WEEKDATE) AND WEEK_DATE < @WEEKDATE THEN CONVERT (BIGINT, SALES) END), 'P2') AS PERCENTAGE
FROM clean_weekly_sales

--2. What about the entire 12 weeks before and after?

DECLARE @WEEKDATE DATE
SET @WEEKDATE = (
SELECT
  DISTINCT WEEK_DATE
 FROM clean_weekly_sales
 WHERE WEEK_DATE='2020-06-15')
 
 SELECT
    SUM(CASE WHEN WEEK_DATE >=DATEADD(DAY, -84,@WEEKDATE) AND WEEK_DATE < @WEEKDATE THEN CONVERT (BIGINT, SALES) END) AS B4PRCCNT
,   SUM(CASE WHEN WEEK_DATE < DATEADD(DAY, +84,@WEEKDATE) AND WEEK_DATE >= @WEEKDATE THEN CONVERT (BIGINT, SALES) END) AS AFTRPRCCNT
,   SUM(CASE WHEN WEEK_DATE < DATEADD(DAY, +84,@WEEKDATE) AND WEEK_DATE >= @WEEKDATE THEN CONVERT (BIGINT, SALES) END) 
  -SUM(CASE WHEN WEEK_DATE >=DATEADD(DAY, -84,@WEEKDATE) AND WEEK_DATE < @WEEKDATE THEN CONVERT (BIGINT, SALES) END) AS VARR
,   FORMAT( (SUM(CASE WHEN WEEK_DATE < DATEADD(DAY, +84,@WEEKDATE) AND WEEK_DATE >= @WEEKDATE THEN CONVERT (BIGINT, SALES) END)*1.00
          - SUM(CASE WHEN WEEK_DATE >=DATEADD(DAY, -84,@WEEKDATE) AND WEEK_DATE < @WEEKDATE THEN CONVERT (BIGINT, SALES) END))/
          SUM(CASE WHEN WEEK_DATE >=DATEADD(DAY, -84,@WEEKDATE) AND WEEK_DATE < @WEEKDATE THEN CONVERT (BIGINT, SALES) END), 'P2') AS PERCENTAGE
FROM clean_weekly_sales


--3. How do the sale metrics for these 2 periods before and after compare with the previous years in 2018 and 2019?

--A

DECLARE @WEEKNUM INT
SET @WEEKNUM = (
SELECT
  DISTINCT Week_Number
 FROM clean_weekly_sales
 WHERE WEEK_DATE='2020-06-15')
 
  SELECT
    SUM(CASE WHEN Week_Number >=DATEADD(DAY, -4,@Week_Number) AND Week_Number < @Week_Number THEN CONVERT (BIGINT, SALES) END) AS B4Sales
,   SUM(CASE WHEN Week_Number < DATEADD(DAY, +4,@Week_Number) AND Week_Number >= @Week_Number THEN CONVERT (BIGINT, SALES) END) AS AFTRSales
,   SUM(CASE WHEN Week_Number < DATEADD(DAY, +4,@Week_Number) AND Week_Number >= @Week_Number THEN CONVERT (BIGINT, SALES) END) 
  -SUM(CASE WHEN Week_Number >=DATEADD(DAY, -4,@Week_Number) AND Week_Number < @Week_Number THEN CONVERT (BIGINT, SALES) END) AS Variance
,   FORMAT( (SUM(CASE WHEN Week_Number < DATEADD(DAY, +4,@Week_Number) AND Week_Number >= @Week_Number THEN CONVERT (BIGINT, SALES) END)*1.00
          - SUM(CASE WHEN Week_Number >=DATEADD(DAY, -4,@Week_Number) AND Week_Number < @Week_Number THEN CONVERT (BIGINT, SALES) END))/
          SUM(CASE WHEN Week_Number >=DATEADD(DAY, -4,@Week_Number) AND Week_Number < @Week_Number THEN CONVERT (BIGINT, SALES) END), 'P2') AS PERCENTAGE
FROM clean_weekly_sales
GROUP BY calendar_year
ORDER BY calendar_year

--B

DECLARE @WEEKNUM INT
SET @WEEKNUM = (
SELECT
  DISTINCT Week_Number
 FROM clean_weekly_sales
 WHERE WEEK_DATE='2020-06-15')
 
  SELECT
    SUM(CASE WHEN Week_Number >=DATEADD(DAY, -12,@Week_Number) AND Week_Number < @Week_Number THEN CONVERT (BIGINT, SALES) END) AS B4Sales
,   SUM(CASE WHEN Week_Number < DATEADD(DAY, +12,@Week_Number) AND Week_Number >= @Week_Number THEN CONVERT (BIGINT, SALES) END) AS AFTRSales
,   SUM(CASE WHEN Week_Number < DATEADD(DAY, +12,@Week_Number) AND Week_Number >= @Week_Number THEN CONVERT (BIGINT, SALES) END) 
  -SUM(CASE WHEN Week_Number >=DATEADD(DAY, -12,@Week_Number) AND Week_Number < @Week_Number THEN CONVERT (BIGINT, SALES) END) AS Variance
,   FORMAT( (SUM(CASE WHEN Week_Number < DATEADD(DAY, +12,@Week_Number) AND Week_Number >= @Week_Number THEN CONVERT (BIGINT, SALES) END)*1.00
          - SUM(CASE WHEN Week_Number >=DATEADD(DAY, -12,@Week_Number) AND Week_Number < @Week_Number THEN CONVERT (BIGINT, SALES) END))/
          SUM(CASE WHEN Week_Number >=DATEADD(DAY, -12,@Week_Number) AND Week_Number < @Week_Number THEN CONVERT (BIGINT, SALES) END), 'P2') AS PERCENTAGE
FROM clean_weekly_sales
GROUP BY calendar_year
ORDER BY calendar_year
