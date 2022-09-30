TRUNCATE TABLE posts, comments RESTART IDENTITY; 


INSERT INTO posts (title, content) VALUES ('My Dog', 'It is cute!');
INSERT INTO posts (title, content) VALUES ('My Cat', 'It is adorbale!');

INSERT INTO comments (content, author_name, post_id) VALUES ('Love it!', 'Kate', 1);
INSERT INTO comments (content, author_name, post_id) VALUES ('Cute!', 'John', 1);
INSERT INTO comments (content, author_name, post_id) VALUES ('Like!', 'Josh', 2);