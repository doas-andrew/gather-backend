class EventsController < ApplicationController
	skip_before_action :authorize, only: [:index, :show]

	def index
		render json: Event.all
	end

	def show
		render json: Event.find(params[:id])
	end

	def create
		@event = Event.new(new_event_params)
		@event.organizer = @user
		
		if @event.valid?
			@event.save
			Attend.create(user: @user, event: @event)
			
			render json: { event: EventSerializer.new(@event) }, status: :accepted
		else
			render json: { errors: @event.errors.full_messages }, status: :unprocessable_entity
		end
	end

	private

	def new_event_params
		params.require(:event).permit(:title, :details, :category, :date, :address, :city, :state)
	end
end
