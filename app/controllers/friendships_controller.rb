class FriendshipsController < ApplicationController

	def create
		@friend_request = FriendRequest.find(params[:friend_request_id])
		fr_error = 'Friend Request not found' unless @friend_request

		@friendship = Friendship.new(user_id: @user.id, friend_id: params[:friend_id])

		if @friendship.valid? && fr_error.nil?
			@friend_request.destroy
			@friendship.save
			render json: { user: UserSerializer.new(@user) }, status: :accepted
		else
			render json: { errors: (@friendship.errors << fr_error).compact }, status: :unprocessable_entity
		end
	end

	def destroy
		@friendship = Friendship.find(params[:id])

		if @friendship
			@friendship.destroy
			render json: { user: UserSerializer.new(@user) }, status: :ok
		else
			render json: { errors: ["Friendship of id #{params[:id]} not found."] }, status: :not_found
		end
	end
end
