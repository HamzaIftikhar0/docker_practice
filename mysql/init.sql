-- This script sets up the 'movie_management' database and populates it with sample data.

-- Drop the database if it exists to ensure a clean state for a fresh setup.
DROP DATABASE IF EXISTS movie_management;

-- Create the new database.
CREATE DATABASE movie_management;

-- Switch to the newly created database. All subsequent commands will apply to this database.
USE movie_management;

-- 1. Base User Table
CREATE TABLE user (
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    age INT,
    email VARCHAR(100) NOT NULL UNIQUE,
    password VARCHAR(100) NOT NULL,
    preference ENUM('cinema', 'streaming', 'both') NOT NULL
);

-- 1a. Specialization: Viewer
CREATE TABLE viewer (
    user_id INT PRIMARY KEY,
    FOREIGN KEY (user_id) REFERENCES user(user_id) ON DELETE CASCADE
);

-- 1b. Specialization: Admin
CREATE TABLE admin (
    user_id INT PRIMARY KEY,
    FOREIGN KEY (user_id) REFERENCES user(user_id) ON DELETE CASCADE
);

-- 2. Movies Table
CREATE TABLE movies (
    movie_id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(100) NOT NULL,
    genre VARCHAR(50),
    release_date DATE,
    language VARCHAR(50),
    duration INT, -- Duration in minutes
    rating FLOAT
);

-- 3. Cinema Type Table (for pricing by type)
CREATE TABLE cinema_type (
    type_id INT PRIMARY KEY AUTO_INCREMENT,
    type_name ENUM('3D', 'IMAX', 'Normal') NOT NULL UNIQUE,
    price DECIMAL(6,2) NOT NULL
);

-- 4. Cinema Table
CREATE TABLE cinema (
    cinema_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    location VARCHAR(100),
    type_id INT,
    FOREIGN KEY (type_id) REFERENCES cinema_type(type_id) ON DELETE CASCADE
);

-- 5. Booking Table (Cinema Bookings)
CREATE TABLE booking (
    booking_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    cinema_id INT,
    movie_id INT,
    booking_date DATE,
    show_time TIME,
    seat_number VARCHAR(10),
    FOREIGN KEY (user_id) REFERENCES user(user_id) ON DELETE CASCADE,
    FOREIGN KEY (cinema_id) REFERENCES cinema(cinema_id) ON DELETE CASCADE,
    FOREIGN KEY (movie_id) REFERENCES movies(movie_id) ON DELETE CASCADE
);

-- 6. Streaming Platform Table
CREATE TABLE streaming_platform (
    platform_id INT PRIMARY KEY AUTO_INCREMENT,
    platform_name VARCHAR(100) NOT NULL UNIQUE,
    website TEXT
);

-- 7. Streaming Services Table (Movie availability on platforms)
CREATE TABLE streaming_services (
    streaming_id INT PRIMARY KEY AUTO_INCREMENT,
    movie_id INT,
    platform_id INT,
    price_720p DECIMAL(5,2),
    price_1080p DECIMAL(5,2),
    price_4k DECIMAL(5,2),
    FOREIGN KEY (movie_id) REFERENCES movies(movie_id) ON DELETE CASCADE,
    FOREIGN KEY (platform_id) REFERENCES streaming_platform(platform_id) ON DELETE CASCADE
);

