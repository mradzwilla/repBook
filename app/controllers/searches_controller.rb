class SearchesController < ApplicationController

	def index
		@searched = params[:name]
		#Into here I need to include the Congress gem to make the search get relevant info
		#Eventually this should search for companies too
		#The resulting view will be a list of all results. Clicking on the results will give you the option of "following" that rep
	end
end
