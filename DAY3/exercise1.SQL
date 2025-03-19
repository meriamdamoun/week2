select * from language	
select * from  film

SELECT film.title, film.description, language.name AS language_name
FROM film
INNER JOIN language
ON language.language_id = film.language_id

SELECT film.title, film.description, language.name AS language_name
FROM film
left join language
ON language.language_id = film.language_id

CREATE TABLE new_film (
    id SERIAL PRIMARY KEY, 
    name VARCHAR(100) NOT NULL
);

INSERT INTO new_film (name) VALUES
('Mickey 17'),
('The Gorge'),
('Jurassic World: Rebirth'),
('Mission: Impossible - The Final Reckoning'),
('Back in Action');

SELECT * FROM new_film

CREATE TABLE customer_review (
    review_id SERIAL PRIMARY KEY, 
    name VARCHAR(100) NOT NULL,
	title VARCHAR(150) NOT NULL,
	score INTEGER CHECK(score >= 1 and score <= 10)NOT NULL,
	review_text TEXT NOT NULL,
	last_update TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	film_id INTEGER NOT NULL,
	language_id INTEGER NOT NULL,
	FOREIGN KEY(film_id) references new_film(id) ON DELETE CASCADE,
	FOREIGN KEY(language_id) references language(language_id) ON DELETE CASCADE
)


INSERT INTO customer_review (name, title, score, review_text, film_id, language_id)
VALUES ('Meriam Damoun', 'An Amazing Cinematic Experience', 9, 'This movie was fantastic! The acting, direction, and cinematography were all top-notch. Highly recommended.', 5,1 );
INSERT INTO customer_review (name, title, score, review_text, film_id, language_id)
VALUES ( 'Yassin Damoun','A Heartwarming Story', 8,'This film touched my heart. The characters were well-developed, and the story was beautifully told.',2,2);

SELECT * FROM customer_review 

DELETE FROM new_film WHERE id=2
-- the review was deleted to 



