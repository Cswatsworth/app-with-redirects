require 'sinatra'

class PersonalDetailsApp < Sinatra::Base

	get '/' do 
		erb :name
	end

	post '/name' do
		name = params[:name_input]
		redirect '/age?name=' + name 
	end

	get '/age' do
		name = params[:name]
		erb :age, locals: {name: name}

	end

	post '/age' do
		name = params[:name_input]
		age = params[:age_input]
		
		redirect '/fav_nums?age=' + age + '&name' + name
	end

	get '/fav_nums' do
		name = params[:name]
		age = params[:age]
		"#{name} and #{age}"

	end

	post '/fav_nums' do
		name = params[:name_input]
		age = params[:age_input]

		redirect '/results?fav_nums=' + fav_nums + '&age' + age + '&name' + name
	end

	get '/results' do
		name = parmas[:name]
		age = params[:age]
		fav_nums = params[:fav_nums]
		"#{name} and #{age} and #{fav_nums}"
	end
end