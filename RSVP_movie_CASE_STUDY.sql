USE imdb;

/* Now that you have imported the data sets, let’s explore some of the tables. 
 To begin with, it is beneficial to know the shape of the tables and whether any column has null values.
 Further in this segment, you will take a look at 'movies' and 'genre' tables.*/



-- Segment 1:


-- Q1. Find the total number of rows in each table of the schema?
-- Type your code below:
SELECT 'director_mapping' AS TableName,
	COUNT(*) AS RowNumber
FROM director_mapping
UNION ALL   
SELECT 'genre' AS TableName,
	COUNT(*) AS RowNumber
FROM genre    
UNION ALL   
SELECT 'movie' AS TableName,
	COUNT(*) AS RowNumber
FROM movie
UNION ALL   
SELECT 'names' AS TableName,
	Count(*) AS RowNumber
FROM names
UNION ALL
SELECT 'ratings' AS TableName,
Count(*) AS RowNumber
FROM ratings
UNION ALL
SELECT 'role_mapping' AS TableName,
Count(*) AS RowNumber
FROM role_mapping;

 -- director_mapping table has 3867 rows, genre table has 14662 rows,  names table has 25735 rows, ratings 7997 rows
 -- role_mapping has 15615 rows.
 

-- Q2. Which columns in the movie table have null values?
-- Type your code below:
SELECT Sum(CASE
             WHEN id IS NULL THEN 1
             ELSE 0
           end) AS ID_null,
       Sum(CASE
             WHEN title IS NULL THEN 1
             ELSE 0
           end) AS title_null,
       Sum(CASE
             WHEN year IS NULL THEN 1
             ELSE 0
           end) AS year_null,
       Sum(CASE
             WHEN date_published IS NULL THEN 1
             ELSE 0
           end) AS date_published_null,
       Sum(CASE
             WHEN duration IS NULL THEN 1
             ELSE 0
           end) AS duration_null,
       Sum(CASE
             WHEN country IS NULL THEN 1
             ELSE 0
           end) AS country_null,
       Sum(CASE
             WHEN worlwide_gross_income IS NULL THEN 1
             ELSE 0
           end) AS worlwide_gross_income_null,
       Sum(CASE
             WHEN languages IS NULL THEN 1
             ELSE 0
           end) AS languages_null,
       Sum(CASE
             WHEN production_company IS NULL THEN 1
             ELSE 0
           end) AS production_company_null
FROM   movie; 

-- Columns with null values are (country(20 null), worlwide_gross_income(3724 null), languages(194 null), production_company(528 null))

-- Now as you can see four columns of the movie table has null values. Let's look at the at the movies released each year. 
-- Q3. Find the total number of movies released each year? How does the trend look month wise? (Output expected)

/* Output format for the first part:

+---------------+-------------------+
| Year			|	number_of_movies|
+-------------------+----------------
|	2017		|	2134			|
|	2018		|		.			|
|	2019		|		.			|
+---------------+-------------------+
SELECT COUNT('id'),
FROM movie			
	   



Output format for the second part of the question:
+---------------+-------------------+
|	month_num	|	number_of_movies|
+---------------+----------------
|	1			|	 134			|
|	2			|	 231			|
|	.			|		.			|
+---------------+-------------------+ */
-- Type your code below:
SELECT
	year as 'Year',
    COUNT(id) as num_of_movies
FROM movie
GROUP BY year;    

-- Obeservation: Highest number of movies realeased in year 2017(3052)

SELECT MONTH(date_published) AS month_num,
	   COUNT(id) as Num_of_movies
FROM movie
GROUP BY month_num
ORDER BY month_num;   

-- Highest number of movies realesed in month of march.




/*The highest number of movies is produced in the month of March.
So, now that you have understood the month-wise trend of movies, let’s take a look at the other details in the movies table. 
We know USA and India produces huge number of movies each year. Lets find the number of movies produced by USA or India for the last year.*/
  
-- Q4. How many movies were produced in the USA or India in the year 2019??
-- Type your code below:

SELECT Count(id) AS movie_count_USA_or_INDIA
FROM movie
WHERE ( country LIKE '%INDIA%'
OR country LIKE '%USA%' )
AND year = 2019;

-- The number of movies released in USA or INDIA in year 2019 are 1059.



/* USA and India produced more than a thousand movies(you know the exact number!) in the year 2019.
Exploring table Genre would be fun!! 
Let’s find out the different genres in the dataset.*/

-- Q5. Find the unique list of the genres present in the data set?
-- Type your code below:
SELECT  DISTINCT genre AS Unique_genre_list
FROM genre;

/*the genres are drama,fantasy,thriller,comedy,horror,family,romance,adventure,ac􀆟on,scifi,
crime,mystery,others
Our investigation reveals that there are a total of 13 distinct movie genres*/







/* So, RSVP Movies plans to make a movie of one of these genres.
Now, wouldn’t you want to know which genre had the highest number of movies produced in the last year?
Combining both the movie and genres table can give more interesting insights. */

