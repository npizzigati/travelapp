require 'bundler/setup'

require 'sinatra'
require 'pg'
require 'erb'

# conn = PG.connect(:dbname => 'travelapp')
conn = PG.connect(ENV['DATABASE_URL'])

set :public_folder, 'public'

get "/" do
  redirect '/index.html'
end

get '/search' do
  place = params['place']
  query = <<~QUERY
    SELECT body, title, first_name, last_name
    FROM   reviews
    INNER JOIN users ON users.id = reviews.user_id
    WHERE LOWER(city) = $1 OR LOWER(country) = $1;
  QUERY
  @results = conn.exec_params(query, [place.downcase])
  erb :place_search_results
end

get '/new-user' do
  erb :new_user
end

get '/display-users' do
  query = <<~QUERY
    SELECT first_name, last_name, display_name
    FROM   users;
  QUERY
  @results = conn.exec_params(query, [])
  erb :display_users
end

post '/enter-user-details' do
  first_name = params['first-name']
  last_name = params['last-name']
  display_name = params['display-name']
  query = <<~QUERY
    INSERT INTO users(first_name, last_name, display_name)
    VALUES ($1, $2, $3)
  QUERY
  @results = conn.exec_params(query, [first_name, last_name, display_name])
  redirect '/display-users'
end
