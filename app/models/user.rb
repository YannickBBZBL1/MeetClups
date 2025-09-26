class User < ApplicationRecord
  has_paper_trail
  has_secure_password
  has_many :sessions, dependent: :destroy
  has_many :club_memberships
  has_many :clubs, through: :club_memberships

  has_many :meetup_participants
  has_many :meetups, through: :meetup_participants

  has_many :meetups_organized, class_name: 'Meetup', foreign_key: 'organizer_id'
  has_many :clubs_admin, class_name: 'Club', foreign_key: 'admin_id'

  validates :username, presence: true, uniqueness: true
  validates :email_address, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password, length: { minimum: 8 }, if: -> { password.present? }

  normalizes :email_address, with: ->(e) { e.strip.downcase }

  enum :role, { user: 0, moderator: 1, admin: 2 }

  after_initialize do
    if new_record? && role.nil?
      self.role = :user
    end
  end
end
