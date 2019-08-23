class EventsController < ApplicationController
	skip_before_action :authorize, only: [:index, :show]

	# SS_ID = File.read(File.expand_path('smarty_street/auth_id.txt', __dir__))
	# SS_KEY = File.read(File.expand_path('smarty_street/auth_key.txt', __dir__))

	def index
		# @events = Event.all.map{|e| EventSerializer.new(e) }
		# render json: @events
		# @events = Event.all
		# render json: @events, status: :ok
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
