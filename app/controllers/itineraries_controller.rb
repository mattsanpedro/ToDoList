class ItinerariesController < ApplicationController
	
	helper_method :sort_column, :sort_direction

	def show
		@itinerary = Itinerary.find(params[:id])
	end
	def index
		 @itineraries = Itinerary.order([sort_column, sort_direction].join(" "))
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
	def complete
      	if Task.ids(params[:task_ids]).update_all(is_completed: true) 
        	redirect_to completed_tasks_path  
      	else
        	redirect_to tasks_path
      	end
  	end

  	def unmark
      	if Task.where.not(id: params[:task_ids]).update_all(is_completed: false) 
       		redirect_to tasks_path  
      	else
        	redirect_to completed_tasks_path
      	end
  	end

	private
	
	def itinerary_params
		params.require(:itinerary).permit(:location, :travel_on)
	end
	def sort_column
		Itinerary.column_names.include?(params[:sort]) ? params[:sort] : "location"
	end
	def sort_direction
		%w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
	end
	
end