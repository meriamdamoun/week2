-- PART I

CREATE TABLE Customer (
    customer_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL
);

CREATE TABLE CustomerProfile (
    id SERIAL PRIMARY KEY,
    isLoggedIn BOOLEAN DEFAULT FALSE,
    customer_id INTEGER ,
	foreign key (customer_id) REFERENCES Customer(customer_id) ON DELETE CASCADE
);

INSERT INTO Customer (first_name, last_name) VALUES 
('John', 'Doe'),
('Jerome', 'Lalu'),
('Lea', 'Rive');

INSERT INTO CustomerProfile (isLoggedIn, customer_id)
VALUES 
(TRUE, (SELECT customer_id FROM Customer WHERE first_name = 'John' AND last_name = 'Doe')),
(FALSE, (SELECT customer_id FROM Customer WHERE first_name = 'Jerome' AND last_name = 'Lalu'));


SELECT c.first_name 
FROM Customer c
JOIN CustomerProfile cp ON c.customer_id = cp.customer_id
WHERE cp.isLoggedIn = TRUE;

SELECT c.first_name, COALESCE(cp.isLoggedIn, FALSE) AS isLoggedIn
FROM Customer c
LEFT JOIN CustomerProfile cp ON c.customer_id = cp.customer_id;


SELECT COUNT(*) AS not_logged_in_customers
FROM Customer c
LEFT JOIN CustomerProfile cp ON c.customer_id = cp.customer_id
WHERE cp.isLoggedIn = FALSE OR cp.isLoggedIn IS NULL;


SELECT c.first_name, COALESCE(cp.isLoggedIn, FALSE) AS isLoggedIn
FROM Customer c
LEFT JOIN CustomerProfile cp ON c.customer_id = cp.customer_id;


SELECT COUNT(*) AS not_logged_in_customers
FROM Customer c
LEFT JOIN CustomerProfile cp ON c.customer_id = cp.customer_id
WHERE cp.isLoggedIn = FALSE OR cp.isLoggedIn IS NULL;

-- PART II

CREATE TABLE Book (
    book_id SERIAL PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    author VARCHAR(255) NOT NULL
);

INSERT INTO Book (title, author) VALUES 
('Alice In Wonderland', 'Lewis Carroll'),
('Harry Potter', 'J.K Rowling'),
('To Kill a Mockingbird', 'Harper Lee');


CREATE TABLE Student (
    student_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE,
    age INT CHECK (age <= 15) -- Ensures age is never greater than 15
);


INSERT INTO Student (name, age) VALUES 
('John', 12),
('Lera', 11),
('Patrick', 10),
('Bob', 14);

CREATE TABLE Library (
    book_fk_id INT REFERENCES Book(book_id) ON DELETE CASCADE ON UPDATE CASCADE,
    student_fk_id INT REFERENCES Student(student_id) ON DELETE CASCADE ON UPDATE CASCADE,
    borrowed_date DATE NOT NULL,
    PRIMARY KEY (book_fk_id, student_fk_id) -- Composite Primary Key
);


INSERT INTO Library (book_fk_id, student_fk_id, borrowed_date)
VALUES 
((SELECT book_id FROM Book WHERE title = 'Alice In Wonderland'),
 (SELECT student_id FROM Student WHERE name = 'John'),
 '2022-02-15'),

((SELECT book_id FROM Book WHERE title = 'To Kill a Mockingbird'),
 (SELECT student_id FROM Student WHERE name = 'Bob'),
 '2021-03-03'),

((SELECT book_id FROM Book WHERE title = 'Alice In Wonderland'),
 (SELECT student_id FROM Student WHERE name = 'Lera'),
 '2021-05-23'),

((SELECT book_id FROM Book WHERE title = 'Harry Potter'),
 (SELECT student_id FROM Student WHERE name = 'Bob'),
 '2021-08-12');


 SELECT * FROM Library;


SELECT s.name AS student_name, b.title AS book_title
FROM Library l
JOIN Student s ON l.student_fk_id = s.student_id
JOIN Book b ON l.book_fk_id = b.book_id;


SELECT AVG(s.age) AS average_age
FROM Library l
JOIN Student s ON l.student_fk_id = s.student_id
JOIN Book b ON l.book_fk_id = b.book_id
WHERE b.title = 'Alice In Wonderland';

DELETE FROM Student WHERE name = 'John';

SELECT * FROM Library;