-- Q6.Which genre had the highest number of movies produced overall?
-- Type your code below:

SELECT genre,
	   count(*) as Count
FROM genre as g
GROUP BY genre
ORDER BY Count DESC
LIMIT 1;

-- genre drama has the highest number of movies

/* So, based on the insight that you just drew, RSVP Movies should focus on the ‘Drama’ genre.
But wait, it is too early to decide. A movie can belong to two or more genres.
So, let’s find out the count of movies that belong to only one genre.*/





/* So, based on the insight that you just drew, RSVP Movies should focus on the ‘Drama’ genre. 
But wait, it is too early to decide. A movie can belong to two or more genres. 
So, let’s find out the count of movies that belong to only one genre.*/

-- Q7. How many movies belong to only one genre?
-- Type your code below:

WITH unique_movie
AS (SELECT movie_id,
Count(genre) AS Total_genre
FROM genre
GROUP BY movie_id)
SELECT Count(*) AS movie_with_one_genre
FROM unique_movie
WHERE total_genre = 1;
-- 3289 movies belong to only one genre








/* There are more than three thousand movies which has only one genre associated with them.
So, this figure appears significant. 
Now, let's find out the possible duration of RSVP Movies’ next project.*/

-- Q8.What is the average duration of movies in each genre? 
-- (Note: The same movie can belong to multiple genres.)


/* Output format:

+---------------+-------------------+
| genre			|	avg_duration	|
+-------------------+----------------
|	thriller	|		105			|
|	.			|		.			|
|	.			|		.			|
+---------------+-------------------+ */
-- Type your code below:

SELECT genre,
	   ROUND(AVG(duration),2) AS avg_duration
FROM movie  m
INNER JOIN genre g
ON m.id = g.movie_id
GROUP BY genre;
       
/* drama has 106.77 average_dura􀆟on,fantasy has 105.14,thriller has 101.58 ,comedy has
102.62,horror has 92.72,family has 100.97,
romance has 109.53,adventure has 101.87,action has 112.88,sci-fi has 97.94,crime has
107.05,mystery has 101.80,others has 100.16*/






/* Now you know, movies of genre 'Drama' (produced highest in number in 2019) has the average duration of 106.77 mins.
Lets find where the movies of genre 'thriller' on the basis of number of movies.*/

-- Q9.What is the rank of the ‘thriller’ genre of movies among all the genres in terms of number of movies produced? 
-- (Hint: Use the Rank function)


/* Output format:
+---------------+-------------------+---------------------+
| genre			|		movie_count	|		genre_rank    |	
+---------------+-------------------+---------------------+
|drama			|	2312			|			2		  |
+---------------+-------------------+---------------------+*/
-- Type your code below:

WITH genre_rank AS (
SELECT genre, COUNT(movie_id) AS movie_count, 
RANK() OVER (ORDER BY COUNT(movie_id) DESC) AS genre_rank 
FROM genre 
GROUP BY genre
)
SELECT * FROM genre_rank 
WHERE genre='Thriller';

-- Thriller has rank=3 and movie count of 1484






/*Thriller movies is in top 3 among all genres in terms of number of movies
 In the previous segment, you analysed the movies and genres tables. 
 In this segment, you will analyse the ratings table as well.
To start with lets get the min and max values of different columns in the table*/




-- Segment 2:




-- Q10.  Find the minimum and maximum values in  each column of the ratings table except the movie_id column?
/* Output format:
+---------------+-------------------+---------------------+----------------------+-----------------+-----------------+
| min_avg_rating|	max_avg_rating	|	min_total_votes   |	max_total_votes 	 |min_median_rating|min_median_rating|
+---------------+-------------------+---------------------+----------------------+-----------------+-----------------+
|		0		|			5		|	       177		  |	   2000	    		 |		0	       |	8			 |
+---------------+-------------------+---------------------+----------------------+-----------------+-----------------+*/
-- Type your code below:
SELECT 
	min(avg_rating) as min_avg_rating, 
	max(avg_rating) as max_avg_rating,
    max(total_votes) as min_total_votes,
    max(total_votes) as max_total_votes,
    max(median_rating) as min_median_rating,
    max(median_rating) as max_median_rating
FROM ratings;

/*min_avg_rating is 1,max_avg_range is 10,min_total_votes is 100,max_total_votes is
725138,min_median_rating is 1,
max_median_rating is 10*/



    

/* So, the minimum and maximum values in each column of the ratings table are in the expected range. 
This implies there are no outliers in the table. 
Now, let’s find out the top 10 movies based on average rating.*/

-- Q11. Which are the top 10 movies based on average rating?
/* Output format:
+---------------+-------------------+---------------------+
| title			|		avg_rating	|		movie_rank    |
+---------------+-------------------+---------------------+
| Fan			|		9.6			|			5	  	  |
|	.			|		.			|			.		  |
|	.			|		.			|			.		  |
|	.			|		.			|			.		  |
+---------------+-------------------+---------------------+*/
-- Type your code below:
-- It's ok if RANK() or DENSE_RANK() is used too

