class Member < ApplicationRecord
  belongs_to :room

  validates :cw_user_name, presence: true
  validates :cw_account_id, presence: true
end
