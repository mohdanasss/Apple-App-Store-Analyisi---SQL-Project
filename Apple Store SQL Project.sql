CREATE TABLE applestore_description_combined AS
SELECT * FROM appleStore_description1
UNION ALL
SELECT * FROM appleStore_description2
UNION ALL
SELECT * FROM appleStore_description3
UNION ALL
SELECT * FROM appleStore_description4




**EXPLORATORY DATA ANAYSIS**


-- check the number of unique apps in tablesAppleStore

SELECT COUNT(DISTINCT id) As UniqueAppIds
FROM AppleStore

SELECT COUNT(DISTINCT id) As UniqueAppIds
FROM applestore_description_combined

-- check for any missing values in keyfields

SELECT COUNT(*) AS MissingValues
FROM AppleStore
WHERE track_name is NULL or user_rating is NULL or prime_genre is NULL

SELECT COUNT(*) AS MissingValues
FROM applestore_description_combined
WHERE app_desc is NULL








-- Find out the number of apps per genre

SELECT prime_genre,COUNT(*) AS NUMAPPS
FROM AppleStore
GROUP by prime_genre
ORDER BY NUMAPPS DESC


-- Get an Overview of the app's rating 

SELECT min(user_rating) AS Min_Rating,
       max(user_rating) AS Max_Rating,
       avg(user_rating) AS Avg_Rating
 FROM AppleStore
 
 
 
 
 
 
 
 
 
 -- Get the distribution of app prices
 
 SELECT 
       (price/2)*2 AS Price_Bin_Start,
       ((price/2)*2) + 2 AS Price_Bin_End,
       COUNT(*) AS Num_Apps
 FROM AppleStore
 GROUP by Price_Bin_Start
 ORDER by Price_Bin_Start
    
    
    
    
    
       
 **DATA ANALYSIS**
 
 SELECT CASE
            WHEN price > 0 THEN 'paid'
            ELSE 'free'
        END as App_Type,
        avg(user_rating) AS Avg_Rating
 FROM AppleStore
 GROUP by App_Type
 
 
 
 
 
 -- Check if apps with more languages have higher ratings
 
 SELECT CASE
            WHEn lang_num < 10 THEN '<10 Languages'
            WHEN lang_num BETWEEN 10 AND 30 THEN '10-30 Languages'
            ELSE '>30 Languages'
        END as language_bucket,
        avg(user_rating) AS Avg_Rating
  FROM AppleStore 
  GROUP BY language_bucket
  ORDER by Avg_Rating DESC
  
  
  
  
  
  
  
  -- Check genres with low ratings

SELECT prime_genre,
        avg(user_rating) As Avg_Ratings
FROM AppleStore
GROUP by prime_genre
ORDER BY Avg_Ratings
LIMIT 10






-- Check if there is correlation between the length of the app
 
 SELECT CASE
 			WHEN length(B.app_desc)<500 THEN 'Short'
            WHEN length(B.app_desc) BETWEEN 500 and 1000  THEN 'Medium'
            ELSE 'Long'
        END AS description_length_bucket,
        avg(user_rating) AS Avg_Rating
 FROM AppleStore AS A 
 JOIN applestore_description_combined As B  
 ON A.id = B.id
 GROUP by description_length_bucket
 ORDER BY Avg_Rating DESC
 
 
 
 
 
 
 
 -- Check top-rated apps for each genre
 
 SELECT prime_genre,
 		track_name,
        user_rating
 FROM  
      (SELECT prime_genre,
 			  track_name,
        	  user_rating,
        	  RANK() OVER(PARTITION BY prime_genre ORDER BY user_rating desc, rating_count_tot DESC) AS rank
 	  FROM AppleStore) AS a 
 WHERE a.rank = 1
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 