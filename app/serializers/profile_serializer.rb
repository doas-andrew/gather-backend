class ProfileSerializer < ActiveModel::Serializer
	has_many :events
	
	attributes :id, :first_name, :full_name, :username, :avatar_url
end
