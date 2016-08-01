class HomeController < ApplicationController
	require 'unirest'
	require 'congress'

	def signin
	  	if user_signed_in?
	  		redirect_to index_path
	  	else
	  		redirect_to new_user_session_path
	  	end 
	end

	def index
		@time = Time.new
		@todays_date = ((@time.year)).to_s + "-" + ((@time.month-2)).to_s + "-" +@time.day.to_s
		puts @todays_date

		@user = current_user
		@politicians_following = @user.politicians_following
		@congress = Congress::Client.new('5b435d0bb1f946168564c8398f0ccc5e')
		@politician_arr = []

		@politicians_following.each do |x|
			@rep = Politician.find_by(bioguide_id: x)
			@politician_arr.push(@rep)
		end

		@resp_arr = []
		@politician_arr.each do |x|
			@bioguide_id = x.bioguide_id

			@response = Unirest.get "http://capitolwords.org/api/1/text.json?bioguide_id="+@bioguide_id+"&start_date="+ @todays_date +"&apikey=5b435d0bb1f946168564c8398f0ccc5e",
			headers:{ "Accept" => "application/json"}
			@resp_arr.push(@response.body['results'])
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
		@new_politician_id = params[:bioguide_id]

		if @user.politicians_following.index(@new_politician_id) == nil
			@user.politicians_following << @new_politician_id
		end

		@rep = Politician.find_by(bioguide_id: @new_politician_id)
		if @rep.nil?
				@congress = Congress::Client.new('5b435d0bb1f946168564c8398f0ccc5e')
				@rep_info = @congress.legislators(bioguide_id: @new_politician_id)['results'].first
				@full_name = @rep_info['first_name'] + " " + @rep_info['last_name']
				@new_politician = Politician.create(name: @full_name, bioguide_id: @rep_info['bioguide_id'])
		end

		@user.save

		redirect_to root_path
	end

	def unfollow_politician
		@user = current_user
		@politician_id = params[:bioguide_id]

		@user.politicians_following.delete(@politician_id)
		@user.save

		redirect_to root_path
	end

end