SELECT m.title,
       r.avg_rating,
       DENSE_RANK() OVER( ORDER BY r.avg_rating DESC) AS movie_rank 
FROM movie AS m
INNER JOIN ratings AS r
ON m.id = r.movie_id
LIMIT 10;    

/* top 10 movies are Gini Helida Kathe,Love in Kilnerry,Gini Helida Kathe,Runam,Fan,Android
Kunjappan Version 5.25,
Yeh Suhaagraat Impossible,Safe,The Brighton Miracle,Shibu*/  





/* Do you find you favourite movie FAN in the top 10 movies with an average rating of 9.6? If not, please check your code again!!
So, now that you know the top 10 movies, do you think character actors and filler actors can be from these movies?
Summarising the ratings table based on the movie counts by median rating can give an excellent insight.*/

-- Q12. Summarise the ratings table based on the movie counts by median ratings.
/* Output format:

+---------------+-------------------+
| median_rating	|	movie_count		|
+-------------------+----------------
|	1			|		105			|
|	.			|		.			|
|	.			|		.			|
+---------------+-------------------+ */
-- Type your code below:
-- Order by is good to have

SELECT median_rating,
	   COUNT(movie_id) AS movie_count
FROM ratings 
GROUP BY median_rating       
ORDER BY median_rating;



-- median_rating 7 is the highest


/* Movies with a median rating of 7 is highest in number. 
Now, let's find out the production house with which RSVP Movies can partner for its next project.*/

-- Q13. Which production house has produced the most number of hit movies (average rating > 8)??
/* Output format:
+------------------+-------------------+---------------------+
|production_company|movie_count	       |	prod_company_rank|
+------------------+-------------------+---------------------+
| The Archers	   |		1		   |			1	  	 |
+------------------+-------------------+---------------------+*/
-- Type your code below:
WITH production_company_hit_movie_summary
AS (SELECT production_company,
			Count(movie_id) AS MOVIE_COUNT,
			RANK () OVER(ORDER BY Count(movie_id) DESC ) AS PROD_COMPANY_RANK
	FROM   ratings AS R
	INNER JOIN movie AS M
	ON M.id = R.movie_id
	WHERE  avg_rating > 8 AND production_company IS NOT NULL
	GROUP  BY production_company)
SELECT *
FROM   production_company_hit_movie_summary
WHERE  prod_company_rank = 1; 

-- dream warrior pictures and national theatre live are the top 2 these will be best partners for RSVP Movies


-- It's ok if RANK() or DENSE_RANK() is used too
-- Answer can be Dream Warrior Pictures or National Theatre Live or both

-- Q14. How many movies released in each genre during March 2017 in the USA had more than 1,000 votes?
/* Output format:

+---------------+-------------------+
| genre			|	movie_count		|
+-------------------+----------------
|	thriller	|		105			|
|	.			|		.			|
|	.			|		.			|
+---------------+-------------------+ */
-- Type your code below:
SELECT genre,
Count(id) AS movie_count
FROM genre g
INNER JOIN movie m
ON m.id = g.movie_id
INNER JOIN ratings r
ON m.id = r.movie_id
WHERE Month(date_published) = 3
AND Year(date_published) = 2017
AND total_votes > 1000
AND country LIKE '%USA%'
GROUP BY genre
ORDER BY movie_count DESC;
    
-- drama movie_count is 24,comedy 9,acti on 8,thriller 8,sci-fi 7,crime 6,horror 6,mystery 4,romance
-- 4,fantasy 3,adventure 3,family 1







-- Lets try to analyse with a unique problem statement.
-- Q15. Find movies of each genre that start with the word ‘The’ and which have an average rating > 8?
/* Output format:
+---------------+-------------------+---------------------+
| title			|		avg_rating	|		genre	      |
+---------------+-------------------+---------------------+
| Theeran		|		8.3			|		Thriller	  |
|	.			|		.			|			.		  |
|	.			|		.			|			.		  |
|	.			|		.			|			.		  |
+---------------+-------------------+---------------------+*/
-- Type your code below:

SELECT 
	m.title,
    r.avg_rating,
    g.genre
FROM movie AS m
	INNER JOIN ratings AS r
		ON m.id = r.movie_id
	INNER JOIN genre as g
		ON m.id = g.movie_id
	WHERE avg_rating > 8 AND m.title LIKE 'The%';  
    
/* the blue elephant 2(drama) avg_rating 8.8,the blue elephant 2(horror) avg_rating 8.8,the blue
elephant 2(mystery) avg_ra􀆟ng 8.8,
the brington miracle(drama) avg_rating 9.5,the irish man(crime) avg_rating 8.7,the irish man(drama)
avg_ra􀆟ng 8.7,the colour of
darkness(drama) avg_rating 9.1,theeran adhigaram ondru(action) 8.3,theeran adhigaram
ondru(crime) 8.3,
theeran adhigaram ondru(thriller) 8.3,the mystery of godliness(drama) avg_rating 8.5,the
gambinos(crime) avg_rating 8.4,
the gambinos(drama) avg_rating 8.4,the king and I(drama) avg_rating 8.2,the king and I(romance)
avg_rating 8.2*/






