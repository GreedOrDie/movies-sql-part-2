/*Select all columns and rows from the movies table*/
SELECT *
FROM movies;
/*Select only the title and id of the first 10 rows*/
SELECT title, movieid
FROM movies
LIMIT 10;
/*Find the movie with the id of 485*/
SELECT  movieid, title, genres
FROM movies
WHERE movieid = '485';
/*Find the id (only that column) of the movie Made in America (1993)*/
SELECT movieid
FROM movies
WHERE lower(title) like 'made in america (1993)';
/*Find the first 10 sorted alphabetically*/
SELECT movieid, title
FROM movies
ORDER BY  movieid ASC , title DESC
LIMIT 10;
/*Find all movies from 2002*/
SELECT title
FROM movies
WHERE title LIKE '%2002%';
/*Find out what year the Godfather came out*/
SELECT title
FROM movies
WHERE title LIKE '%Godfather%'; /*1972*/
/*Without using joins find all the comedies*/
SELECT genres, title
FROM movies
WHERE genres LIKE '%Comedy%';
/*Find all comedies in the year 2000*/
SELECT genres, title
FROM movies
WHERE genres LIKE '%Comedy%' AND title LIKE '%(2000)%';
/*Find any movies that are about death and are a comedy*/
SELECT genres, title
FROM movies
WHERE genres LIKE '%Comedy%' AND title LIKE '%Death%';
/*Find any movies from either 2001 or 2002 with a title containing super*/
SELECT title
FROM movies
WHERE (title LIKE '%Super%' AND title LIKE '%(2001)%') OR (title LIKE '%Super%' AND title LIKE '%(2002)%');
/*With Joins
Find all the ratings for the movie Godfather, show just the title and the rating*/
SELECT title, ratings.rating
FROM movies
LEFT JOIN ratings ON movies.movieid = ratings.movieid
WHERE title LIKE '%Godfather, The%';
/*Order the previous objective by newest to oldest*/
SELECT title, ratings.rating
FROM movies
LEFT JOIN ratings ON movies.movieid = ratings.movieid
WHERE title LIKE '%Godfather, The%'
ORDER BY title ASC;
/*Find the comedies from 2005 and get the title and imdbid from the links table*/
SELECT title, imdbid
FROM movies
JOIN links ON links.movieid = movies.movieid
WHERE genres = 'Comedy' AND title LIKE '%(2005)%';
/*Find all movies that have no rating*/
SELECT title, rating
FROM movies
LEFT JOIN ratings ON movies.movieid = ratings.movieid
WHERE ratings.movieid IS NULL;
-- /*Example of many to many*/
-- SELECT *
-- FROM movies m
--   JOIN movie_genre mg ON mg.movieid = m.movieid
--   JOIN genre g ON g.id = mg.genre_id
-- WHERE m.movieid = 1;


-- Part two of the homework

-- Get the average rating for a movie
SELECT title, id, rating, avg(rating)
FROM ratings
JOIN movies ON movies.movieid = ratings.movieid
WHERE rating > 0 AND title LIKE '%Jumanji%'
GROUP BY title, ratings.id;
-- Get the total ratings for a movie
SELECT title, id, rating, count(rating)
FROM ratings
JOIN movies ON movies.movieid = ratings.movieid
WHERE rating > 0 AND title LIKE '%Jumanji%'
GROUP BY title, ratings.id;
-- Get the total movies for a genre
SELECT  genre.genres, count(movies.genres)
FROM movie_genre, movies
JOIN genre ON movies.movieid = genre.id
WHERE  genre.genres like 'Comedy'
GROUP BY genre.genres;
-- Get the average rating for a user
SELECT userid, rating, ratings.userid, avg(rating)
FROM ratings
WHERE userid = 1
  GROUP BY ratings.userid, ratings.rating
ORDER BY avg(rating) DESC;
-- Find the user with the most ratings
SELECT userid, rating, count(ratings.userid)
FROM ratings
GROUP BY userid, ratings.rating
ORDER BY count(ratings.userid) DESC ;
-- Find the user with the highest average rating
SELECT userid, rating, avg(rating)
FROM ratings
GROUP BY  userid, ratings.rating
ORDER BY avg(rating) DESC;
-- Find the user with the highest average rating with more than 50 reviews
SELECT userid, rating, count(ratings.userid), avg(rating)
FROM ratings
WHERE ratings.userid > 50
GROUP BY userid, ratings.rating
HAVING count(ratings.userid) > 50
ORDER BY avg(rating) DESC;
-- Find the movies with an average rating over 4
SELECT title ,rating,  avg(ratings.movieid)
FROM movies
JOIN ratings ON movies.movieid = ratings.movieid
GROUP BY title, rating,  ratings.movieid
HAVING avg(rating) > 4
ORDER BY avg(rating) DESC ;
-- For each genre find the total number of reviews as well as the average review sort by highest average review.
SELECT genre.genres, ratings.movieid, avg(rating)
FROM genre
JOIN ratings ON movieid = genre.id
GROUP BY genre.genres, ratings.movieid
ORDER BY avg(rating) DESC;
-- Complete the following modification objectives:
-- Create a new table called actors (We are going to pretend the actor can only play in one movie)
-- The table should include name, character name, foreign key to movies and date of birth at least plus an id field.
CREATE TABLE public.actors
(
    id SERIAL PRIMARY KEY,
    name VARCHAR(45),
    character_name VARCHAR(100),
    date_of_birth DATE,
    movie_id INT
);

