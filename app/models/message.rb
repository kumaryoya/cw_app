class Message < ApplicationRecord
  belongs_to :user
  belongs_to :room

  validates :body, presence: true
  validates :reservation_time, presence: true
  validates :done, presence: true
end
