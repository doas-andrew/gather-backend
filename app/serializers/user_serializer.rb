class UserSerializer < ActiveModel::Serializer

  has_many :messages
  # has_many :my_events
  has_many :events
  has_many :sent_messages
  has_many :friendships

  attributes :id, :first_name, :full_name, :username, :avatar_url, :inc_FR, :all_FR

  def inc_FR
  	self.object.recieved_friend_requests.map{|fr| {fr_id: fr.id}.merge(ProfileSerializer.new(fr.sender)) }
  end

  def all_FR
  	self.inc_FR.concat( self.object.sent_friend_requests.map{|fr| {fr_id: fr.id}.merge(ProfileSerializer.new(fr.recipient)) } )
  end
end
