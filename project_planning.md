# Travel App
A clean, minimalistic social app that helps you find travel recommendations from people you trust, your inner circle.

### Building a Backlog
# Sprint 1, 5/16 - 5/22
Leeya
- Epic 1, Story 1: As an end-user I want to be able to complete a simple form, so I can add a recommendation when I click submit
- Epic 1, Story 1.1: As an end-user I want to click submit on the recommendation form, so I can save my recommendation

Nick
- Fix up landing page (index.html) -- use higher resolution photo; center search bar
- Create form for user to enter their personal information and submit it into the database

#### Stories
- Epic 1, Story 2: As an end-user I want to be able to see the recommendation I just added, so I can confirm that it’s been added to my profile
- Epic 1, Story 3: As an end-user I want to be able to edit and delete my recommendations, so I can manage my information

- Epic 2, Story 1: As an end-user I want to be able to enter a place name in a search box so I can submit a search.
- Epic 2, Story 2: As an end-user I want to see the results of my search (recommendations)

- Epic 3, Story 1: As an end-user I want to be able to create an account where my personal information will be saved so I can use the private features of the site.
- Epic 3, Story 2: As an end-user I want to be able to enter my credentials on a log in form so I can log in.

- Epic 4, Story 1: As an end-user I want to be able to click on a link so I can access my profile page.

#### Epic(s)
1. **As an** end-user **I want to** write simple recommendations for places I’ve been, things I’ve done, etc,** so I ca**n document my trip and share great spots with friends and other users

2. **As an** end-user **I want to** view recommendations from friends and other users, **so I can** properly plan for an upcoming trip

3. **As an** end-user **I want to** be able to access a private area **so I can** only see the recommendations of my friends, and share highlights of my trips while maintaining my privacy.

4. **As an** end-user **I want to** have a profile page where all my info is, **so I can** access to all of my recommendations and inner circle with ease

#### Saga(s)
**As an** end-user **I want to** use this app to find reliable recommendations, **so I can** find places to go and things to do while traveling to a country of my choosing


### OO Design
1. Write a description of the problem
Travel App is a social app that helps you find travel recommendations from people you value, your inner circle.
With this app users can give and find reliable recommendations--by destination or other users--for places to see and things to so in a country of their choice.

2. Extract major nouns and verbs
Nouns: user, recommendation, destination, country, places to see, things to do
Verbs: find, give

3. Make an initial guess at organizing the verbs and nouns into methods and classes/modules, then do a spike to explore the problem with temporary code.

User 
- give (add) recommendations
- find (search) recommendations
Recommendation
- Destination
  - country
  - places to see
  - things to do

```ruby
class User
  def initialize
    # based on schema
    #   id serial PRIMARY KEY <-- will see what this looks like in RB185
    #   first_name
    #   last_name
    #   display_name
    #   email
    #   encrypted_pw
    #   age_range -- a dropdown box to select '20-30', '30-40' age ranges
  end

  def add_recommendation;end
  def edit_recommendation; end
  def delete_recommendation; end
  def search_recommendations; end
end

class Recommendation
  def initialize
    #  id serial PRIMARY KEY <-- will see what this looks like in RB185
    #  title
    #  author (user_id)
    #  Destination.new
    #  Category
    #   - places to see   <-- rather than a boolean value how about a space separated list of keywords? 
    #   - things to do    <--
    #   - food to eat     <--
    #   - places to stay  <--
    #   - getting around  <--
  end
end

class Destination
  def initialize
    #   - country
    #   - city
    #   - description
  end
end
```

4. When you have a better idea of the problem, model your thoughts into CRC cards.
**User**
- has a last name     - can add recommendation
- has a first name    - can edit recommendation
- has an age range    - can delete recommendation
- has a display name  - can search recommendations
- has a email         ? can sign-up
- has a encrypted_pw  ? can sign-in
                      ? can sign-out

**Recommendation**  collaborator: Destination
- has a title
- has an author
- has a category
- has a destination

**Destination**
- has a country
- has a city
- has a description

User -|--O< Recommendation
Destination -|--O< Recommendation