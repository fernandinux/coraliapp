class Credential < ApplicationRecord
  belongs_to :event
  belongs_to :user
  enum type: %i[proof certificate].freeze
  enum status: %i[sent received].freeze
end
