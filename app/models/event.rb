class Event < ApplicationRecord
	belongs_to :organizer, class_name: "User"
	has_many :attends
	has_many :users, through: :attends

  validates :title, { presence: true, length: {maximum: 40} }
  validates :details, { presence: true, length: {maximum: 999} }
  validates :category, :date, :address, :city, :state, presence: true
end
