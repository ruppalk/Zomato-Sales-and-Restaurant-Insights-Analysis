-- --3.Convert the Average cost for 2 column into USD dollars-- --
select * from restaurants;
select r.restaurantid, r.Restaurant_Name,
r.Average_cost_for_two,
c.usd_rate,
round(r.Average_cost_for_two/c.usd_rate,2) as Avg_Price_for_two
from restaurants r
join currency c on r.Currency = c.currency;


ALTER TABLE currency 
CHANGE COLUMN `USD Rate` USD_Rate DOUBLE;

-- -- 4.Find the Numbers of Resturants based on City and Country?.-- --
select r.city,
c.countryname,
COUNT(DISTINCT r.restaurantid) as no_of_restaurants
from restaurants r
join country c on r.countrycode = c.countryID
GROUP BY R.CITY, C.COUNTRYNAME
ORDER BY  no_of_restaurants DESC
LIMIT 10;

-- -- 5.Numbers of Resturants opening based on Year , Quarter , Month? -- --
SELECT 
year(R.datekey_opening) AS YEAR,
quarter(R.datekey_opening) AS QUARTER,
monthname(R.datekey_opening)AS MONTH,
count(*) AS NO_OF_RESTAURANTS
FROM restaurants R 
GROUP BY YEAR, QUARTER, MONTH 
ORDER BY YEAR, QUARTER;


DESCRIBE restaurants;

SELECT 
R.YEAR_OPENING AS YEAR,
count(*) AS NO_OF_RESTAURANTS
FROM restaurants R 
GROUP BY YEAR
ORDER BY YEAR;

-- - - Count of Resturants based on Average Ratings --- -- 
select count(restaurantid) as NO_OF_RESTAURANTS,
round(avg(RATING),1) FROM restaurants 
group by Rating
order by RATING;


SELECT 
  ROUND(Rating, 1) AS RatingBucket,
  COUNT(restaurantid) AS RestaurantCount
FROM Restaurants
GROUP BY ROUND(Rating, 1)
ORDER BY RatingBucket;

select case 
WHEN RATING <=2 then "0-2"                -- --- -- --- -- --- -- --- DOUBT -- -- -- 
WHEN RATING <=3 THEN "2-3"
WHEN RATING <=4 THEN "3-4"
WHEN RATING <=5 THEN "4-5"
END  RATING, 
count(RESTAURANTID)AS NO_OF_RESTAURANTS
FROM restaurants
group by RATING
order by RATING;


-- --  Create buckets based on Average Price of reasonable size and find out how many resturants falls in each buckets -- --
select distinct Price_range,  count(restaurantid) FROM restaurants
group by Price_range;  --- --- --- 1 < 500, 2 <1000 ,3<3000,4 till 8000,highrst 8000 --- -- -- 

SELECT CASE 
WHEN  PRICE_RANGE = 1 THEN "0-1000"
WHEN PRICE_RANGE =2 THEN "1001-5000"
WHEN PRICE_RANGE = 3 THEN "5001- 10000"
WHEN PRICE_RANGE = 4 THEN ">10000"
END PRICE_RANGE, 
count(RESTAURANTID) AS N0_OF_RESTAURANTS
FROM restaurants
group by Price_range
order by Price_range;


-- -- Percentage of Resturants based on "Has_Table_booking" -- -- --
select HAS_TABLE_BOOKING,
count(*)*100.0/(select count(restaurantid) from restaurants)  as percent_rest
from restaurants
group by HAS_TABLE_BOOKING ;


-- -- Percentage of Resturants based on "Has_Online_delivery" -- -- -- -- 
select Has_Online_delivery,
count(*)*100.0/(select count(restaurantid) from restaurants)  as percent_rest
from restaurants
group by Has_Online_delivery ;


-- -- -- top 10 cuisines  -- -- --
select cuisines,
count(restaurantid) as count
from restaurants
group by Cuisines
order by count desc
limit 10;






