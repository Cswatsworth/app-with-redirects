require 'minitest/autorun'
require 'rack/test'
require_relative '../app.rb'

class TestApp < Minitest::Test
	include Rack::Test::Methods
	
	def app
		PersonalDetailsApp
	end


	def test_ask_name_on_entry_page
		get '/'
		assert(last_response.ok?)
		assert(last_response.body.include?('Hello, what is your name'))	
		assert(last_response.body.include?('<input type="text" name="name_input">'))
		assert(last_response.body.include?('<form method="post" action="/name">'))
		assert(last_response.body.include?("<input type='submit' value = 'Submit'>"))
	end

	def test_post_to_name
		post '/name', name_input: 'Jon'
		follow_redirect!
		assert(last_response.body.include?('Jon'))
		assert(last_response.ok?)
		
	end

	def test_get_age
		get '/age?name=Chad'
		assert(last_response.body.include?('Hello, Chad! How old are you?'))
		assert(last_response.ok?)
	end

	def test_pass_to_age
		post '/age', age_input: '23', name_input: 'Chad'
		follow_redirect!
		assert(last_response.body.include?('23'))
		assert(last_response.ok?)
	end

	def test_get_fav_nums
		get '/fav_nums?age=23&name=Chad'
		assert(last_response.body.include?('Chad'))
		assert(last_response.body.include?('23'))
		assert(last_response.ok?)
	end

	def test_post_fav_nums
		post '/fav_nums', age_input: '23', name_input: 'Chad', fav_num1_input: '4', fav_num2_input: '3', fav_num3_input: '2', sum: '9', results: 'less than'
		assert(last_response.body.include?('23'))
		assert(last_response.body.include?('Chad'))
		assert(last_response.body.include?('4'))
		assert(last_response.body.include?('3'))
		assert(last_response.body.include?('2'))
		assert(last_response.ok?)
	end
end