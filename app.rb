require 'bundler/setup'

require 'sinatra'
require 'pg'
require 'erb'

# conn = PG.connect(:dbname => 'travelapp')
conn = PG.connect(ENV['DATABASE_URL'])

get '/' do
  send_file 'index.html'
end

get '/search' do
  place = params['place']
  query = <<~QUERY
    SELECT body, first_name, last_name
    FROM   reviews
    INNER JOIN users ON users.id = reviews.id
    WHERE city = $1 OR country = $1;
  QUERY
  @results = conn.exec_params(query, [place])
  erb :place_search_results
end
