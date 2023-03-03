-- CREATE DATABASE record_company;

-- ==================================================================================================================

-- DROP DATABASE record_company;

-- ==================================================================================================================

-- USE record_company;

-- ==================================================================================================================

-- CREATE TABLE test (
-- 	test_column INT
-- );

-- ==================================================================================================================

-- ALTER TABLE test
-- ADD another_column VARCHAR(255);

-- ==================================================================================================================

-- DROP TABLE test;

-- ==================================================================================================================

-- CREATE TABLE bands (
-- 	id INT NOT NULL AUTO_INCREMENT,
-- 	name VARCHAR(255) NOT NULL,
--     PRIMARY KEY (id)
-- );

-- ==================================================================================================================

-- CREATE TABLE albums (
-- 	id INT NOT NULL AUTO_INCREMENT,
--     name VARCHAR(255) NOT NULL,
--     release_year INT,
--     band_id INT NOT NULL,
--     PRIMARY KEY (id),
--     FOREIGN KEY (band_id) REFERENCES bands(id)
-- );

-- ==================================================================================================================

-- INSERT INTO bands (name)
-- VALUES ('Iron Maidens');

-- ==================================================================================================================

-- INSERT INTO bands (name)
-- VALUES ('Deuce'), ('Avenge Sevenfold'), ('Ankor');

-- ==================================================================================================================

-- SELECT * FROM bands;

-- ==================================================================================================================

-- SELECT * FROM bands LIMIT 2;

-- ==================================================================================================================

-- SELECT name FROM bands;

-- ==================================================================================================================

-- SELECT id AS 'ID', name AS 'Band Name'
-- FROM bands;

-- ==================================================================================================================

-- SELECT * FROM bands ORDER BY name ASC; #DESC

-- ==================================================================================================================

-- INSERT INTO albums (name, release_year, band_id)
-- VALUES ('The Number of the Beasts', 1985, 1),
-- 	('Power Slave', 1984, 1),
--     ('Nightmare', 2018, 2),
--     ('Nightmare', 2010, 3),
--     ('Test Album', NULL, 3);

-- ==================================================================================================================

-- SELECT * FROM albums;

-- ==================================================================================================================

-- SELECT name FROM albums;

-- ==================================================================================================================

-- SELECT DISTINCT name FROM albums;

-- ==================================================================================================================

-- UPDATE albums 
-- SET release_year = 1982
-- WHERE id = 1;

-- ==================================================================================================================

-- SELECT * FROM albums
-- WHERE release_year < 2000;

-- ==================================================================================================================

-- SELECT * FROM albums
-- WHERE name LIKE '%er%' OR band_id = 2;

-- ==================================================================================================================

-- SELECT * FROM albums
-- WHERE release_year = 1984 AND band_id = 1;

-- ==================================================================================================================

-- SELECT * FROM albums
-- WHERE release_year BETWEEN 2000 AND 2018;

-- ==================================================================================================================

-- SELECT * FROM albums
-- WHERE release_year IS NULL;

-- ==================================================================================================================

-- DELETE FROM albums WHERE id = 5;

-- ==================================================================================================================

-- SELECT * FROM albums;

-- ==================================================================================================================

-- SELECT * FROM bands
-- INNER JOIN albums ON bands.id = albums.band_id;

-- ==================================================================================================================

-- SELECT * FROM bands
-- LEFT JOIN albums ON bands.id = albums.band_id;

-- ==================================================================================================================

-- SELECT * FROM albums
-- RIGHT JOIN bands ON bands.id = albums.band_id;

-- ==================================================================================================================

-- SELECT AVG(release_year) FROM albums;

-- ==================================================================================================================

-- SELECT SUM(release_year) FROM albums;

-- ==================================================================================================================

-- SELECT band_id, COUNT(band_id) FROM albums GROUP BY band_id;

-- ==================================================================================================================

-- SELECT b.name AS band_name, COUNT(a.id) AS num_albums
-- FROM bands AS b
-- LEFT JOIN albums AS a ON b.id = a.band_id
-- WHERE b.name = 'Deuce'
-- GROUP BY b.id
-- HAVING num_albums = 1; 

-- ==================================================================================================================
-- 													EXERCISES
-- ==================================================================================================================
-- 1) Create songs table
  
-- CREATE TABLE songs (
-- 	id INT NOT NULL AUTO_INCREMENT,
--     name VARCHAR(255) NOT NULL,
--     length FLOAT NOT NULL,
--     album_id INT NOT NULL,
--     PRIMARY KEY (id),
--     FOREIGN KEY (album_id) REFERENCES albums(id)
-- );

-- ==================================================================================================================
-- 2) Select only the names of all the bands

-- SELECT name AS 'Band Name' FROM bands;

-- ==================================================================================================================
-- 3) Select the oldest Album

-- SELECT * FROM albums
-- WHERE release_year IS NOT NULL
-- ORDER BY release_year ASC
-- LIMIT 1;

-- ==================================================================================================================
-- 4) Get all bands that have Albums

-- SELECT DISTINCT bands.name AS 'Band Name' FROM bands
-- JOIN albums ON bands.id = albums.band_id;

-- ==================================================================================================================
-- 5) Get all bands that have no Albums

-- SELECT *
-- FROM bands
-- LEFT JOIN albums ON bands.id = albums.band_id;

-- 

-- SELECT bands.name AS 'Band Name' 
-- FROM bands
-- LEFT JOIN albums ON bands.id = albums.band_id
-- GROUP BY bands.name
-- HAVING count(albums.id) = 0;

-- ==================================================================================================================
-- 6) Get longest Album

-- SELECT 
-- 	albums. name AS Name,
--     albums.release_year AS 'Release Year',
--     SUM(songs.length) AS 'Duration'
-- FROM albums
-- JOIN songs ON albums.id = songs.album_id
-- GROUP BY songs.album_id
-- ORDER BY Duration DESC
-- LIMIT 1;

-- ==================================================================================================================
-- 7) Update the Release Year of the Album with no Release Year

-- SELECT * FROM albums
-- WHERE release_year IS NULL;

-- UPDATE albums 
-- SET release_year = 1986
-- WHERE id = 4;

-- ==================================================================================================================
-- 8) Insert a record for your favorite Band and one of their Albums

-- INSERT INTO bands (name)
-- VALUES ('Haken');

-- SELECT * FROM albums
-- ORDER by id DESC
-- LIMIT 1;

-- INSERT INTO albums (name, release_year, band_id)
-- VALUES ('Vector', 2018, 8);

-- ==================================================================================================================
-- 9) Delete Band and Album you added in #8

-- DELETE FROM albums 
-- WHERE id = 19;

-- DELETE FROM bands 
-- WHERE id = 8;

-- SELECT * FROM albums;

-- SELECT * FROM bands;

-- ==================================================================================================================
-- 10) Get the Average Length of all Songs

-- SELECT AVG(length) AS 'Average Length'
-- FROM songs;

-- ==================================================================================================================
-- 11) Select the longest song of each Album

-- SELECT 
-- 	albums.name AS 'Album',
--     albums.release_year AS 'Release Year',
--     MAX(songs.length) AS 'Duration'
-- FROM albums
-- JOIN songs ON albums.id = songs.album_id
-- GROUP BY songs.album_id;

-- ==================================================================================================================
-- 12) Get the number of songs for each Band

-- SELECT 
-- 	bands.name AS 'Band',
--     COUNT(songs.id) AS 'Number of Songs'
-- FROM bands
-- join albums ON bands.id = albums.band_id
-- JOIN songs ON albums.id = songs.album_id
-- GROUP BY bands.id;
