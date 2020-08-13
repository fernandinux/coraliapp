class User < ApplicationRecord
  has_secure_password

  has_many :score_users
  has_many :events, through: :score_users

  has_many :credentials, as: :credentialable

  before_create do |user|
    user.credentials_count = 0
  end
end
