class HomeController < ApplicationController
	require 'unirest'
	require 'congress'

	def index
	  	if user_signed_in?
	  		redirect_to test_path
	  	else
	  		redirect_to new_user_session_path
	  	end 
	end

	def test
		@user = current_user
		@politicians_following = @user.politicians_following
		# puts @okoko
		# @resp_arr = []
		# @user_id = "S000033"
		# @ok = Politician.find_by(bioguide_id: @user_id)
		# puts @ok.name

		#@politician = Politician.create(name: "Bernie Sanders", bioguide_id: "S000033")
		# @all_poli = Politician.last
		# puts @all_poli.name
		puts "I like turtles"
		# @user.update(politicians_following: [{name: "Bernie Sanders", bioguide_id: "S000033"}, {name:"Paul Ryan", bioguide_id: "R000570"}])
		# @user.politicians_following.each do |x|
		# 	@instance_id = x[:bioguide_id]
		# 	puts @instance_id
		# 	@response = Unirest.get "http://capitolwords.org/api/1/text.json?bioguide_id="+@instance_id+"&apikey=5b435d0bb1f946168564c8398f0ccc5e",
		# 	headers:{ "Accept" => "application/json" }
		# 	@resp_arr.push(@response.body)
		# end

		# @user.politicians_following.each do |politician|
		# 	@response = Unirest.get "http://capitolwords.org/api/1/text.json?bioguide_id=S000033&apikey=5b435d0bb1f946168564c8398f0ccc5e",
		# 	headers:{ "Accept" => "application/json" }
		# end

		# @response = Unirest.get "http://capitolwords.org/api/1/text.json?bioguide_id=S000033&apikey=5b435d0bb1f946168564c8398f0ccc5e",
		# 	headers:{ "Accept" => "application/json" }
	end

	def follow_politician
		@user = current_user
		@new_politician_id = params[:bioguide_id]

		if @user.politicians_following.index(@new_politician_id) == nil
			puts "Addededededed"
			@user.politicians_following << @new_politician_id
		else
			puts "Already there"
		end

		@user.save

		# puts @user.politicians_following
		puts "You know nothing Jon Snow"
		redirect_to test_path
	end

	def unfollow_politician
	end
end

