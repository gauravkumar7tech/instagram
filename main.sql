create database project;
use project;
CREATE TABLE Users (
    user_id int primary key auto_increment,
    username varchar(50) not null unique,
    email varchar(100) not null unique,
    bio text,
    password varchar(255) not null,
    created_at timestamp default current_timestamp
);

INSERT INTO Users (username, email, bio, password) VALUES
('alice', 'alice@example.com', 'Nature lover 🌿 | Coffee addict ☕', 'password123'),
('bob', 'bob@example.com', 'Tech geek 🤖 | Gamer 🎮', 'bobsecure456'),
('charlie', 'charlie@example.com', 'Photographer 📸 | Traveler 🌍', 'charliepass789'),
('daisy', 'daisy@example.com', 'Foodie 🍕 | Blogger ✍️', 'daisypass321'),
('eve', 'eve@example.com', 'Fitness enthusiast 💪 | Dog mom 🐶', 'evepass999');


CREATE TABLE Posts (
    post_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,
    image_url VARCHAR(255),
    caption TEXT,
    posted_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);
INSERT INTO Posts (user_id, image_url, caption)
VALUES 
(1, 'https://example.com/images/post1.jpg', 'Sunset at the beach 🌅'),
(2, 'https://example.com/images/post2.jpg', 'My new puppy! 🐶'),
(3, 'https://example.com/images/post3.jpg', 'Throwback to last summer ☀️'),
(1, 'https://example.com/images/post4.jpg', 'Early morning hike 🥾⛰️'),
(4, 'https://example.com/images/post5.jpg', 'Homemade pasta night 🍝'),
(2, 'https://example.com/images/post6.jpg', 'Reading by the fireplace 📚🔥');


CREATE TABLE Likes (
    like_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,
    post_id INT NOT NULL,
    liked_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES Users(user_id),
    FOREIGN KEY (post_id) REFERENCES Posts(post_id),
    UNIQUE (user_id, post_id) -- prevent multiple likes on the same post
);
CREATE TABLE Followers (
    follower_id INT NOT NULL,
    following_id INT NOT NULL,
    followed_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (follower_id, following_id),
    FOREIGN KEY (follower_id) REFERENCES Users(user_id),
    FOREIGN KEY (following_id) REFERENCES Users(user_id)
);