-- You should also try your hand at median rating and check whether the ‘median rating’ column gives any significant insights.
-- Q16. Of the movies released between 1 April 2018 and 1 April 2019, how many were given a median rating of 8?
-- Type your code below:
SELECT Count(id) AS Movie_released_april2018_april2019
FROM movie m
INNER JOIN ratings r
ON m.id = r.movie_id
WHERE ( date_published BETWEEN '2018-04-01' AND '2019-04-01' )
AND ( median_rating = 8 ); 

-- 361 movies released between april 2018 and april 2019









-- Once again, try to solve the problem given below.
-- Q17. Do German movies get more votes than Italian movies? 
-- Hint: Here you have to find the total number of votes for both German and Italian movies.
-- Type your code below:


SELECT
	country,
	SUM(total_votes) AS total_votes
FROM movie AS m
INNER JOIN
ratings AS r
ON m.id = r.movie_id
WHERE country IN ('Germany', 'Italy')
GROUP BY country;

-- Germany got total_votes 106710 and Italy got 77965 so Yes Germany movies got more votes
-- Answer is Yes





/* Now that you have analysed the movies, genres and ratings tables, let us now analyse another table, the names table. 
Let’s begin by searching for null values in the tables.*/




-- Segment 3:



-- Q18. Which columns in the names table have null values??
/*Hint: You can find null values for individual columns or follow below output format
+---------------+-------------------+---------------------+----------------------+
| name_nulls	|	height_nulls	|date_of_birth_nulls  |known_for_movies_nulls|
+---------------+-------------------+---------------------+----------------------+
|		0		|			123		|	       1234		  |	   12345	    	 |
+---------------+-------------------+---------------------+----------------------+*/
-- Type your code below:
SELECT 
Sum(CASE WHEN NAME IS NULL THEN 1 ELSE 0 END) AS name_nulls,
Sum(CASE WHEN height IS NULL THEN 1 ELSE 0 END) AS HEIGHT_nulls,
Sum(CASE WHEN date_of_birth IS NULL THEN 1 ELSE 0 END) AS DATE_OF_BIRTH_nulls,
Sum(CASE WHEN known_for_movies IS NULL THEN 1 ELSE 0 END) AS KNOWN_FOR_MOVIES_nulls
FROM names;

-- heights has 17335 null values,date of birth has 13431,known_for_movies has 15226 and names
-- doesn't have any null values





/* There are no Null value in the column 'name'.
The director is the most important person in a movie crew. 
Let’s find out the top three directors in the top three genres who can be hired by RSVP Movies.*/

-- Q19. Who are the top three directors in the top three genres whose movies have an average rating > 8?
-- (Hint: The top three genres would have the most number of movies with an average rating > 8.)
/* Output format:

+---------------+-------------------+
| director_name	|	movie_count		|
+---------------+-------------------|
|James Mangold	|		4			|
|	.			|		.			|
|	.			|		.			|
+---------------+-------------------+ */
-- Type your code below:

WITH top_3_genres AS
(
           SELECT     genre,
                      Count(m.id)                            AS movie_count ,
                      Rank() OVER(ORDER BY Count(m.id) DESC) AS genre_rank
           FROM       movie                                  AS m
           INNER JOIN genre                                  AS g
           ON         g.movie_id = m.id
           INNER JOIN ratings AS r
           ON         r.movie_id = m.id
           WHERE      avg_rating > 8
           GROUP BY   genre limit 3 )
SELECT     n.NAME            AS director_name ,
           Count(d.movie_id) AS movie_count
FROM       director_mapping  AS d
INNER JOIN genre G
using      (movie_id)
INNER JOIN names AS n
ON         n.id = d.name_id
INNER JOIN top_3_genres
using      (genre)
INNER JOIN ratings
using      (movie_id)
WHERE      avg_rating > 8
GROUP BY   NAME
ORDER BY   movie_count DESC limit 3 ;


-- james mangold movie_count 4,anthony russo movie count 3 and soubin shahir 3 are the top 3
-- directors in top 3 genres




/* James Mangold can be hired as the director for RSVP's next project. Do you remeber his movies, 'Logan' and 'The Wolverine'. 
Now, let’s find out the top two actors.*/

-- Q20. Who are the top two actors whose movies have a median rating >= 8?
/* Output format:

+---------------+-------------------+
| actor_name	|	movie_count		|
+-------------------+----------------
|Christain Bale	|		10			|
|	.			|		.			|
+---------------+-------------------+ */
-- Type your code below:

SELECT n.name      AS Actor_name,
       Count(m.id) AS Movie_count
FROM   movie m
       INNER JOIN ratings r
               ON m.id = r.movie_id
       INNER JOIN role_mapping rm
               ON m.id = rm.movie_id
       INNER JOIN names n
               ON n.id = rm.name_id
