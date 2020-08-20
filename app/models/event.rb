class Event < ApplicationRecord
  has_many :score_users
  has_many :users, through: :score_users

  has_many :institution_events
  has_many :users, through: :institution_events
end