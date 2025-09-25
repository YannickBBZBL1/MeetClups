class Club < ApplicationRecord
  has_paper_trail
  belongs_to :admin, class_name: 'User'

  has_many :club_memberships
  has_many :users, through: :club_memberships

  has_many :meetups

  validates :title, presence: true, uniqueness: true
  validates :admin_id, presence: true
end