WHERE  median_rating >= 8
GROUP  BY actor_name
ORDER  BY movie_count DESC
LIMIT  2; 

-- Mammooty movie_count 8 and Mohanlal movie_count 5 are top 2





/* Have you find your favourite actor 'Mohanlal' in the list. If no, please check your code again. 
RSVP Movies plans to partner with other global production houses. 
Let’s find out the top three production houses in the world.*/

-- Q21. Which are the top three production houses based on the number of votes received by their movies?
/* Output format:
+------------------+--------------------+---------------------+
|production_company|vote_count			|		prod_comp_rank|
+------------------+--------------------+---------------------+
| The Archers		|		830			|		1	  		  |
|	.				|		.			|			.		  |
|	.				|		.			|			.		  |
+-------------------+-------------------+---------------------+*/
-- Type your code below:

SELECT     production_company,
           Sum(total_votes)                                   AS vote_count,
           Row_number() OVER (ORDER BY Sum(total_votes) DESC) AS prod_comp_rank
FROM       movie m
INNER JOIN ratings r
ON         m.id = r.movie_id
GROUP BY   production_company limit 3;

/* Marvel studios with vote_count 2656967 is the number 1 ,Twentieth Century Fox with vot_count
2411163 and
Warner Bros with vote_count 2396057 are 2 and 3*/






/*Yes Marvel Studios rules the movie world.
So, these are the top three production houses based on the number of votes received by the movies they have produced.

Since RSVP Movies is based out of Mumbai, India also wants to woo its local audience. 
RSVP Movies also wants to hire a few Indian actors for its upcoming project to give a regional feel. 
Let’s find who these actors could be.*/

-- Q22. Rank actors with movies released in India based on their average ratings. Which actor is at the top of the list?
-- Note: The actor should have acted in at least five Indian movies. 
-- (Hint: You should use the weighted average based on votes. If the ratings clash, then the total number of votes should act as the tie breaker.)

/* Output format:
+---------------+-------------------+---------------------+----------------------+-----------------+
| actor_name	|	total_votes		|	movie_count		  |	actor_avg_rating 	 |actor_rank	   |
+---------------+-------------------+---------------------+----------------------+-----------------+
|	Yogi Babu	|			3455	|	       11		  |	   8.42	    		 |		1	       |
|		.		|			.		|	       .		  |	   .	    		 |		.	       |
|		.		|			.		|	       .		  |	   .	    		 |		.	       |
|		.		|			.		|	       .		  |	   .	    		 |		.	       |
+---------------+-------------------+---------------------+----------------------+-----------------+*/
-- Type your code below:

SELECT NAME                                                         AS
       actor_name,
       Sum(total_votes)                                             AS
       total_votes,
       Count(m.id)                                                  AS
       movie_count,
       Round(Sum(avg_rating * total_votes) / Sum(total_votes), 2) AS
       actor_avg_rating,
       Row_number()
         OVER (
           ORDER BY Round(Sum(avg_rating * total_votes) / Sum(total_votes), 2)
         DESC)
                                                                    AS
       actor_rank
FROM   names n
       INNER JOIN role_mapping rm
               ON n.id = rm.name_id
       INNER JOIN ratings r
               ON rm.movie_id = r.movie_id
       INNER JOIN movie m
               ON m.id = rm.movie_id
WHERE  category = "actor"
       AND country LIKE "%india%"
GROUP  BY actor_name
HAVING movie_count >= 5; 

/* Vijay Sethupathi total_votes 23114 movie_count 5 actor_avg_rating 8.42,Fahadh Faasil
total_votes 13557 movie_count 5
actor_avg_rating 7.99,Yogi Babu total_votes 8500 movie_count 11 actor_avg_rating 7.83,Joju George
total_votes 3926 movie_count 5
actor_avg_rating 7.58,Ammy Virk total_votes 2504 movie_count 6 actor_avg_rating 7.55 are top 5*/






-- Top actor is Vijay Sethupathi

-- Q23.Find out the top five actresses in Hindi movies released in India based on their average ratings? 
-- Note: The actresses should have acted in at least three Indian movies. 
-- (Hint: You should use the weighted average based on votes. If the ratings clash, then the total number of votes should act as the tie breaker.)
/* Output format:
+---------------+-------------------+---------------------+----------------------+-----------------+
| actress_name	|	total_votes		|	movie_count		  |	actress_avg_rating 	 |actress_rank	   |
+---------------+-------------------+---------------------+----------------------+-----------------+
|	Tabu		|			3455	|	       11		  |	   8.42	    		 |		1	       |
|		.		|			.		|	       .		  |	   .	    		 |		.	       |
|		.		|			.		|	       .		  |	   .	    		 |		.	       |
|		.		|			.		|	       .		  |	   .	    		 |		.	       |
+---------------+-------------------+---------------------+----------------------+-----------------+*/
-- Type your code below:

