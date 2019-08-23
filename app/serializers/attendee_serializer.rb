class AttendeeSerializer < ActiveModel::Serializer
  
  attributes :id, :first_name, :full_name, :username, :avatar_url
end
