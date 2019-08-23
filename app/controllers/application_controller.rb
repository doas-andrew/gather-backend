class ApplicationController < ActionController::API
	before_action :authorize

	JWT_KEY = File.read(File.expand_path('../keys/jwt_key.txt', __dir__))

	def jwt_encode (payload)
			JWT.encode(payload, JWT_KEY)
	end

	def authorize
		if not logged_in?
			render json: { errors: ['Please log in.'] }, status: :unauthorized
		end
	end

	def logged_in?
		!!current_user
	end

	def current_user
		begin
			user_id = JWT.decode(self.request.headers['Authorization'], JWT_KEY)[0]['user_id']
			@user = User.find(user_id)
			rescue
		end
		@user
	end
end
