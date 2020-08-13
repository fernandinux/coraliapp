class Event < ApplicationRecord
  has_many :score_users
  has_many :users, through: :score_users

  has_many :organization_events
  has_many :organizations, through: :organization_events, as: :organiable

  before_create do |event|
    event.organizations_count = 0
  end
end