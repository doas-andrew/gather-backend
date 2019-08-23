class AttendsController < ApplicationController

	def create
		@event = Event.find(params[:attend][:event_id])
		@attend = Attend.new( user: @user, event: @event )

		if @attend.valid? && @attend.save
			render json: { event: EventSerializer.new(@event) }, status: :accepted
		else
			render json: { errors: @attend.errors.full_messages }, status: :declined
		end
	end
	
end
