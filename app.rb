require 'bundler/setup'

require 'sinatra'
require 'pg'
require 'erb'
# require 'mailersend-ruby'
require 'bcrypt'

set :public_folder, 'public'

enable :sessions

ENV['APP_ENV'] ||= 'development'

conn = if ENV['DATABASE_URL']
  PG.connect(ENV['DATABASE_URL'])
else
  PG.connect(:dbname => 'travelapp')
end

get "/" do
  @user_email = session[:email]
  @user_display_name = session[:display_name]
  erb :home
end

get '/search' do
  place = params['place']
  query = <<~QUERY
    SELECT body, title, first_name, last_name
    FROM   recommendations
    INNER JOIN users ON users.id = recommendations.user_id
    WHERE LOWER(city) = $1 OR LOWER(country) = $1;
  QUERY
  @results = conn.exec_params(query, [place.downcase])
  erb :place_search_results
end

get '/sign-up' do
  erb :sign_up
end

get '/sign-in' do
  erb :sign_in
end

get '/sign-out' do
  session.clear
  redirect '/'
end

get '/display-users' do
  query = <<~QUERY
    SELECT first_name, last_name, display_name
    FROM   users;
  QUERY
  @results = conn.exec_params(query, [])
  erb :display_users
end

post '/sign-in' do
  email = params['email']
  plaintext_password = params['password']
  query = <<~QUERY
    SELECT encrypted_pw, email, display_name, id
    FROM   users
    WHERE  email=$1;
  QUERY
  results = conn.exec_params(query, [email])
  encrypted_password = results[0]['encrypted_pw']
  bcrypt_password = BCrypt::Password.new(encrypted_password)
  # Bcrypt overloads the == operator for the object it creates,
  # with is subclassed from the String built-in
  if bcrypt_password == plaintext_password
    session[:email] = results[0]['email']
    session[:display_name] = results[0]['display_name']
    session[:id] = results[0]['id']
  end

  redirect '/'
end

post '/sign-up' do
  first_name = params['first-name']
  last_name = params['last-name']
  email = params['email']
  display_name = params['display-name']
  plaintext_password = params['password']
  bcrypt_password = BCrypt::Password.create(plaintext_password)
  query = <<~QUERY
    INSERT INTO users(first_name, last_name, email, display_name, encrypted_pw)
    VALUES ($1, $2, $3, $4, $5)
  QUERY
  @results = conn.exec_params(query, [first_name, last_name, email, display_name, bcrypt_password])

  # sendEmail()

  redirect '/display-users'
end

get '/add_recommendation' do
  user_id = session[:id]
  erb :add_recommendation
end

# Enable this (sending through Mailersend) when we get approval
# from Mailersend
# def sendEmail()
#   email = Mailersend::Email.new
#   email.add_recipients("email" => "npizzigati@gmail.com", "name" => "Nick")
#   email.add_from("email" => "noreply@projectbucket.dev", "name" => "noreply")
#   email.add_subject("Test Email")
#   email.add_text("This is a test email")
#   email.add_html("<b>This is a test email</b>")
#   email.send
# end
