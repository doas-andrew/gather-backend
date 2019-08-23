class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: "User"

  after_create :create_inverse, unless: :has_inverse?
  after_destroy :destroy_inverses, if: :has_inverse?

  def create_inverse
    self.class.create(inverse_friendship_options)
  end

  def destroy_inverses
    self.inverses.destroy_all
  end

  def inverses
    self.class.where(inverse_friendship_options)
  end

  def has_inverse?
    self.class.exists?(inverse_friendship_options)
  end

  def inverse_friendship_options
    {
      user_id: self.friend_id,
      friend_id: self.user_id
    }
  end
end
