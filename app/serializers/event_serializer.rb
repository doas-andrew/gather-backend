class EventSerializer < ActiveModel::Serializer
	# has_many :users

  attributes :id, :organizer, :users, :title, :details, :category, :address, :city, :state, :date, :num_attendees

  def organizer
  	AttendeeSerializer.new(self.object.organizer)
  end

  def users
  	self.object.users.map{ |u| AttendeeSerializer.new(u) }
  end

  def num_attendees
  	self.object.users.count
  end
end
