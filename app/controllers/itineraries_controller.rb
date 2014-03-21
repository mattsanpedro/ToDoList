class ItinerariesController < ApplicationController
	def show
		@itinerary = Itinerary.find(params[:id])
	end
	def index
		@itineraries = Itinerary.all
	end
	def new
	end
	def create
		@itinerary = Itinerary.new(itinerary_params)
		if @itinerary.save
			redirect_to action: 'show', id: @itinerary.id
		else
		render action: 'new'
		end	
	end

	private

	def itinerary_params
		params.require(:itinerary).permit(:location, :travel_on)
	end
end