class MessageSerializer < ActiveModel::Serializer
  attributes :id, :subject, :content, :seen, :sender, :recipient, :date

  def sender
  	ProfileSerializer.new(self.object.sender)
  end

  def recipient
  	ProfileSerializer.new(self.object.recipient)
  end

  def date
    {
      full: self.object.created_at.strftime('%B %d, %Y'),
      ymd: self.object.created_at.strftime('%Y/%m/%d'),
      dmy: self.object.created_at.strftime('%d/%m/%Y'),
      mdy: self.object.created_at.strftime('%D')
    }
  end
end
