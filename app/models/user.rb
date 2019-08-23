class User < ApplicationRecord

  has_many :friendships, dependent: :destroy
  has_many :friends, through: :friendships

  has_many :attends
  has_many :events, through: :attends

  def my_events
    Event.where("organizer_id = ?", self.id)
  end

  def recieved_friend_requests
    FriendRequest.where("recipient_id = ?", self.id)
  end

  def sent_friend_requests
    FriendRequest.where("sender_id = ?", self.id)
  end

  def messages
    Message.where("user_id = ? AND recipient_id = ?", self.id, self.id).reverse
  end

  def sent_messages
    Message.where("user_id = ? AND sender_id = ?", self.id, self.id).reverse
  end

  #__________________________________________________

  NAME_REGEX = /\A[a-zA-Z -]*\z/i
  USERNAME_REGEX = /\A[a-zA-Z0-9_]*\z/i

  validates :username, {
    length: {minimum: 3, maximum: 20},
  	format: {with: USERNAME_REGEX},
  	uniqueness: {case_sensitive: false}
  }

  validates :password, {
    presence: true,
  	length: {minimum: 3, maximum: 20}
  }

  validates :first_name, :last_name, {
    presence: true,
    length: {maximum: 20},
    format: {with: NAME_REGEX}
  }

  #__________________________________________________

  before_create do
    self.login_name = self.username.downcase
    self.friend_settings = 'show-all'
  end

  before_save do
    self.new_names
    self.encrypt_new_passwords
  end

  before_destroy do
    Message.where("user_id = ?", self.id).destroy_all
  end

  #__________________________________________________

  def encrypt_new_passwords
    if self.password_changed?
      self.password = My_RSA.encrypt(self.password)
    end
  end

  def new_names
  	if self.first_name_changed?
  		self.first_name = self.first_name.strip
  	end

  	if self.last_name_changed?
  		self.last_name = self.last_name.strip
  	end

  	if self.first_name_changed? || self.last_name_changed?
  		self.full_name = [self.first_name, ' ', self.last_name].join
  	end
  end

  def authenticate(password)
    My_RSA::decrypt(self.password) == password
  end
end
