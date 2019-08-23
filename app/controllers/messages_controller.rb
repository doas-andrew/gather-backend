class MessagesController < ApplicationController
	skip_before_action :authorize, only: [:index]

	def index
		render json: Message.all
	end

	def create
		@recipient = User.find_by(login_name: params[:message][:recipient_username].strip.downcase)

		recipient_error = "You can't message yourself!" if @user == @recipient

		@message = Message.new(
			user_id: @user.id,
			sender_id: @user.id,
			recipient_id: @recipient ? @recipient.id : nil,
			subject: params[:message][:subject].strip,
			content: params[:message][:content].strip,
		)

		if @message.valid? && recipient_error.nil?
			@message.save
			render json: { message: MessageSerializer.new(@message) }, status: :accepted
		else
			render json: { errors: (@message.errors.full_messages << recipient_error).compact }, status: :unprocessable_entity
		end
	end

	def seen
		@message = Message.find(params[:id])
		@message.seen = true

		if @message.valid?
			@message.save
			render json: { message: @message }, status: :ok
		else
			render json: { errors: @message.errors.full_messages }, status: :unprocessable_entity
		end
	end

	def mass_deletion
		params[:messages].each { |id|

			message = Message.find(id)
			
			if message.user_id == @user.id || message.sender_id == @user.id
				message.delete
			else
				render json: { errors: [] }, status: :forbidden
				return 0
			end
		}
		render json: { user: UserSerializer.new(@user) }, status: :ok
	end
end