-- 8. Subscription Table (User's streaming subscriptions)
CREATE TABLE subscription (
    subscription_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    platform_id INT,
    start_date DATE,
    end_date DATE,
    plan_type VARCHAR(50),
    FOREIGN KEY (user_id) REFERENCES user(user_id) ON DELETE CASCADE,
    FOREIGN KEY (platform_id) REFERENCES streaming_platform(platform_id) ON DELETE CASCADE
);

-- 9. Payments Table
CREATE TABLE payments (
    payment_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    amount DECIMAL(10, 2) NOT NULL,
    payment_method ENUM('Credit Card', 'Debit Card', 'PayPal', 'UPI', 'Wallet') NOT NULL,
    payment_date DATE NOT NULL,
    purpose VARCHAR(100) NOT NULL,
    FOREIGN KEY (user_id) REFERENCES user(user_id) ON DELETE CASCADE
);

-- 10. Recommendations Table
CREATE TABLE recommendations (
    recommendation_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    movie_id INT,
    reason TEXT,
    FOREIGN KEY (user_id) REFERENCES user(user_id) ON DELETE CASCADE,
    FOREIGN KEY (movie_id) REFERENCES movies(movie_id) ON DELETE CASCADE
);

--
-- Sample Data Insertion
--

-- Movies (50 entries)
INSERT INTO movies (title, genre, release_date, language, duration, rating) VALUES
('The Shawshank Redemption', 'Drama', '1994-09-23', 'English', 142, 9.3),
('The Godfather', 'Crime', '1972-03-24', 'English', 175, 9.2),
('The Dark Knight', 'Action', '2008-07-18', 'English', 152, 9.0),
('The Godfather Part II', 'Crime', '1974-12-20', 'English', 202, 9.0),
('12 Angry Men', 'Drama', '1957-04-10', 'English', 96, 9.0),
('Schindler''s List', 'Biography', '1994-02-04', 'English', 195, 9.0),
('The Lord of the Rings: The Return of the King', 'Fantasy', '2003-12-17', 'English', 201, 8.9),
('Pulp Fiction', 'Crime', '1994-10-14', 'English', 154, 8.9),
('The Good, the Bad and the Ugly', 'Western', '1966-12-23', 'Italian', 178, 8.8),
('Forrest Gump', 'Drama', '1994-07-06', 'English', 142, 8.8),
('Fight Club', 'Drama', '1999-10-15', 'English', 139, 8.8),
('Inception', 'Sci-Fi', '2010-07-16', 'English', 148, 8.8),
('The Matrix', 'Sci-Fi', '1999-03-31', 'English', 136, 8.7),
('Goodfellas', 'Crime', '1990-09-21', 'English', 146, 8.7),
('Star Wars: Episode V - The Empire Strikes Back', 'Sci-Fi', '1980-05-21', 'English', 124, 8.7),
('One Flew Over the Cuckoo''s Nest', 'Drama', '1975-11-19', 'English', 133, 8.7),
('The Lord of the Rings: The Fellowship of the Ring', 'Fantasy', '2001-12-19', 'English', 178, 8.8),
('Seven Samurai', 'Action', '1954-04-26', 'Japanese', 207, 8.6),
('The Silence of the Lambs', 'Thriller', '1991-02-14', 'English', 118, 8.6),
('Saving Private Ryan', 'War', '1998-07-24', 'English', 169, 8.6),
('Spirited Away', 'Animation', '2002-09-20', 'Japanese', 125, 8.6),
('City of God', 'Crime', '2002-08-30', 'Portuguese', 130, 8.6),
('Life Is Beautiful', 'Comedy', '1999-02-12', 'Italian', 116, 8.6),
('The Green Mile', 'Drama', '1999-12-10', 'English', 189, 8.6),
('Star Wars: Episode IV - A New Hope', 'Sci-Fi', '1977-05-25', 'English', 121, 8.6),
('Interstellar', 'Sci-Fi', '2014-11-07', 'English', 169, 8.6),
('The Usual Suspects', 'Crime', '1995-09-15', 'English', 106, 8.5),
('Back to the Future', 'Sci-Fi', '1985-07-03', 'English', 116, 8.5),
('Psycho', 'Thriller', '1960-09-08', 'English', 109, 8.5),
('American History X', 'Drama', '1998-10-30', 'English', 119, 8.5),
('Léon: The Professional', 'Action', '1994-11-18', 'English', 110, 8.5),
('Whiplash', 'Drama', '2014-10-15', 'English', 106, 8.5),
('Gladiator', 'Action', '2000-05-05', 'English', 155, 8.5),
('The Lion King', 'Animation', '1994-06-24', 'English', 88, 8.5),
('The Departed', 'Crime', '2006-10-06', 'English', 151, 8.5),
('Dune', 'Sci-Fi', '2021-10-22', 'English', 155, 8.0),
('Parasite', 'Thriller', '2019-05-30', 'Korean', 132, 8.6),
('Joker', 'Crime', '2019-10-04', 'English', 122, 8.4),
('Spider-Man: Into the Spider-Verse', 'Animation', '2018-12-14', 'English', 117, 8.4),
('Once Upon a Time in the West', 'Western', '1969-12-21', 'English', 165, 8.5),
('The Pianist', 'Biography', '2002-09-06', 'English', 150, 8.5),
('Terminator 2: Judgment Day', 'Sci-Fi', '1991-07-03', 'English', 137, 8.6),
('The Shining', 'Horror', '1980-05-23', 'English', 146, 8.4),
('Inglourious Basterds', 'War', '2009-08-21', 'English', 153, 8.3),
('Toy Story', 'Animation', '1995-11-22', 'English', 81, 8.3),
('Alien', 'Sci-Fi', '1979-05-25', 'English', 117, 8.5),
('The Grand Budapest Hotel', 'Comedy', '2014-03-28', 'English', 99, 8.1),
('Django Unchained', 'Western', '2012-12-25', 'English', 165, 8.4),
('Coco', 'Animation', '2017-11-22', 'English', 105, 8.4),
('Mad Max: Fury Road', 'Action', '2015-05-15', 'English', 120, 8.1);

-- Cinema Types (3 entries)
INSERT INTO cinema_type (type_name, price) VALUES
('3D', 15.50),
('IMAX', 20.00),
('Normal', 12.00);

-- Cinemas (3 entries)
INSERT INTO cinema (name, location, type_id) VALUES
('City Cinemas', 'New York', 3), -- Normal
('Grand IMAX', 'Los Angeles', 2), -- IMAX
('Cinema Vue', 'London', 1); -- 3D

-- Streaming Platforms (3 entries)
INSERT INTO streaming_platform (platform_name, website) VALUES
('Netflix', 'https://www.netflix.com'),
('Hulu', 'https://www.hulu.com'),
('Prime Video', 'https://www.primevideo.com');

-- Streaming Services (3 entries)
INSERT INTO streaming_services (movie_id, platform_id, price_720p, price_1080p, price_4k) VALUES
(2, 1, 3.99, 5.99, 7.99), -- The Godfather on Netflix
(3, 2, NULL, 4.99, 6.99), -- The Dark Knight on Hulu
(4, 3, 3.50, 5.00, 7.00); -- The Godfather Part II on Prime Video
