# frozen_string_literal: true

class User < ActiveRecord::Base
  extend Devise::Models
  has_many :credentials
  has_many :events, through: :credentials
  enum role: %i[user institution admin].freeze

  has_one_attached :image

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  include DeviseTokenAuth::Concerns::User
  include Rails.application.routes.url_helpers

  has_many :credentials

  def isInstitution?
    return self.role == 'institution'
  end

  def isUser?
    return self.role == 'user'
  end

  def isAdmin?
    return self.role == 'admin'
  end

  def get_user_image_url
    url_for(self.image)
  end
end
