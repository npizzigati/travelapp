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
