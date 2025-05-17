create database project;
use project;
-- Users table 
CREATE TABLE Users (
    user_id int primary key auto_increment,
    username varchar(50) not null unique,
    email varchar(100) not null unique,
    bio text,
    password varchar(255) not null,
    created_at timestamp default current_timestamp
);
-- Users table give the data by user input
INSERT INTO Users (username, email, bio, password) VALUES
('alice', 'alice@example.com', 'Nature lover 🌿 | Coffee addict ☕', 'password123'),
('bob', 'bob@example.com', 'Tech geek 🤖 | Gamer 🎮', 'bobsecure456'),
('charlie', 'charlie@example.com', 'Photographer 📸 | Traveler 🌍', 'charliepass789'),
('daisy', 'daisy@example.com', 'Foodie 🍕 | Blogger ✍️', 'daisypass321'),
('eve', 'eve@example.com', 'Fitness enthusiast 💪 | Dog mom 🐶', 'evepass999');


-- Posts table 
CREATE TABLE Posts (
    post_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,
    image_url VARCHAR(255),
    caption TEXT,
    posted_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);
-- Postes table give the data by user input
INSERT INTO Posts (user_id, image_url, caption)
VALUES 
(1, 'https://example.com/images/post1.jpg', 'Sunset at the beach 🌅'),
(2, 'https://example.com/images/post2.jpg', 'My new puppy! 🐶'),
(3, 'https://example.com/images/post3.jpg', 'Throwback to last summer ☀️'),
(1, 'https://example.com/images/post4.jpg', 'Early morning hike 🥾⛰️'),
(4, 'https://example.com/images/post5.jpg', 'Homemade pasta night 🍝'),
(2, 'https://example.com/images/post6.jpg', 'Reading by the fireplace 📚🔥');


-- Likes table 
CREATE TABLE Likes (
    like_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,
    post_id INT NOT NULL,
    liked_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES Users(user_id),
    FOREIGN KEY (post_id) REFERENCES Posts(post_id),
    UNIQUE (user_id, post_id) -- prevent multiple likes on the same post
);
-- Likes table give the data by user input
INSERT INTO Likes (user_id, post_id)
VALUES
(1, 2),
(2, 1),
(3, 1),
(4, 3),
(1, 3),
(2, 4),
(3, 5),
(4, 6),
(1, 5),
(2, 3);

-- Followers Table
CREATE TABLE Followers (
    follower_id INT NOT NULL,
    following_id INT NOT NULL,
    followed_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (follower_id, following_id),
    FOREIGN KEY (follower_id) REFERENCES Users(user_id),
    FOREIGN KEY (following_id) REFERENCES Users(user_id)
);
-- Followers table give the data by user input
INSERT INTO Followers (follower_id, following_id) VALUES
(2, 1),
(3, 1),
(1, 2),
(4, 3),
(1, 3);

-- Comment table
CREATE TABLE Comments (
    comment_id INT PRIMARY KEY AUTO_INCREMENT,
    post_id INT,
    user_id INT,
    comment TEXT,
    commented_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (post_id) REFERENCES Posts(post_id),
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);
-- Comments table give the data by user input
INSERT INTO Comments (post_id, user_id, comment) VALUES
(1, 2, 'Beautiful view!'),
(1, 3, 'Stunning photo!'),
(2, 1, 'That looks fun!'),
(2, 3, 'Great angle!'),
(1, 1, 'Thank you all!');

-- 1. Retrieve all posts with user info
SELECT p.post_id, p.caption, p.image_url, p.posted_at, u.username, u.email
FROM Posts p
JOIN Users u ON p.user_id = u.user_id;

 -- 2. Find the most liked posts
SELECT p.post_id, p.caption, COUNT(l.user_id) AS total_likes
FROM Posts p
LEFT JOIN Likes l ON p.post_id = l.post_id
GROUP BY p.post_id
ORDER BY total_likes DESC
LIMIT 5;

-- 3. Get total likes per post
SELECT post_id, COUNT(user_id) AS like_count
FROM Likes
GROUP BY post_id;

-- 4. Find popular users (most followers)
SELECT u.username, COUNT(f.follower_id) AS follower_count
FROM Users u
LEFT JOIN Followers f ON u.user_id = f.following_id
GROUP BY u.user_id
ORDER BY follower_count DESC;

--  5. Find mutual followers between two users
SELECT f1.follower_id
FROM Followers f1
JOIN Followers f2 ON f1.follower_id = f2.follower_id
WHERE f1.following_id = 1 AND f2.following_id = 2;

-- 6. Update user profile
UPDATE Users
SET bio = 'Nature lover and traveler'
WHERE user_id = 2;

--  7. Update post caption
UPDATE Posts
SET caption = 'Updated caption for this amazing view!'
WHERE post_id = 1;

-- 8. Delete a post
DELETE FROM Posts
WHERE post_id = 2;

--9. Unfollow a user
DELETE FROM Followers
WHERE follower_id = 3 AND following_id = 1;

-- Using JOINs, GROUP BY, COUNT, and Subqueries

-- JOIN: Retrieve all posts with user info
SELECT p.post_id, p.caption, u.username
FROM Posts p
JOIN Users u ON p.user_id = u.user_id;

-- GROUP BY + COUNT: Get total likes per post
SELECT post_id, COUNT(user_id) AS like_count
FROM Likes
GROUP BY post_id;

-- Subquery: Get the most liked post
SELECT p.post_id, p.caption
FROM Posts p
WHERE p.post_id = (
    SELECT post_id
    FROM Likes
    GROUP BY post_id
    ORDER BY COUNT(user_id) DESC
    LIMIT 1
);

-- Performing CRUD Operations (Create, Read, Update, Delete)
-- CREATE
INSERT INTO Users (username, email, bio) VALUES ('dave', 'dave@mail.com', 'Cyclist');

-- READ
SELECT * FROM Users WHERE username = 'alice';

-- UPDATE
UPDATE Users SET bio = 'Nature lover 🌿' WHERE user_id = 1;

-- DELETE
DELETE FROM Posts WHERE post_id = 2;

--Handling Data Relationships (One-to-Many, Many-to-Many)

-- One-to-Many: Get all comments on a post with usernames
SELECT c.comment, u.username
FROM Comments c
JOIN Users u ON c.user_id = u.user_id
WHERE c.post_id = 1;

-- Many-to-Many: Find all users followed by user_id = 1
SELECT u.username
FROM Followers f
JOIN Users u ON f.following_id = u.user_id
WHERE f.follower_id = 1;




