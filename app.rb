require 'sinatra'
require 'sinatra/reloader'

require 'sinatra/activerecord'
require 'active_record'
require 'sqlite3'


set :database, {adapter: "sqlite3", database: "barber.db"}

class Clients < ActiveRecord::Base
  validates :username, presence: true
  validates :phone, presence: true
  validates :datetime, presence: true
  validates :color, presence: true
end

class Barbers < ActiveRecord::Base
end

class Contacts < ActiveRecord::Base
end

before do
	@barbers = Barbers.all
end

get '/' do
	erb :index
end

get '/visit' do
	@c = Clients.new

	erb :visit
end

# post '/visit' do 

# 	c = Clients.new params[:client]
# 	c.save
#     if c.save
# 		erb "<h2>Спасибо вы записались!!</h2>"
# 	else
# 		erb "<h2>Ошибка</h2>"
# 	end
# end
#------------------------------------------------------

post '/visit' do
  @c = Clients.new params[:client]
  @c.save

  if @c.save
    erb "<p>Thank you!</p>"
  else
    @error = 'Поле не может быть пустым'
    erb :visit
  end

end

get '/clients' do
  @clients = Clients.order('created_at DESC')

  erb :clients
end




