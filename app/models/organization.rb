class Organization < ApplicationRecord
  has_many :organization_events
  has_many :events, through: :organization_events

  belongs_to :organiable, polymorphic: true, counter_cache:true
end