-- Pick 3 movies and create insert statements for 10 actors each. You should use the multi value insert statements
SELECT *
FROM actors;

INSERT INTO actors (name, character_name, date_of_birth, movie_id) VALUES ('Allen', 'this guy', '1988/02/03', 1);
INSERT INTO actors (name, character_name, date_of_birth, movie_id) VALUES ('Bruce', 'that guy', '1958/02/03', 1);
INSERT INTO actors (name, character_name, date_of_birth, movie_id) VALUES ('Chief','other guy', '1902/03/04', 1);
INSERT INTO actors (name, character_name, date_of_birth, movie_id) VALUES ('Dante', 'first guy', '1901/04/05', 1);
INSERT INTO actors (name, character_name, date_of_birth, movie_id) VALUES ('Elphias', 'person', '1986/05/06', 1);
INSERT INTO actors (name, character_name, date_of_birth, movie_id) VALUES ('Fiona', 'lady', '1976/01/01', 1);
INSERT INTO actors (name, character_name, date_of_birth, movie_id) VALUES ('Gina', 'new lady','1975/02/01', 1);
INSERT INTO actors (name, character_name, date_of_birth, movie_id) VALUES ('Holley', 'new new lady', '1974/03/01', 1);
INSERT INTO actors (name, character_name, date_of_birth, movie_id) VALUES ('Izekiel', 'angel?', '1111/01/01', 1);
INSERT INTO actors (name, character_name, date_of_birth, movie_id) VALUES ('Jacque', 'french', '1982/01/24', 1);
INSERT INTO actors (name, character_name, date_of_birth, movie_id) VALUES ('Allen', 'this guy', '1988/02/03', 2);
INSERT INTO actors (name, character_name, date_of_birth, movie_id) VALUES ('Bruce', 'that guy', '1958/02/03', 2);
INSERT INTO actors (name, character_name, date_of_birth, movie_id) VALUES ('Chief','other guy', '1902/03/04', 2);
INSERT INTO actors (name, character_name, date_of_birth, movie_id) VALUES ('Dante', 'first guy', '1901/04/05', 2);
INSERT INTO actors (name, character_name, date_of_birth, movie_id) VALUES ('Elphias', 'person', '1986/05/06', 2);
INSERT INTO actors (name, character_name, date_of_birth, movie_id) VALUES ('Fiona', 'lady', '1976/01/01', 2);
INSERT INTO actors (name, character_name, date_of_birth, movie_id) VALUES ('Gina', 'new lady','1975/02/01', 2);
INSERT INTO actors (name, character_name, date_of_birth, movie_id) VALUES ('Holley', 'new new lady', '1974/03/01', 2);
INSERT INTO actors (name, character_name, date_of_birth, movie_id) VALUES ('Izekiel', 'angel?', '1111/01/01', 2);
INSERT INTO actors (name, character_name, date_of_birth, movie_id) VALUES ('Jacque', 'french', '1982/01/24', 2);
INSERT INTO actors (name, character_name, date_of_birth, movie_id) VALUES ('Allen', 'this guy', '1988/02/03', 3);
INSERT INTO actors (name, character_name, date_of_birth, movie_id) VALUES ('Bruce', 'that guy', '1958/02/03', 3);
INSERT INTO actors (name, character_name, date_of_birth, movie_id) VALUES ('Chief','other guy', '1902/03/04', 3);
INSERT INTO actors (name, character_name, date_of_birth, movie_id) VALUES ('Dante', 'first guy', '1901/04/05', 3);
INSERT INTO actors (name, character_name, date_of_birth, movie_id) VALUES ('Elphias', 'person', '1986/05/06', 3);
INSERT INTO actors (name, character_name, date_of_birth, movie_id) VALUES ('Fiona', 'lady', '1976/01/01', 3);
INSERT INTO actors (name, character_name, date_of_birth, movie_id) VALUES ('Gina', 'new lady','1975/02/01', 3);
INSERT INTO actors (name, character_name, date_of_birth, movie_id) VALUES ('Holley', 'new new lady', '1974/03/01', 3);
INSERT INTO actors (name, character_name, date_of_birth, movie_id) VALUES ('Izekiel', 'angel?', '1111/01/01', 3);
INSERT INTO actors (name, character_name, date_of_birth, movie_id) VALUES ('Jacque', 'french', '1982/01/24', 3);



-- Create a new column in the movie table to hold the MPAA rating. UPDATE 5 different movies to their correct rating


SELECT mpaa
FROM movies;

UPDATE movies
SET mpaa = 'G'
WHERE movieid = 1;

SELECT mpaa
FROM movies;

UPDATE movies
SET mpaa = 'PG'
WHERE movieid = 2;

SELECT mpaa
FROM movies;

UPDATE movies
SET mpaa = 'PG-13'
WHERE movieid = 3;

SELECT mpaa
FROM movies;

UPDATE movies
SET mpaa = 'R'
WHERE movieid = 4;

SELECT mpaa
FROM movies;

UPDATE movies
SET mpaa = 'R'
WHERE movieid = 5;



-- This is where I accidentally renamed all the movies in the file to Toy Story and
-- set all the ratings to G... Sooooo I'm going to turn it in as is and
-- ask you about it when I get back to my house.


