-- Library Management System --
show databases;
use vedika;
CREATE TABLE Books(
    book_id INT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    author VARCHAR(255) NOT NULL,
    genre VARCHAR(100),
    publication_year INT,
    available_copies INT
);

-- Creating the Members table
CREATE TABLE Members (
    member_id INT PRIMARY KEY,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    email VARCHAR(255) NOT NULL,
    phone VARCHAR(20)
);
-- Creating the Loans table
CREATE TABLE Loans (
    loan_id INT PRIMARY KEY,
    member_id INT,
    book_id INT,
    loan_date DATE,
    due_date DATE,
    returned BOOLEAN,
    FOREIGN KEY (member_id) REFERENCES Members(member_id),
    FOREIGN KEY (book_id) REFERENCES Books(book_id)
);
INSERT INTO Books (book_id, title, author, genre, publication_year, available_copies)
VALUES
(1, 'The Hound of the Baskervilles', 'Arthur Conan Doyle', 'Mystery', 1902, 8),
(2, 'Gone Girl', 'Gillian Flynn', 'Mystery', 2012, 5),
(3, 'To Kill a Mockingbird', 'Harper Lee', 'Fiction', 1960, 12),
(4, '1984', 'George Orwell', 'Dystopian', 1949, 4),
(5, 'Pride and Prejudice', 'Jane Austen', 'Romance', 1813, 7);
select * from Books;
INSERT INTO Members (member_id, first_name, last_name, email, phone)
VALUES
(1, 'John', 'Doe', 'john.doe@example.com', '123-456-7890'),
(2, 'Jane', 'Smith', 'jane.smith@example.com', '234-567-8901'),
(3, 'Alice', 'Johnson', 'alice.johnson@example.com', '345-678-9012'),
(4, 'Bob', 'Brown', 'bob.brown@example.com', '456-789-0123'),
(5, 'Charlie', 'Davis', 'charlie.davis@example.com', '567-890-1234');
select * from Members;
INSERT INTO Loans (loan_id, member_id, book_id, loan_date, due_date, returned)
VALUES
(1, 1, 1, '2025-01-10', '2025-01-20', 0),
(2, 2, 2, '2025-01-12', '2025-01-22', 1),
(3, 3, 3, '2025-01-15', '2025-01-25', 0),
(4, 4, 4, '2025-01-17', '2025-01-27', 1),
(5, 5, 5, '2025-01-20', '2025-01-30', 0);
select * from Loans;

select title,author, genre from Books where  genre='Mystery';

SELECT m.first_name, m.last_name, m.email, m.phone FROM Members m
JOIN Loans l ON m.member_id = l.member_id WHERE l.due_date < CURDATE() AND l.returned = 0;

SELECT m.member_id, m.first_name, m.last_name, COUNT(l.loan_id) AS total_books_borrowed
FROM Members m JOIN Loans l ON m.member_id = l.member_id GROUP BY m.member_id, m.first_name, m.last_name;

update Loans set returned = 1 where book_id=book_id and member_id=member_id;

SELECT title, author, available_copies FROM Books WHERE available_copies < 5;

SELECT DISTINCT m.first_name, m.last_name FROM Members m JOIN Loans l ON m.member_id = l.member_id
JOIN Books b ON l.book_id = b.book_id WHERE b.author = '[specific_author]';

SELECT b.title, b.author, COUNT(l.loan_id) AS times_borrowed FROM Books b JOIN Loans l ON b.book_id = l.book_id
GROUP BY b.title, b.author ORDER BY times_borrowed DESC;

SELECT m.first_name, m.last_name, COUNT(l.loan_id) AS overdue_books FROM Members m
JOIN Loans l ON m.member_id = l.member_id WHERE l.due_date < CURDATE() AND l.returned = 0
GROUP BY m.first_name, m.last_name ORDER BY overdue_books DESC LIMIT 1;

SELECT COUNT(*) AS active_loans FROM Loans WHERE returned = 0;

SELECT AVG(DATEDIFF(returned, loan_date)) AS average_loan_duration FROM Loans WHERE returned = 1;