CREATE DATABASE movie_Tracker_Project;
USE movie_Tracker_Project;

CREATE TABLE Movies (
    movie_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(70) NOT NULL,
    release_year INT ,
    director VARCHAR (80)
);
INSERT INTO Movies (title, release_year, director) VALUES 
('Inception', 2010, 'Christopher Nolan'),
('The Dark Knight', 2008, 'Christopher Nolan'),
('Forrest Gump', 1994, 'Robert Zemeckis'),
('Interstellar', 2014, 'Christopher Nolan'),
('True Love',2000,'Princess Kareevl'),
('Fighter High',2012,'The fighter jut story'),
('Gamer Griling',2017,'Vedio gaming fear');
SELECT*FROM Movies;
-- Genres Table
CREATE TABLE Genres (
    genre_id INT PRIMARY KEY AUTO_INCREMENT,
    genre_name VARCHAR(50) NOT NULL
);
INSERT INTO Genres (genre_name) VALUES 
('Action'),
('Drama'),
('Sci-Fi'),
('Adventure'),
('Fiction');

-- Movie_Genres Table
CREATE TABLE Movie_Genres (
    movie_id INT,
    genre_id INT,
    PRIMARY KEY (movie_id, genre_id),
    FOREIGN KEY (movie_id) REFERENCES Movies(movie_id),
    FOREIGN KEY (genre_id) REFERENCES Genres(genre_id)
);
INSERT INTO Movie_Genres (movie_id, genre_id) VALUES 
(1, 3), 
(1, 4),
(2, 1), 
(2, 4), 
(3, 2), 
(4, 3), 
(4, 4); 

--Ratings Table
CREATE TABLE Ratings (
    rating_id INT PRIMARY KEY AUTO_INCREMENT,
    movie_id INT,
    rating DECIMAL(3, 1), 
    rating_date DATE,
    FOREIGN KEY (movie_id) REFERENCES Movies(movie_id)
);

INSERT INTO Ratings (movie_id, rating, rating_date) VALUES 
(1, 9.0, '2024-10-01'), 
(2, 8.5, '2024-10-10'), 
(3, 9.5, '2024-10-15'), 
(4, 8.8, '2024-10-20'); 

--List All Movies with Their Ratings
SELECT m.title, m.release_year, r.rating
FROM Movies m
JOIN Ratings r ON m.movie_id = r.movie_id;

-- Find the Top-Rated Movies
SELECT m.title, m.release_year, r.rating
FROM Movies m
JOIN Ratings r ON m.movie_id = r.movie_id
ORDER BY r.rating DESC
LIMIT 5;

--List All Genres for a Specific Movie
SELECT m.title, g.genre_name
FROM Movies m
JOIN Movie_Genres mg ON m.movie_id = mg.movie_id
JOIN Genres g ON mg.genre_id = g.genre_id
WHERE m.title = 'Inception';

--Find Your Top-Rated Genre
SELECT g.genre_name, AVG(r.rating) AS avg_rating
FROM Ratings r
JOIN Movie_Genres mg ON r.movie_id = mg.movie_id
JOIN Genres g ON mg.genre_id = g.genre_id
GROUP BY g.genre_id
ORDER BY avg_rating DESC
LIMIT 1;

--List Movies Watched by Genre
SELECT g.genre_name, m.title, r.rating
FROM Genres g
JOIN Movie_Genres mg ON g.genre_id = mg.genre_id
JOIN Movies m ON mg.movie_id = m.movie_id
JOIN Ratings r ON m.movie_id = r.movie_id
ORDER BY g.genre_name;

--Get Average Rating Per Director
SELECT m.director, AVG(r.rating) AS avg_rating
FROM Movies m
JOIN Ratings r ON m.movie_id = r.movie_id
GROUP BY m.director
ORDER BY avg_rating DESC;

--List Movies by Release Year
SELECT title, release_year
FROM Movies
ORDER BY release_year DESC;

-- Count the Total Number of Movies Watched
SELECT COUNT(*) AS total_movies_watched
FROM Ratings;

--Find All Movies with a Rating Above 8
SELECT m.title, m.release_year, r.rating
FROM Movies m
JOIN Ratings r ON m.movie_id = r.movie_id
WHERE r.rating > 8;

--Find Movies from a Specific Director
SELECT title, release_year
FROM Movies
WHERE director = 'Christopher Nolan';

--Get the Average Rating of a Specific Movie
SELECT m.title, AVG(r.rating) AS avg_rating
FROM Movies m
JOIN Ratings r ON m.movie_id = r.movie_id
WHERE m.title = 'Inception'
GROUP BY m.movie_id;

--List Movies of a Specific Genre with Ratings
SELECT m.title, r.rating
FROM Movies m
JOIN Movie_Genres mg ON m.movie_id = mg.movie_id
JOIN Genres g ON mg.genre_id = g.genre_id
JOIN Ratings r ON m.movie_id = r.movie_id
WHERE g.genre_name = 'Action';

--Find the Most Rated Genre
SELECT g.genre_name, COUNT(mg.movie_id) AS total_movies_in_genre
FROM Genres g
JOIN Movie_Genres mg ON g.genre_id = mg.genre_id
GROUP BY g.genre_name
ORDER BY total_movies_in_genre DESC
LIMIT 1;

--List All Genres You Have Watched
SELECT DISTINCT g.genre_name
FROM Genres g
JOIN Movie_Genres mg ON g.genre_id = mg.genre_id
JOIN Ratings r ON mg.movie_id = r.movie_id;

--Movies You Rated Above 9.0 and Their Genres
SELECT m.title, r.rating, g.genre_name
FROM Movies m
JOIN Ratings r ON m.movie_id = r.movie_id
JOIN Movie_Genres mg ON m.movie_id = mg.movie_id
JOIN Genres g ON mg.genre_id = g.genre_id
WHERE r.rating > 9.0;

--List All Movies with Their Release Year and Rating
SELECT m.title, m.release_year, r.rating
FROM Movies m
JOIN Ratings r ON m.movie_id = r.movie_id
ORDER BY m.release_year DESC;

--Find Movies Watched in the Last 30 Days
SELECT m.title, r.rating, r.rating_date
FROM Movies m
JOIN Ratings r ON m.movie_id = r.movie_id
WHERE r.rating_date >= CURDATE() - INTERVAL 30 DAY;

--Movies You Haven't Watched (Not Rated Yet)
SELECT m.title
FROM Movies m
LEFT JOIN Ratings r ON m.movie_id = r.movie_id
WHERE r.rating IS NULL;

--Movies in a Specific Genre You Have Not Watched
SELECT m.title
FROM Movies m
JOIN Movie_Genres mg ON m.movie_id = mg.movie_id
JOIN Genres g ON mg.genre_id = g.genre_id
LEFT JOIN Ratings r ON m.movie_id = r.movie_id
WHERE g.genre_name = 'Sci-Fi' AND r.rating IS NULL;