SELECT     NAME                                                                                                                    AS actress_name,
           Sum(total_votes)                                                                                                        AS total_votes,
           Count(m.id)                                                                                                             AS movie_count,
           Round(Sum(avg_rating * total_votes) / Sum(total_votes), 2)                                                          AS actress_avg_rating,
           Row_number() OVER ( ORDER BY Round(Sum(avg_rating * total_votes) / Sum(total_votes), 2) DESC, Sum(total_votes) DESC ) AS actress_rank
FROM       names n
INNER JOIN role_mapping rm
ON         n.id = rm.name_id
INNER JOIN ratings r
ON         rm.movie_id = r.movie_id
INNER JOIN movie m
ON         m.id = rm.movie_id
WHERE      category = "actress"
AND        country LIKE "%india%"
AND        languages LIKE "%hindi%"
GROUP BY   actress_name
HAVING     movie_count >= 3 limit 5;


/*Taapsee Pannu total_votes 18061 movie_count 3 actress_avg_ra􀆟ng 7.74,Kri􀆟 Sanon total_votes
21967 movie_count 3
actress_avg_ra􀆟ng 7.05,Divya Du􀆩a total_votes 8579 movie_count 3 actress_avg_ra􀆟ng
6.88,Shraddha Kapoor total_votes 26779
movie_count 3 avg_ra􀆟ng 6.63,Kri􀆟 Kharbanda total_votes 2549 movie_count 3 actress _avg_ra􀆟ng
4.80 are top 5 actress*/



/* Taapsee Pannu tops with average rating 7.74. 
Now let us divide all the thriller movies in the following categories and find out their numbers.*/


/* Q24. Select thriller movies as per avg rating and classify them in the following category: 

			Rating > 8: Superhit movies
			Rating between 7 and 8: Hit movies
			Rating between 5 and 7: One-time-watch movies
			Rating < 5: Flop movies
--------------------------------------------------------------------------------------------*/
-- Type your code below:

SELECT     title,
           genre,
           avg_rating,
           CASE
                      WHEN avg_rating > 8 THEN 'Superhit movies'
                      WHEN avg_rating BETWEEN 7 AND        8 THEN 'Hit movies'
                      WHEN avg_rating BETWEEN 5 AND        7 THEN 'One-time-watch movies'
                      WHEN avg_rating < 5 THEN 'Flop movies'
           END   AS rating_category
FROM       movie AS m
INNER JOIN genre AS g
ON         m.id = g.movie_id
INNER JOIN ratings AS r







/* Until now, you have analysed various tables of the data set. 
Now, you will perform some tasks that will give you a broader understanding of the data in this segment.*/

-- Segment 4:

-- Q25. What is the genre-wise running total and moving average of the average movie duration? 
-- (Note: You need to show the output table in the question.) 
/* Output format:
+---------------+-------------------+---------------------+----------------------+
| genre			|	avg_duration	|running_total_duration|moving_avg_duration  |
+---------------+-------------------+---------------------+----------------------+
|	comdy		|			145		|	       106.2	  |	   128.42	    	 |
|		.		|			.		|	       .		  |	   .	    		 |
|		.		|			.		|	       .		  |	   .	    		 |
|		.		|			.		|	       .		  |	   .	    		 |
+---------------+-------------------+---------------------+----------------------+*/
-- Type your code below:

SELECT genre,
       Round(Avg(duration)) AS avg_duration,
       SUM(Round(Avg(duration), 1))
         over (
           ORDER BY genre)    AS running_total_duration,
       Round(Avg(Round(Avg(duration), 2))
               over (
                 ORDER BY genre ROWS BETWEEN unbounded preceding AND CURRENT ROW
               ), 2)
                              AS moving_avg_duration
FROM   movie AS m
       inner join genre AS g
               ON m.id = g.movie_id
GROUP  BY genre
ORDER  BY genre;

/*Action avg_duration 113 running_total_duration 112.9 moving_avg_duration 112.88,Adventure avg_duration 102 
running_total_duration 214.8 moving_avg_duration 107.38,Comedy avg_duration 103 running_total_duration 317.4 moving_avg_duration 105.79,
Crime avg_duration 107 running_total_duration 424.5 moving_avg_duration 106.11,Drama avg_duration 107 running_total_duration 531.3 
moving_avg_duration 106.24,Family avg_duration 101 running_total_duration 632.3 moving_avg_duration 105.36,Fantasy avg_duration 105 
running_total_duration 737.4 moving_avg_duration 105.33,Horror avg_duration 93 running_total_duration 830.1 moving_avg_duration 103.75,
Mystery avg_duration 102 running_total_duratio 931.9 moving_avg_duration 103.54,Others avg_duration 100 running_total_duration 1032.1 
moving_avg_duration 103.20,Romance avg_duration 110 running_total_duration 1141.6 moving_avg_duration 103.77,Sci-Fi avg_duration 98 
running_total_duratio 1239.5 moving_avg_duration 103.29,Thriller avg_duration 102 running_total_duration 1341.1 
moving_avg_duration 103.16*/





