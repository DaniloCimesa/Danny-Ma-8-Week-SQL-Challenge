
Creating a running balance that is affected after each customer transaction.

One way to do it is using a SUM() with an OVER clause.
```
WITH CTE_A AS (
SELECT 
	*
,	CASE WHEN txn_type='deposit' THEN txn_amount
				     ELSE -txn_amount END AS amountEdited

FROM customer_transactions
)

SELECT 
	customer_id
,	txn_date
,	txn_type
,	amountEdited
,	SUM(amountEdited) OVER (PARTITION BY customer_id ORDER BY txn_date) running_balance
FROM CTE_A
```
Other way would be the longer one and ofcourse, with using the ROW_NUMBER function to sort all the transactions for each customer by ascending date and after that sum each number with the previous one to create a running balance. 
```
WITH CTE_A AS (
SELECT 
	*
,	CASE WHEN txn_type='deposit' THEN txn_amount
				     ELSE -txn_amount END AS amountEdited

FROM customer_transactions
)
, CTE_B AS (
SELECT 
	*
,	ROW_NUMBER() OVER (PARTITION BY customer_id ORDER BY txn_date) AS Num
FROM CTE_A
)
, CTE_C AS 
(SELECT 
	
	customer_id
,	txn_date
,	txn_type
,	txn_amount
,	CASE WHEN Num=1 THEN amountEdited	
		 WHEN Num=2 THEN amountEdited+LAG(amountEdited) OVER (PARTITION BY customer_id ORDER BY txn_date) 
		 WHEN Num=3 THEN amountEdited+LAG(amountEdited,2,0) OVER (PARTITION BY customer_id ORDER BY txn_date)+LAG(amountEdited,1,0) OVER (PARTITION BY customer_id ORDER BY txn_date)
		 WHEN Num=4 THEN amountEdited+LAG(amountEdited,3,0) OVER (PARTITION BY customer_id ORDER BY txn_date)+LAG(amountEdited,2,0) OVER (PARTITION BY customer_id ORDER BY txn_date)+LAG(amountEdited,1,0) OVER (PARTITION BY customer_id ORDER BY txn_date)
		 WHEN Num=5 THEN amountEdited+LAG(amountEdited,4,0) OVER (PARTITION BY customer_id ORDER BY txn_date)+LAG(amountEdited,3,0) OVER (PARTITION BY customer_id ORDER BY txn_date)+LAG(amountEdited,2,0) OVER (PARTITION BY customer_id ORDER BY txn_date)+LAG(amountEdited,1,0) OVER (PARTITION BY customer_id ORDER BY txn_date)
		 WHEN Num=6 THEN amountEdited+LAG(amountEdited,5,0) OVER (PARTITION BY customer_id ORDER BY txn_date)+LAG(amountEdited,4,0) OVER (PARTITION BY customer_id ORDER BY txn_date)+LAG(amountEdited,3,0) OVER (PARTITION BY customer_id ORDER BY txn_date)+LAG(amountEdited,2,0) OVER (PARTITION BY customer_id ORDER BY txn_date)+LAG(amountEdited,1,0) OVER (PARTITION BY customer_id ORDER BY txn_date)
		 WHEN Num=7 THEN amountEdited+LAG(amountEdited,6,0) OVER (PARTITION BY customer_id ORDER BY txn_date)+LAG(amountEdited,5,0) OVER (PARTITION BY customer_id ORDER BY txn_date)+LAG(amountEdited,4,0) OVER (PARTITION BY customer_id ORDER BY txn_date)+LAG(amountEdited,3,0) OVER (PARTITION BY customer_id ORDER BY txn_date)+LAG(amountEdited,2,0) OVER (PARTITION BY customer_id ORDER BY txn_date)+LAG(amountEdited,1,0) OVER (PARTITION BY customer_id ORDER BY txn_date)
		 WHEN Num=8 THEN amountEdited+LAG(amountEdited,7,0) OVER (PARTITION BY customer_id ORDER BY txn_date)+LAG(amountEdited,6,0) OVER (PARTITION BY customer_id ORDER BY txn_date)+LAG(amountEdited,5,0) OVER (PARTITION BY customer_id ORDER BY txn_date)+LAG(amountEdited,4,0) OVER (PARTITION BY customer_id ORDER BY txn_date)+LAG(amountEdited,3,0) OVER (PARTITION BY customer_id ORDER BY txn_date)+LAG(amountEdited,2,0) OVER (PARTITION BY customer_id ORDER BY txn_date)+LAG(amountEdited,1,0) OVER (PARTITION BY customer_id ORDER BY txn_date)
		 WHEN Num=9 THEN amountEdited+LAG(amountEdited,8,0) OVER (PARTITION BY customer_id ORDER BY txn_date)+LAG(amountEdited,7,0) OVER (PARTITION BY customer_id ORDER BY txn_date)+LAG(amountEdited,6,0) OVER (PARTITION BY customer_id ORDER BY txn_date)+LAG(amountEdited,5,0) OVER (PARTITION BY customer_id ORDER BY txn_date)+LAG(amountEdited,4,0) OVER (PARTITION BY customer_id ORDER BY txn_date)+LAG(amountEdited,3,0) OVER (PARTITION BY customer_id ORDER BY txn_date)+LAG(amountEdited,2,0) OVER (PARTITION BY customer_id ORDER BY txn_date)+LAG(amountEdited,1,0) OVER (PARTITION BY customer_id ORDER BY txn_date)
		 WHEN Num=10 THEN amountEdited+LAG(amountEdited,9,0) OVER (PARTITION BY customer_id ORDER BY txn_date)+LAG(amountEdited,8,0) OVER (PARTITION BY customer_id ORDER BY txn_date)+LAG(amountEdited,7,0) OVER (PARTITION BY customer_id ORDER BY txn_date)+LAG(amountEdited,6,0) OVER (PARTITION BY customer_id ORDER BY txn_date)+LAG(amountEdited,5,0) OVER (PARTITION BY customer_id ORDER BY txn_date)+LAG(amountEdited,4,0) OVER (PARTITION BY customer_id ORDER BY txn_date)+LAG(amountEdited,3,0) OVER (PARTITION BY customer_id ORDER BY txn_date)+LAG(amountEdited,2,0) OVER (PARTITION BY customer_id ORDER BY txn_date)+LAG(amountEdited,1,0) OVER (PARTITION BY customer_id ORDER BY txn_date)
		 WHEN Num=11 THEN amountEdited+LAG(amountEdited,10,0) OVER (PARTITION BY customer_id ORDER BY txn_date)+LAG(amountEdited,9,0) OVER (PARTITION BY customer_id ORDER BY txn_date)+LAG(amountEdited,8,0) OVER (PARTITION BY customer_id ORDER BY txn_date)+LAG(amountEdited,7,0) OVER (PARTITION BY customer_id ORDER BY txn_date)+LAG(amountEdited,6,0) OVER (PARTITION BY customer_id ORDER BY txn_date)+LAG(amountEdited,5,0) OVER (PARTITION BY customer_id ORDER BY txn_date)+LAG(amountEdited,4,0) OVER (PARTITION BY customer_id ORDER BY txn_date)+LAG(amountEdited,3,0) OVER (PARTITION BY customer_id ORDER BY txn_date)+LAG(amountEdited,2,0) OVER (PARTITION BY customer_id ORDER BY txn_date)+LAG(amountEdited,1,0) OVER (PARTITION BY customer_id ORDER BY txn_date)
		 WHEN Num=12 THEN amountEdited+LAG(amountEdited,11,0) OVER (PARTITION BY customer_id ORDER BY txn_date)+LAG(amountEdited,10,0) OVER (PARTITION BY customer_id ORDER BY txn_date)+LAG(amountEdited,9,0) OVER (PARTITION BY customer_id ORDER BY txn_date)+LAG(amountEdited,8,0) OVER (PARTITION BY customer_id ORDER BY txn_date)+LAG(amountEdited,7,0) OVER (PARTITION BY customer_id ORDER BY txn_date)+LAG(amountEdited,6,0) OVER (PARTITION BY customer_id ORDER BY txn_date)+LAG(amountEdited,5,0) OVER (PARTITION BY customer_id ORDER BY txn_date)+LAG(amountEdited,4,0) OVER (PARTITION BY customer_id ORDER BY txn_date)+LAG(amountEdited,3,0) OVER (PARTITION BY customer_id ORDER BY txn_date)+LAG(amountEdited,2,0) OVER (PARTITION BY customer_id ORDER BY txn_date)+LAG(amountEdited,1,0) OVER (PARTITION BY customer_id ORDER BY txn_date)
		 WHEN Num=13 THEN amountEdited+LAG(amountEdited,12,0) OVER (PARTITION BY customer_id ORDER BY txn_date)+LAG(amountEdited,11,0) OVER (PARTITION BY customer_id ORDER BY txn_date)+LAG(amountEdited,10,0) OVER (PARTITION BY customer_id ORDER BY txn_date)+LAG(amountEdited,9,0) OVER (PARTITION BY customer_id ORDER BY txn_date)+LAG(amountEdited,8,0) OVER (PARTITION BY customer_id ORDER BY txn_date)+LAG(amountEdited,7,0) OVER (PARTITION BY customer_id ORDER BY txn_date)+LAG(amountEdited,6,0) OVER (PARTITION BY customer_id ORDER BY txn_date)+LAG(amountEdited,5,0) OVER (PARTITION BY customer_id ORDER BY txn_date)+LAG(amountEdited,4,0) OVER (PARTITION BY customer_id ORDER BY txn_date)+LAG(amountEdited,3,0) OVER (PARTITION BY customer_id ORDER BY txn_date)+LAG(amountEdited,2,0) OVER (PARTITION BY customer_id ORDER BY txn_date)+LAG(amountEdited,1,0) OVER (PARTITION BY customer_id ORDER BY txn_date)
		 WHEN Num=14 THEN amountEdited+LAG(amountEdited,13,0) OVER (PARTITION BY customer_id ORDER BY txn_date)+LAG(amountEdited,12,0) OVER (PARTITION BY customer_id ORDER BY txn_date)+LAG(amountEdited,11,0) OVER (PARTITION BY customer_id ORDER BY txn_date)+LAG(amountEdited,10,0) OVER (PARTITION BY customer_id ORDER BY txn_date)+LAG(amountEdited,9,0) OVER (PARTITION BY customer_id ORDER BY txn_date)+LAG(amountEdited,8,0) OVER (PARTITION BY customer_id ORDER BY txn_date)+LAG(amountEdited,7,0) OVER (PARTITION BY customer_id ORDER BY txn_date)+LAG(amountEdited,6,0) OVER (PARTITION BY customer_id ORDER BY txn_date)+LAG(amountEdited,5,0) OVER (PARTITION BY customer_id ORDER BY txn_date)+LAG(amountEdited,4,0) OVER (PARTITION BY customer_id ORDER BY txn_date)+LAG(amountEdited,3,0) OVER (PARTITION BY customer_id ORDER BY txn_date)+LAG(amountEdited,2,0) OVER (PARTITION BY customer_id ORDER BY txn_date)+LAG(amountEdited,1,0) OVER (PARTITION BY customer_id ORDER BY txn_date)
		 WHEN Num=15 THEN amountEdited+LAG(amountEdited,14,0) OVER (PARTITION BY customer_id ORDER BY txn_date)+LAG(amountEdited,13,0) OVER (PARTITION BY customer_id ORDER BY txn_date)+LAG(amountEdited,12,0) OVER (PARTITION BY customer_id ORDER BY txn_date)+LAG(amountEdited,11,0) OVER (PARTITION BY customer_id ORDER BY txn_date)+LAG(amountEdited,10,0) OVER (PARTITION BY customer_id ORDER BY txn_date)+LAG(amountEdited,9,0) OVER (PARTITION BY customer_id ORDER BY txn_date)+LAG(amountEdited,8,0) OVER (PARTITION BY customer_id ORDER BY txn_date)+LAG(amountEdited,7,0) OVER (PARTITION BY customer_id ORDER BY txn_date)+LAG(amountEdited,6,0) OVER (PARTITION BY customer_id ORDER BY txn_date)+LAG(amountEdited,5,0) OVER (PARTITION BY customer_id ORDER BY txn_date)+LAG(amountEdited,4,0) OVER (PARTITION BY customer_id ORDER BY txn_date)+LAG(amountEdited,3,0) OVER (PARTITION BY customer_id ORDER BY txn_date)+LAG(amountEdited,2,0) OVER (PARTITION BY customer_id ORDER BY txn_date)+LAG(amountEdited,1,0) OVER (PARTITION BY customer_id ORDER BY txn_date)
		 WHEN Num=16 THEN amountEdited+LAG(amountEdited,15,0) OVER (PARTITION BY customer_id ORDER BY txn_date)+LAG(amountEdited,14,0) OVER (PARTITION BY customer_id ORDER BY txn_date)+LAG(amountEdited,13,0) OVER (PARTITION BY customer_id ORDER BY txn_date)+LAG(amountEdited,12,0) OVER (PARTITION BY customer_id ORDER BY txn_date)+LAG(amountEdited,11,0) OVER (PARTITION BY customer_id ORDER BY txn_date)+LAG(amountEdited,10,0) OVER (PARTITION BY customer_id ORDER BY txn_date)+LAG(amountEdited,9,0) OVER (PARTITION BY customer_id ORDER BY txn_date)+LAG(amountEdited,8,0) OVER (PARTITION BY customer_id ORDER BY txn_date)+LAG(amountEdited,7,0) OVER (PARTITION BY customer_id ORDER BY txn_date)+LAG(amountEdited,6,0) OVER (PARTITION BY customer_id ORDER BY txn_date)+LAG(amountEdited,5,0) OVER (PARTITION BY customer_id ORDER BY txn_date)+LAG(amountEdited,4,0) OVER (PARTITION BY customer_id ORDER BY txn_date)+LAG(amountEdited,3,0) OVER (PARTITION BY customer_id ORDER BY txn_date)+LAG(amountEdited,2,0) OVER (PARTITION BY customer_id ORDER BY txn_date)+LAG(amountEdited,1,0) OVER (PARTITION BY customer_id ORDER BY txn_date)
		 WHEN Num=17 THEN amountEdited+LAG(amountEdited,16,0) OVER (PARTITION BY customer_id ORDER BY txn_date)+LAG(amountEdited,15,0) OVER (PARTITION BY customer_id ORDER BY txn_date)+LAG(amountEdited,14,0) OVER (PARTITION BY customer_id ORDER BY txn_date)+LAG(amountEdited,13,0) OVER (PARTITION BY customer_id ORDER BY txn_date)+LAG(amountEdited,12,0) OVER (PARTITION BY customer_id ORDER BY txn_date)+LAG(amountEdited,11,0) OVER (PARTITION BY customer_id ORDER BY txn_date)+LAG(amountEdited,10,0) OVER (PARTITION BY customer_id ORDER BY txn_date)+LAG(amountEdited,9,0) OVER (PARTITION BY customer_id ORDER BY txn_date)+LAG(amountEdited,8,0) OVER (PARTITION BY customer_id ORDER BY txn_date)+LAG(amountEdited,7,0) OVER (PARTITION BY customer_id ORDER BY txn_date)+LAG(amountEdited,6,0) OVER (PARTITION BY customer_id ORDER BY txn_date)+LAG(amountEdited,5,0) OVER (PARTITION BY customer_id ORDER BY txn_date)+LAG(amountEdited,4,0) OVER (PARTITION BY customer_id ORDER BY txn_date)+LAG(amountEdited,3,0) OVER (PARTITION BY customer_id ORDER BY txn_date)+LAG(amountEdited,2,0) OVER (PARTITION BY customer_id ORDER BY txn_date)+LAG(amountEdited,1,0) OVER (PARTITION BY customer_id ORDER BY txn_date)
		 WHEN Num=18 THEN amountEdited+LAG(amountEdited,17,0) OVER (PARTITION BY customer_id ORDER BY txn_date)+LAG(amountEdited,16,0) OVER (PARTITION BY customer_id ORDER BY txn_date)+LAG(amountEdited,15,0) OVER (PARTITION BY customer_id ORDER BY txn_date)+LAG(amountEdited,14,0) OVER (PARTITION BY customer_id ORDER BY txn_date)+LAG(amountEdited,13,0) OVER (PARTITION BY customer_id ORDER BY txn_date)+LAG(amountEdited,12,0) OVER (PARTITION BY customer_id ORDER BY txn_date)+LAG(amountEdited,11,0) OVER (PARTITION BY customer_id ORDER BY txn_date)+LAG(amountEdited,10,0) OVER (PARTITION BY customer_id ORDER BY txn_date)+LAG(amountEdited,9,0) OVER (PARTITION BY customer_id ORDER BY txn_date)+LAG(amountEdited,8,0) OVER (PARTITION BY customer_id ORDER BY txn_date)+LAG(amountEdited,7,0) OVER (PARTITION BY customer_id ORDER BY txn_date)+LAG(amountEdited,6,0) OVER (PARTITION BY customer_id ORDER BY txn_date)+LAG(amountEdited,5,0) OVER (PARTITION BY customer_id ORDER BY txn_date)+LAG(amountEdited,4,0) OVER (PARTITION BY customer_id ORDER BY txn_date)+LAG(amountEdited,3,0) OVER (PARTITION BY customer_id ORDER BY txn_date)+LAG(amountEdited,2,0) OVER (PARTITION BY customer_id ORDER BY txn_date)+LAG(amountEdited,1,0) OVER (PARTITION BY customer_id ORDER BY txn_date)
		 WHEN Num=19 THEN amountEdited+LAG(amountEdited,18,0) OVER (PARTITION BY customer_id ORDER BY txn_date)+LAG(amountEdited,17,0) OVER (PARTITION BY customer_id ORDER BY txn_date)+LAG(amountEdited,16,0) OVER (PARTITION BY customer_id ORDER BY txn_date)+LAG(amountEdited,15,0) OVER (PARTITION BY customer_id ORDER BY txn_date)+LAG(amountEdited,14,0) OVER (PARTITION BY customer_id ORDER BY txn_date)+LAG(amountEdited,13,0) OVER (PARTITION BY customer_id ORDER BY txn_date)+LAG(amountEdited,12,0) OVER (PARTITION BY customer_id ORDER BY txn_date)+LAG(amountEdited,11,0) OVER (PARTITION BY customer_id ORDER BY txn_date)+LAG(amountEdited,10,0) OVER (PARTITION BY customer_id ORDER BY txn_date)+LAG(amountEdited,9,0) OVER (PARTITION BY customer_id ORDER BY txn_date)+LAG(amountEdited,8,0) OVER (PARTITION BY customer_id ORDER BY txn_date)+LAG(amountEdited,7,0) OVER (PARTITION BY customer_id ORDER BY txn_date)+LAG(amountEdited,6,0) OVER (PARTITION BY customer_id ORDER BY txn_date)+LAG(amountEdited,5,0) OVER (PARTITION BY customer_id ORDER BY txn_date)+LAG(amountEdited,4,0) OVER (PARTITION BY customer_id ORDER BY txn_date)+LAG(amountEdited,3,0) OVER (PARTITION BY customer_id ORDER BY txn_date)+LAG(amountEdited,2,0) OVER (PARTITION BY customer_id ORDER BY txn_date)+LAG(amountEdited,1,0) OVER (PARTITION BY customer_id ORDER BY txn_date)
		 WHEN Num=20 THEN amountEdited+LAG(amountEdited,19,0) OVER (PARTITION BY customer_id ORDER BY txn_date)+LAG(amountEdited,18,0) OVER (PARTITION BY customer_id ORDER BY txn_date)+LAG(amountEdited,17,0) OVER (PARTITION BY customer_id ORDER BY txn_date)+LAG(amountEdited,16,0) OVER (PARTITION BY customer_id ORDER BY txn_date)+LAG(amountEdited,15,0) OVER (PARTITION BY customer_id ORDER BY txn_date)+LAG(amountEdited,14,0) OVER (PARTITION BY customer_id ORDER BY txn_date)+LAG(amountEdited,13,0) OVER (PARTITION BY customer_id ORDER BY txn_date)+LAG(amountEdited,12,0) OVER (PARTITION BY customer_id ORDER BY txn_date)+LAG(amountEdited,11,0) OVER (PARTITION BY customer_id ORDER BY txn_date)+LAG(amountEdited,10,0) OVER (PARTITION BY customer_id ORDER BY txn_date)+LAG(amountEdited,9,0) OVER (PARTITION BY customer_id ORDER BY txn_date)+LAG(amountEdited,8,0) OVER (PARTITION BY customer_id ORDER BY txn_date)+LAG(amountEdited,7,0) OVER (PARTITION BY customer_id ORDER BY txn_date)+LAG(amountEdited,6,0) OVER (PARTITION BY customer_id ORDER BY txn_date)+LAG(amountEdited,5,0) OVER (PARTITION BY customer_id ORDER BY txn_date)+LAG(amountEdited,4,0) OVER (PARTITION BY customer_id ORDER BY txn_date)+LAG(amountEdited,3,0) OVER (PARTITION BY customer_id ORDER BY txn_date)+LAG(amountEdited,2,0) OVER (PARTITION BY customer_id ORDER BY txn_date)+LAG(amountEdited,1,0) OVER (PARTITION BY customer_id ORDER BY txn_date)
		 WHEN Num=21 THEN amountEdited+LAG(amountEdited,20,0) OVER (PARTITION BY customer_id ORDER BY txn_date)+LAG(amountEdited,19,0) OVER (PARTITION BY customer_id ORDER BY txn_date)+LAG(amountEdited,18,0) OVER (PARTITION BY customer_id ORDER BY txn_date)+LAG(amountEdited,17,0) OVER (PARTITION BY customer_id ORDER BY txn_date)+LAG(amountEdited,16,0) OVER (PARTITION BY customer_id ORDER BY txn_date)+LAG(amountEdited,15,0) OVER (PARTITION BY customer_id ORDER BY txn_date)+LAG(amountEdited,14,0) OVER (PARTITION BY customer_id ORDER BY txn_date)+LAG(amountEdited,13,0) OVER (PARTITION BY customer_id ORDER BY txn_date)+LAG(amountEdited,12,0) OVER (PARTITION BY customer_id ORDER BY txn_date)+LAG(amountEdited,11,0) OVER (PARTITION BY customer_id ORDER BY txn_date)+LAG(amountEdited,10,0) OVER (PARTITION BY customer_id ORDER BY txn_date)+LAG(amountEdited,9,0) OVER (PARTITION BY customer_id ORDER BY txn_date)+LAG(amountEdited,8,0) OVER (PARTITION BY customer_id ORDER BY txn_date)+LAG(amountEdited,7,0) OVER (PARTITION BY customer_id ORDER BY txn_date)+LAG(amountEdited,6,0) OVER (PARTITION BY customer_id ORDER BY txn_date)+LAG(amountEdited,5,0) OVER (PARTITION BY customer_id ORDER BY txn_date)+LAG(amountEdited,4,0) OVER (PARTITION BY customer_id ORDER BY txn_date)+LAG(amountEdited,3,0) OVER (PARTITION BY customer_id ORDER BY txn_date)+LAG(amountEdited,2,0) OVER (PARTITION BY customer_id ORDER BY txn_date)+LAG(amountEdited,1,0) OVER (PARTITION BY customer_id ORDER BY txn_date)
		 WHEN Num=22 THEN amountEdited+LAG(amountEdited,21,0) OVER (PARTITION BY customer_id ORDER BY txn_date)+LAG(amountEdited,20,0) OVER (PARTITION BY customer_id ORDER BY txn_date)+LAG(amountEdited,19,0) OVER (PARTITION BY customer_id ORDER BY txn_date)+LAG(amountEdited,18,0) OVER (PARTITION BY customer_id ORDER BY txn_date)+LAG(amountEdited,17,0) OVER (PARTITION BY customer_id ORDER BY txn_date)+LAG(amountEdited,16,0) OVER (PARTITION BY customer_id ORDER BY txn_date)+LAG(amountEdited,15,0) OVER (PARTITION BY customer_id ORDER BY txn_date)+LAG(amountEdited,14,0) OVER (PARTITION BY customer_id ORDER BY txn_date)+LAG(amountEdited,13,0) OVER (PARTITION BY customer_id ORDER BY txn_date)+LAG(amountEdited,12,0) OVER (PARTITION BY customer_id ORDER BY txn_date)+LAG(amountEdited,11,0) OVER (PARTITION BY customer_id ORDER BY txn_date)+LAG(amountEdited,10,0) OVER (PARTITION BY customer_id ORDER BY txn_date)+LAG(amountEdited,9,0) OVER (PARTITION BY customer_id ORDER BY txn_date)+LAG(amountEdited,8,0) OVER (PARTITION BY customer_id ORDER BY txn_date)+LAG(amountEdited,7,0) OVER (PARTITION BY customer_id ORDER BY txn_date)+LAG(amountEdited,6,0) OVER (PARTITION BY customer_id ORDER BY txn_date)+LAG(amountEdited,5,0) OVER (PARTITION BY customer_id ORDER BY txn_date)+LAG(amountEdited,4,0) OVER (PARTITION BY customer_id ORDER BY txn_date)+LAG(amountEdited,3,0) OVER (PARTITION BY customer_id ORDER BY txn_date)+LAG(amountEdited,2,0) OVER (PARTITION BY customer_id ORDER BY txn_date)+LAG(amountEdited,1,0) OVER (PARTITION BY customer_id ORDER BY txn_date)

		 ELSE 0 END AS running_balance
FROM CTE_B)

SELECT 
*
FROM CTE_C
```


