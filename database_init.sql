-- USERS --- one-to-many --< RECOMMENDATIONS
-- USERS >-- many-to-many --< OTHER USERS

-- USERS
-- - first_name
-- - last_name
-- - display_name
-- - age_range
-- - friends

-- RECOMMENDATIONS
-- - city/town
-- - country
-- - title
-- - body
-- - pictures
-- - user_id
CREATE TABLE users (
  id serial PRIMARY KEY,
  first_name varchar(50),
  last_name varchar(50),
  display_name varchar(40),
  email varchar(200),
  encrypted_pw varchar(200),
  age_range text -- can we have a dropdown box to select '20-30', '30-40' age ranges?
  -- not sure how we'll link users-to-users yet
);

CREATE TABLE recommendations (
  id serial PRIMARY KEY,
  destination_id integer,
  title varchar(50),
  body text, --CHECK (length(body) > 100),--should we have a character limit?
  -- how do you even save photos?!
  user_id integer NOT NULL REFERENCES users (id) ON DELETE CASCADE
  categories text
);

CREATE TABLE destination (
  id serial PRIMARY KEY,
  city varchar(50),
  country varchar(50),
  description varchar(50)
  )

INSERT INTO users (first_name, last_name, display_name) VALUES ('Nick', 'Pizzigati', 'Nico');
INSERT INTO users (first_name, last_name, display_name) VALUES ('Leeya', 'Davis', 'Leelee');
INSERT INTO users (first_name, last_name, display_name) VALUES ('Dhana', 'McTavish', 'Day');
INSERT INTO users (first_name, last_name, display_name) VALUES ('Teresa', 'Garcia', 'Tere');

INSERT INTO destination (city, country, description) VALUES ('Guanajuato', 'Mexico', '');
INSERT INTO destination (city, country, description) VALUES ('Tulum', 'Mexico', '');
INSERT INTO destination (city, country, description) VALUES ('Seoul', 'South Korea', '');
INSERT INTO destination (city, country, description) VALUES ('Rome', 'Italy', '');
INSERT INTO destination (city, country, description) VALUES ('Kuala Lumpar', 'Malaysia', '');

INSERT INTO recommendations (user_id, destination_id, title, body)
VALUES (1, 1, 'Coffee', 'Coffee at Café Tal'),
       (1, 2, 'Park', 'Visit Xel-Ha'),
       (2, 3, 'N Tower', 'Awesome views'),
       (3, 4, 'Big city vibes', 'Loud and busy'),
       (4, 5, 'Patronas Towers!', 'Great place to take in the city.');
