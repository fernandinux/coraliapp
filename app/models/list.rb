class List < ApplicationRecord
  has_many :credentials
  has_many :users, through: :credentials
  
  belongs_to :event
  belongs_to :user
  has_one :design
end