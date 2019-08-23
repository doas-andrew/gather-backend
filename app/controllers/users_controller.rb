class UsersController < ApplicationController
	skip_before_action :authorize, only: [:index, :create]

	def index
		render json: User.all
	end

	def show
		@user_profile = User.find(params[:id])

		if @user_profile
			render json: { user: ProfileSerializer.new(@user_profile), isFriend: @user_profile.friends.include?(@user) }, status: :ok
		else
			render json: { errors: ['User not found.'] }, status: :not_found
		end
	end

	def create
		@user = User.new(new_user_params)

		password_error = 'Passwords did not match' if params[:user][:password] != params[:user][:confirm_password]

		if @user.valid? && password_error.nil?
			@user.save
			token = jwt_encode({ user_id: @user.id })
  	  render json: { token: token, user: UserSerializer.new(@user) }, status: :ok
		else
			render json: { errors: (@user.errors.full_messages << password_error).compact }, status: :unprocessable_entity
		end
	end

	def update
		p params

		errors = []
		errors << 'Incorrect password' unless @user.authenticate?(params[:user][:current_password])
		errors << 'New passwords did not match' if params[:user][:password] && params[:user][:password] != params[:user][:confirm]

		if @user.update(update_user_params) && errors.empty?
			render json: { user: UserSerializer.new(@user) }, status: :accepted
		else
			render json: { errors: (errors << @user.errors.full_messages).compact }, status: :declined
		end
	end

	private
	
	def new_user_params
		params.require(:user).permit(:first_name, :last_name, :username, :password)
	end

	def update_user_params
		params.require(:user).permit(:first_name, :last_name, :avatar_url, :password)
	end
end
