# frozen_string_literal: true

class User < ActiveRecord::Base
  extend Devise::Models
  has_many :credentials
  has_many :lists, through: :credentials

  has_many :score_users
  has_many :events, through: :score_users

  has_many :institution_events
  has_many :events, through: :institution_events

  has_many :designs
  has_many :lists
  has_one_attached :image
  enum role: %i[user institution admin].freeze

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  include DeviseTokenAuth::Concerns::User
  include Rails.application.routes.url_helpers

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
    begin
      url_for(self.image)
    rescue => exception
      nil
    end
  end
end
