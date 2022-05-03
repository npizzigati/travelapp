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
    SELECT description FROM reviews
     WHERE city_town = $1;
  QUERY
  template = <<~TEMPLATE
    % results.each do |row|
      <%= row['recommendation']%>
    % end
  TEMPLATE
  results = conn.exec_params(query, [place])
  p results
  results.each do |row|
    puts row
  end
  output = ERB.new(template, trim_mode: "%<>")
  output.result(binding)
end