-- Round is good to have and not a must have; Same thing applies to sorting


-- Let us find top 5 movies of each year with top 3 genres.

-- Q26. Which are the five highest-grossing movies of each year that belong to the top three genres? 
-- (Note: The top 3 genres would have the most number of movies.)

/* Output format:
+---------------+-------------------+---------------------+----------------------+-----------------+
| genre			|	year			|	movie_name		  |worldwide_gross_income|movie_rank	   |
+---------------+-------------------+---------------------+----------------------+-----------------+
|	comedy		|			2017	|	       indian	  |	   $103244842	     |		1	       |
|		.		|			.		|	       .		  |	   .	    		 |		.	       |
|		.		|			.		|	       .		  |	   .	    		 |		.	       |
|		.		|			.		|	       .		  |	   .	    		 |		.	       |
+---------------+-------------------+---------------------+----------------------+-----------------+*/
-- Type your code below:

-- Top 3 Genres based on most number of movies

WITH top_three_genre
AS
  (
             SELECT     genre,
                        count(m.id) AS movie_count
             FROM       movie m
             INNER JOIN genre g
             ON         g.movie_id = m.id
             GROUP BY   genre
             ORDER BY   movie_count DESC
             LIMIT      3 ),
  -- Select the top five movies from each of the top three genres for each year based on worldwide gross income.
  -- And also making every worldwide_gross_income to dollar ie, worldwide_gross_income_usd
  final_tab
AS
  (
             SELECT     g.genre,
                        m.year,
                        m.title AS movie_name,
                        worlwide_gross_income,
                        CASE
                                   WHEN worlwide_gross_income LIKE '%INR' THEN round(cast(REPLACE(REPLACE(worlwide_gross_income, 'INR', '') ,'$','') AS DECIMAL(7,0)) * 0.012)
                                   ELSE round(cast(REPLACE(REPLACE(worlwide_gross_income, '$', ''), 'INR','') AS                                        DECIMAL(7,0)))
                        end                                                                         AS worlwide_gross_income_usd,
                        row_number() over (partition BY m.year ORDER BY worlwide_gross_income DESC) AS movie_rank
             FROM       movie m
             INNER JOIN genre g
             ON         g.movie_id = m.id
             WHERE      g.genre IN
                        (
                               SELECT genre
                               FROM   top_three_genre) )
  -- Retrieve the results of the top movies in the top genres.
  SELECT genre,
         year,
         movie_name,
         worlwide_gross_income_usd,
         movie_rank
  FROM   final_tab
  WHERE  movie_rank <= 5;

/* In drama genre shatamanam bhavati,winner,thank you for your service,antony&cleopatra,joker are top 5 in comedy the healer,
La fuitina sbagliata,Gung-hab,Eaten by Lions,friend zone in thriller are Gi-eok-ui bam,The Villain,Prescience,Joker in  these
genres are top movies*/






-- Finally, let’s find out the names of the top two production houses that have produced the highest number of hits among multilingual movies.
-- Q27.  Which are the top two production houses that have produced the highest number of hits (median rating >= 8) among multilingual movies?
/* Output format:
+-------------------+-------------------+---------------------+
|production_company |movie_count		|		prod_comp_rank|
+-------------------+-------------------+---------------------+
| The Archers		|		830			|		1	  		  |
|	.				|		.			|			.		  |
|	.				|		.			|			.		  |
+-------------------+-------------------+---------------------+*/
-- Type your code below:
WITH top_production_houses
     AS (SELECT production_company,
                Count(*)                    AS movie_count,
                Row_number()
                  over (
                    ORDER BY Count(*) DESC) AS prod_comp_rank
         FROM   movie m
                inner join ratings r
                        ON m.id = r.movie_id
         WHERE  median_rating >= 8
                AND Position(',' IN languages) > 0
                -- Movies with multiple languages
                AND production_company IS NOT NULL
         GROUP  BY production_company)
SELECT production_company,
       movie_count,
       prod_comp_rank
FROM   top_production_houses
WHERE  prod_comp_rank <= 2; 


/*Star Cinema and Twentieth Century Fox are the top two production houses that have 
produced the highest number of hits among multilingual movies.*/




-- Multilingual is the important piece in the above question. It was created using POSITION(',' IN languages)>0 logic
-- If there is a comma, that means the movie is of more than one language


-- Q28. Who are the top 3 actresses based on number of Super Hit movies (average rating >8) in drama genre?
/* Output format:
+---------------+-------------------+---------------------+----------------------+-----------------+
| actress_name	|	total_votes		|	movie_count		  |actress_avg_rating	 |actress_rank	   |
+---------------+-------------------+---------------------+----------------------+-----------------+
|	Laura Dern	|			1016	|	       1		  |	   9.60			     |		1	       |
|		.		|			.		|	       .		  |	   .	    		 |		.	       |
|		.		|			.		|	       .		  |	   .	    		 |		.	       |
+---------------+-------------------+---------------------+----------------------+-----------------+*/
-- Type your code below:

