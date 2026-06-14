DROP TABLE IF EXISTS Bookings;
DROP TABLE IF EXISTS Matches;
DROP TABLE IF EXISTS Users;

-- =========================================================================
-- 1. CREATE USERS TABLE
-- =========================================================================
CREATE TABLE Users (
    user_id INT PRIMARY KEY,
    full_name VARCHAR(100),
    email VARCHAR(100) UNIQUE,
    role VARCHAR(30),
    phone_number VARCHAR(20)
);

-- =========================================================================
-- 2. CREATE MATCHES TABLE
-- =========================================================================
CREATE TABLE Matches (
    match_id INT PRIMARY KEY,
    fixture VARCHAR(150),
    tournament_category VARCHAR(50),
    base_ticket_price DECIMAL(10,2),
    match_status VARCHAR(30),
    CHECK (base_ticket_price >= 0)
);

-- =========================================================================
-- 3. CREATE BOOKINGS TABLE
-- =========================================================================
CREATE TABLE Bookings (
    booking_id INT PRIMARY KEY,
    user_id INT,
    match_id INT,
    seat_number VARCHAR(20),
    payment_status VARCHAR(20),
    total_cost DECIMAL(10,2),
    FOREIGN KEY (user_id) REFERENCES Users(user_id),
    FOREIGN KEY (match_id) REFERENCES Matches(match_id),
    CHECK (total_cost >= 0)
);

-- =========================================================================
-- DATA SEEDING: INSERT SAMPLE DATA INTO USERS
-- =========================================================================
INSERT INTO Users (user_id, full_name, email, role, phone_number) VALUES
(1, 'Tanvir Rahman', 'tanvir@mail.com', 'Football Fan', '+8801711111111'),
(2, 'Asif Haque', 'asif@mail.com', 'Football Fan', '+8801722222222'),
(3, 'Sajjad Rahman', 'sajjad@mail.com', 'Ticket Manager', '+8801733333333'),
(4, 'Jannat Ara', 'jannat@mail.com', 'Football Fan', NULL);

-- =========================================================================
-- DATA SEEDING: INSERT SAMPLE DATA INTO MATCHES
-- =========================================================================
INSERT INTO Matches (match_id, fixture, tournament_category, base_ticket_price, match_status) VALUES
(101, 'Real Madrid vs Barcelona', 'Champions League', 150, 'Available'),
(102, 'Man City vs Liverpool', 'Premier League', 120, 'Selling Fast'),
(103, 'Bayern Munich vs PSG', 'Champions League', 130, 'Available'),
(104, 'AC Milan vs Inter Milan', 'Serie A', 90, 'Sold Out'),
(105, 'Juventus vs Roma', 'Serie A', 80, 'Available');

-- =========================================================================
-- DATA SEEDING: INSERT SAMPLE DATA INTO BOOKINGS
-- =========================================================================
INSERT INTO Bookings (booking_id, user_id, match_id, seat_number, payment_status, total_cost) VALUES
(501, 1, 101, 'A-12', 'Confirmed', 150.00),
(502, 1, 102, 'B-04', 'Confirmed', 120.00),
(503, 2, 101, 'A-13', 'Confirmed', 150.00),
(504, 2, 101, NULL, NULL, 150.00),
(505, 3, 102, 'C-20', 'Pending', 120.00);

-- Query 1: Retrieve all available Champions League matches with required fields
SELECT 
    match_id,
    fixture,
    round(base_ticket_price) as base_ticket_price
FROM Matches
WHERE tournament_category = 'Champions League'
AND match_status = 'Available';

-- Query 2: Find users whose full names start with 'Tanvir' or contain 'Haque' (case-insensitive)
SELECT 
    user_id,
    full_name,
    email
FROM Users
WHERE full_name ILIKE 'Tanvir%' OR full_name ILIKE '%Haque%';  

-- Query 3: Show bookings where payment_status is NULL Replace NULL with 'Action Required' using COALESCE
SELECT 
    booking_id,
    user_id,
    match_id,
    COALESCE(payment_status, 'Action Required') AS systematic_status
FROM Bookings
WHERE payment_status IS NULL;

-- Query 4: Retrieve booking details with user name and match fixture using INNER JOIN
SELECT 
    b.booking_id,
    u.full_name,
    m.fixture,
    round(b.total_cost) as total_cost
FROM Bookings as b
INNER JOIN Users as u ON b.user_id = u.user_id
INNER JOIN Matches as m ON b.match_id = m.match_id;

-- Query 5: Display all users and their booking IDs Include users even if they have no bookings (LEFT JOIN)
SELECT 
    u.user_id,
    u.full_name,
    b.booking_id
FROM Users as u
LEFT JOIN Bookings as b ON u.user_id = b.user_id
ORDER BY u.user_id;


-- Query 6: Find bookings where total_cost is higher than average booking cost
SELECT 
    booking_id,
    match_id,
    round(total_cost) as total_cost
FROM Bookings
WHERE total_cost > (SELECT AVG(total_cost) FROM Bookings);


-- Query 7: Retrieve top 2 most expensive matchesSkip the highest priced match using OFFSET
SELECT 
    match_id,
    fixture,
    round(base_ticket_price) as base_ticket_price
FROM Matches
ORDER BY base_ticket_price DESC OFFSET 1 LIMIT 2;

