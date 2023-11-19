class Room < ApplicationRecord
  belongs_to :user
  has_many :members, dependent: :destroy

  validates :cw_room_name, presence: true
  validates :cw_room_id, presence: true
end
