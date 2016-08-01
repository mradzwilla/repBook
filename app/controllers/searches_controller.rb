class SearchesController < ApplicationController

	def index
		@user = current_user
		@searched = params[:name]
		@congress = Congress::Client.new('5b435d0bb1f946168564c8398f0ccc5e')

		#Into here I need to include the Congress gem to make the search get relevant info
		#Eventually this should search for companies too
		#The resulting view will be a list of all results. Clicking on the results will give you the option of "following" that rep

		if /\A\d+{5}\z/.match(@searched)
		 	#regex checks if search is a zip code
		 	@result = []
		 	@response = @congress.legislators_locate(@searched)['results']

		 	@response.each do |x|
			 	if @user.politicians_following.index(x['bioguide_id']) == nil
						x['following?'] = false
					else
						x['following?'] = true
				end
  				@result.push(x)
  			end
  		else #if not a 5-digit zip code
  			@result = []
  			@response = @congress.legislators(:query => @searched)['results']

  			@response.each do |x|
  				#This adds the following? value to determine if "Follow" or "Unfollow" button should appear
  				if @user.politicians_following.index(x['bioguide_id']) == nil
					x['following?'] = false
				else
					x['following?'] = true
				end
  				@result.push(x)
  			end

  		end  
	end
end
