require 'bundler/setup'

require 'sinatra'
require 'pg'
require 'erb'

conn = PG.connect(:dbname => 'travelapp')
conn.exec('SELECT * from recommendations') do |result|
  result.each do |row|
    puts row
  end
end

get '/' do
  send_file 'index.html'
end

get '/search' do
  place = params['place']
  query = <<~QUERY
    SELECT recommendation FROM recommendations
     WHERE city = $1;
  QUERY
  template = <<~TEMPLATE
    % results.each do |row|
      <%= row['recommendation']%>
    % end
  TEMPLATE
  results = conn.exec_params(query, [place])
  results.each do |row|
    puts row
  end
  output = ERB.new(template, trim_mode: "%<>")
  output.result(binding)
end
