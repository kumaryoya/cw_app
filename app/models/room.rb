class Room < ApplicationRecord
  belongs_to :user

  validates :cw_room_name, presence: true
  validates :cw_room_id, presence: true
end
