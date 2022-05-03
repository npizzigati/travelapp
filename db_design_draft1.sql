-- USERS --- one-to-many --< REVIEWS
-- USERS >-- many-to-many --< OTHER USERS

-- USERS
-- - first_name
-- - last_name
-- - display_name
-- - age_range
-- - friends

-- REVIEWS
-- - city/town
-- - country
-- - title
-- - description
-- - pictures
-- - user_id

CREATE TABLE users (
  id serial PRIMARY KEY,
  first_name varchar(50),
  last_name varchar(50),
  display_name varchar(40),
  age_range text -- can we have a dropdown box to select '20-30', '30-40' age ranges?
  -- not sure how we'll link users-to-users yet
);

CREATE TABLE reviews (
  id serial PRIMARY KEY,
  city_town text,
  country text,
  title varchar(50),
  description text CHECK (length(text) > 100),--should we have a character limit?
  -- how do you even save photos?!
  user_id integer REFERENCES users (id) NOT NULL ON DELETE CASCADE

);

