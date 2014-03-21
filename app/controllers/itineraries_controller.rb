class ItinerariesController < ApplicationController
	def show
		@itinerary = Itinerary.find(params[:id])
	end
	def index
		@itineraries = Itinerary.all
	end
	def new
		@itinerary = Itinerary.new
	end
	def create
		@itinerary = Itinerary.new(itinerary_params)
		if @itinerary.save
			redirect_to action: 'show', id: @itinerary.id
		else
			render action: 'new'
		end	
	end

	def edit
		@itinerary = Itinerary.find(params[:id])
	end
	def update
		@itinerary = Itinerary.find(params[:id])
		if @itinerary.update(itinerary_params)
			redirect_to action: 'show', id: @itinerary.id
		else
			render action: 'edit'
		end
	end

	private
	
	def itinerary_params
		params.require(:itinerary).permit(:location, :travel_on)
	end
	
end