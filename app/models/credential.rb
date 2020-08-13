class Credential < ApplicationRecord
  has_many :users
  has_many :events

  belongs_to :credentialable, polymorphic: true, counter_cache:true
end