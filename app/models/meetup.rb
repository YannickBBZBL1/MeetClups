class Meetup < ApplicationRecord
  has_paper_trail
  belongs_to :organizer, class_name: 'User'
  belongs_to :club

  has_many :meetup_participants
  has_many :users, through: :meetup_participants

  validates :title, presence: true
  validates :datetime, presence: true
  validates :location, presence: true
  validates :club_id, presence: true
  validates :organizer_id, presence: true
  validates :max_participants, numericality: { only_integer: true, greater_than: -1 }
end
