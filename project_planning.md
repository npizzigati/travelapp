# Travel App
A clean, minimalistic social app that helps you find travel recommendations from people you trust, your inner circle.

### When a user opens the app, they see:

#### A landing page with 2 buttons, `login` and `sign-up`, with travel graphics and a blurb about the app
  - After clicking the `login` button, they’re brought to a page to input their username and password 
  - After clicking the `sign-up` button, the option to enter their “information”
      - What ‘information?’
        - First & last name
        - Email address
        - Password
  - Once user is logged in, they’re brought to their dashboard

#### On the dashboard, buttons for various functions
  - Add a recommendation
  - Search for recommendations
    - Filters to look at inner circle, public accounts, or both
  - Update profile
  - View inner circle
    - The ability to invite (add) and/or remove (delete) people from your inner circle
  - Search for people via personal handle

__Important Questions__
* How does an ‘inner circle’ form?
  - When User A invites User B via a link and User B signs up 
    - User A is added to User B’s inner circle and vice versa, 
    - User B is added to User A’s inner circle
  - When User A invites User B via a link and User B opens link,
    - User B is brought to a confirmation page, 
      - if they accept each user is added to the other’s inner circle
      - If they decline, nothing happens - invite expires?


#### Building a Backlog
