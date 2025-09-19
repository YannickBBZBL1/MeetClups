class User < ApplicationRecord
  has_secure_password
  has_many :sessions, dependent: :destroy
  has_many :club_memberships
  has_many :clubs, through: :club_memberships

  has_many :meetup_participants
  has_many :meetups, through: :meetup_participants

  has_many :meetups_organized, class_name: 'Meetup', foreign_key: 'organizer_id'
  has_many :clubs_admin, class_name: 'Club', foreign_key: 'admin_id'

  validates :username, presence: true, uniqueness: true
  add_index :users, :username, unique: true

  normalizes :email_address, with: ->(e) { e.strip.downcase }
end
