class Credential < ApplicationRecord
  include Rails.application.routes.url_helpers

  has_one_attached :file
  belongs_to :event, optional: true
  belongs_to :user, optional: true
  enum type: %i[proof certificate].freeze
  enum status: %i[sent received].freeze

  # validates :file, {
  #   presence: true
  # }
  
  def get_credential_file_url
    url_for(self.file)
  end
end
