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
  city text,
  country text,
  title varchar(50),
  body text, --CHECK (length(body) > 100),--should we have a character limit?
  -- how do you even save photos?!
  user_id integer NOT NULL REFERENCES users (id) ON DELETE CASCADE
);

INSERT INTO users (first_name, last_name, display_name) VALUES ('Nick', 'Pizzigati', 'Nico');
INSERT INTO users (first_name, last_name, display_name) VALUES ('Leeya', 'Davis', 'Leelee');
INSERT INTO users (first_name, last_name, display_name) VALUES ('Dhana', 'McTavish', 'Day');
INSERT INTO users (first_name, last_name, display_name) VALUES ('Teresa', 'Garcia', 'Tere');

INSERT INTO recommendations (user_id, city, country, title, body) VALUES (1, 'Guanajuato', 'Mexico', 'Coffee', 'Coffee at Café Tal'),
                                                        (1, 'Tulum', 'Mexico', 'Park', 'Visit Xel-Ha');
INSERT INTO recommendations (user_id, city, country, title, body) VALUES (2, 'Seoul', 'South Korea', 'N Tower', 'Awesome views');
INSERT INTO recommendations (user_id, city, country, title, body) VALUES (3, 'Rome', 'Italy', 'Big city vibes', 'Loud and busy');
INSERT INTO recommendations (user_id, city, country, title, body) VALUES (4, 'Kuala Lumpar', 'Malaysia', 'Patronas Towers!', 'Great place to take in the city.');
