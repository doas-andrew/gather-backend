class FriendshipSerializer < ActiveModel::Serializer

  attributes :id, :friend

  def friend
  	ProfileSerializer.new(self.object.friend)
  end
end