Minimum, average and maximum values of the running balance for each customer. The foundation for this query is pretty much the same as for the previous one, but with extra aggregate functions in the final select. 

```
WITH CTE_A AS (
SELECT 
	*
,	CASE WHEN txn_type='deposit' THEN txn_amount
				     ELSE -txn_amount END AS amountEdited

FROM customer_transactions
)
,	CTE_B AS (
SELECT 
	customer_id
,	txn_date
,	txn_type
,	amountEdited
,	SUM(amountEdited) OVER (PARTITION BY customer_id ORDER BY txn_date) running_balance
FROM CTE_A)

SELECT
	customer_id
,	MIN(running_balance) AS MIN
,	MAX(running_balance) AS MAX
,	AVG(running_balance) AS AVG
FROM CTE_B
GROUP BY customer_id
```

Customer balance at the end of each month. Code for this is used from 4th assignment from Customer transactions.

```
WITH CTE_A AS (
SELECT 
	customer_id
,	MONTH(txn_date) AS Month
,	EOMONTH(txn_date) AS EoMonth
,	CASE WHEN txn_type='deposit' THEN txn_amount
				     ELSE -txn_amount END AS Balance
FROM customer_transactions
)
, CTE_B AS (
SELECT 
	Customer_id
,	Month
,   EoMonth
,	SUM(Balance) AS MonthlyChange
FROM CTE_A
GROUP BY Month, Customer_id, EOMONTH)

SELECT 
	Customer_id
,	Month
,	EOMONTH
,	MonthlyChange
,	SUM(MonthlyChange) OVER (PARTITION BY customer_id ORDER BY Month) AS MonthEndBalance	 
FROM CTE_B
GROUP BY Customer_id, Month, EOMONTH, MonthlyChange
ORDER BY customer_id ASC
```
