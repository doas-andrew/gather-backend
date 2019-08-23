class FriendRequestsController < ApplicationController

	def create
		friend_error = "You can't add yourself as a friend!" if @user.id == params[:friend_request][:recipient_id]

		@friend_request = FriendRequest.new(sender_id: @user.id, recipient_id: params[:friend_request][:recipient_id])

		if @friend_request.valid? && friend_error.nil?
			@friend_request.save
			render json: { user: UserSerializer.new(@user) }, status: :accepted
		else
			render json: { errors: (@friend_request.errors.full_messages << friend_error).compact }, status: :unprocessable_entity
		end
	end

	def destroy
		@friend_request = FriendRequest.find(params[:id])

		if @friend_request
			@friend_request.destroy
			render json: { user: UserSerializer.new(@user) }, status: :ok
		else
			render json: { errors: ["FriendRequest of id #{params[:id]} not found."] }, status: :not_found
		end
	end
end
