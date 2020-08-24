# frozen_string_literal: true

class User < ActiveRecord::Base
  extend Devise::Models
  has_many :credentials
  has_many :events, through: :credentials
  enum role: %i[user institution admin].freeze

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  include DeviseTokenAuth::Concerns::User

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
end