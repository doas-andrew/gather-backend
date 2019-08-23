class Message < ApplicationRecord
  belongs_to :user
  belongs_to :sender, class_name: "User"
  belongs_to :recipient, class_name: "User"

  self.validates( :subject, length: { minimum: 1, maximum: 30 } )
  validates :content, length: {maximum: 999}
  
  after_create :create_copy

  def create_copy
    self.class.create({ 
      user_id: self.user_id == self.sender_id ? self.recipient.id : self.sender.id,
      sender_id: self.sender_id,
      recipient_id: self.recipient_id,

      subject: self.subject,
      content: self.content,
      seen: false,
      
      original_msg: false
    }) if self.original_msg
  end
end
