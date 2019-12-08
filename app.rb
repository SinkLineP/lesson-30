#encoding: utf-8
require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'sinatra/activerecord'

set :database, {adapter: "sqlite3", database: "barber.db"}

class Clients < ActiveRecord::Base
end

class Barbers < ActiveRecord::Base
end

class Contacts < ActiveRecord::Base
end

before do
	@barbers = Barbers.all
	@clients = Clients.all
	@contacts = Contacts.all	
end

get '/' do
	erb :index
end

get '/visit' do
	erb :visit
end

post '/visit' do 

	c = Clients.new params[:client]
    c.save

    
	erb "<h2>Спасибо вы записались!!</h2>"
	
end

get '/contacts' do
	erb :contacts
end

post '/contacts' do

	@email = params[:email]
	@message = params[:message]

	c = Contacts.new
    c.email = @email
    c.message = @message
	c.save

	erb "<h2>Спасибо за ваш отзыв, мы вам ответим в скором времени.</h2>"

end