SELECT     name                                          AS actress_name,
           Sum(total_votes)                              AS total_votes,
           Count(m.id)                                   AS movie_count,
           Avg(avg_rating)                               AS actress_avg_rating,
           Row_number() over (ORDER BY count(m.id) DESC) AS actress_rank
FROM       names n
INNER JOIN role_mapping rm
ON         n.id = rm.name_id
INNER JOIN movie m
ON         m.id = rm.movie_id
INNER JOIN ratings r
ON         r.movie_id = m.id
INNER JOIN genre g
ON         g.movie_id = m.id
WHERE      avg_rating > 8
AND        category = "actress"
AND        genre = "drama"
GROUP BY   actress_name
ORDER BY   movie_count DESC
LIMIT      3;

/* Top 3 actresses based on number of Super Hit movies are Parvathy Thiruvothu, 
Susan Brown and Amanda Lawrence*/



/* Q29. Get the following details for top 9 directors (based on number of movies)
Director id
Name
Number of movies
Average inter movie duration in days
Average movie ratings
Total votes
Min rating
Max rating
total movie durations

Format:
+---------------+-------------------+---------------------+----------------------+--------------+--------------+------------+------------+----------------+
| director_id	|	director_name	|	number_of_movies  |	avg_inter_movie_days |	avg_rating	| total_votes  | min_rating	| max_rating | total_duration |
+---------------+-------------------+---------------------+----------------------+--------------+--------------+------------+------------+----------------+
|nm1777967		|	A.L. Vijay		|			5		  |	       177			 |	   5.65	    |	1754	   |	3.7		|	6.9		 |		613		  |
|	.			|		.			|			.		  |	       .			 |	   .	    |	.		   |	.		|	.		 |		.		  |
|	.			|		.			|			.		  |	       .			 |	   .	    |	.		   |	.		|	.		 |		.		  |
|	.			|		.			|			.		  |	       .			 |	   .	    |	.		   |	.		|	.		 |		.		  |
|	.			|		.			|			.		  |	       .			 |	   .	    |	.		   |	.		|	.		 |		.		  |
|	.			|		.			|			.		  |	       .			 |	   .	    |	.		   |	.		|	.		 |		.		  |
|	.			|		.			|			.		  |	       .			 |	   .	    |	.		   |	.		|	.		 |		.		  |
|	.			|		.			|			.		  |	       .			 |	   .	    |	.		   |	.		|	.		 |		.		  |
|	.			|		.			|			.		  |	       .			 |	   .	    |	.		   |	.		|	.		 |		.		  |
+---------------+-------------------+---------------------+----------------------+--------------+--------------+------------+------------+----------------+

--------------------------------------------------------------------------------------------*/
-- Type you code below:
WITH top_nine_directors AS 
(
    SELECT name_id
    FROM 
        director_mapping AS dm
    GROUP BY name_id
    ORDER BY count(movie_id) DESC
    LIMIT 9
),

-- Creating a CTE to store information about the release dates of movies for the selected directors.
date_info AS
(
    SELECT  
        name_id,
        date_published,
        LEAD(date_published, 1) OVER(PARTITION BY name_id ORDER BY date_published, movie_id) AS next_movie_date
    FROM 
        movie AS m
        INNER JOIN
        director_mapping AS dm
        ON dm.movie_id= m.id
    WHERE name_id IN (SELECT name_id FROM top_nine_directors)
),

-- Calculating the average number of days between consecutive movies for each director.
	avg_inter_movie_days_info AS
(
    SELECT 
        name_id,
        AVG(DATEDIFF(next_movie_date, date_published)) AS avg_inter_movie_days
    FROM date_info
    GROUP BY name_id
)

-- Selecting and aggregating various information about the directors and their movies.
SELECT 
    name_id,
    name AS director_name,
    COUNT(movie_id) AS number_of_movies ,
    ROUND(avg_inter_movie_days) AS avg_inter_movie_days ,
    ROUND(AVG(avg_rating),2) AS avg_rating,
    sum(total_votes) AS total_votes,
    MIN(avg_rating) AS min_rating,
    MAX(avg_rating) AS max_rating, 
    SUM(duration) AS total_duration
FROM 
    movie AS m
    INNER JOIN
    ratings AS r
    ON m.id = r.movie_id
    INNER JOIN 
    director_mapping AS dm
    USING (movie_id)
    INNER JOIN NAMES AS n
    ON dm.name_id = n.id
    INNER JOIN avg_inter_movie_days_info
    USING (name_id)
GROUP BY name_id
-- Ordering the result by the number of movies and the average rating in descending order.
ORDER BY 
    number_of_movies DESC,
    avg_rating DESC;
/*Top 9 directors are A.L. Vijay, Andrew Jones,Steven Soderbergh,Sam Liu, Sion Sono,Jesse V. Johnson, Justin Price, Chris Stokes,
Özgür Bakar*/






