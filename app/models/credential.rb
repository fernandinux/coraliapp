class Credential < ApplicationRecord
  belongs_to :event, optional: true
  belongs_to :user, optional: true
  enum type: %i[proof certificate].freeze
  enum status: %i[sent received].freeze
end
