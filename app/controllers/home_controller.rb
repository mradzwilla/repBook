class HomeController < ApplicationController
	require 'unirest'

	def index
	  	if user_signed_in?
	  		redirect_to test_path
	  	else
	  		redirect_to new_user_session_path
	  	end 
	end

	def test
		@user = current_user
		@resp_arr = []

		@user.update(politicians_following: [{name: "Bernie Sanders", bioguide_id: "S000033"}, {name:"Paul Ryan", bioguide_id: "R000570"}])
		@user.politicians_following.each do |x|
			@instance_id = x[:bioguide_id]
			puts @instance_id
			@response = Unirest.get "http://capitolwords.org/api/1/text.json?bioguide_id="+@instance_id+"&apikey=5b435d0bb1f946168564c8398f0ccc5e",
			headers:{ "Accept" => "application/json" }
			@resp_arr.push(@response.body)
		end

		# @user.politicians_following.each do |politician|
		# 	@response = Unirest.get "http://capitolwords.org/api/1/text.json?bioguide_id=S000033&apikey=5b435d0bb1f946168564c8398f0ccc5e",
		# 	headers:{ "Accept" => "application/json" }
		# end

		# @response = Unirest.get "http://capitolwords.org/api/1/text.json?bioguide_id=S000033&apikey=5b435d0bb1f946168564c8398f0ccc5e",
		# 	headers:{ "Accept" => "application/json" }
	end

	def follow_politician
		@user = current_user
		@user.politicians_following << params[:politician]

		redirect_to test_path
	end
end
