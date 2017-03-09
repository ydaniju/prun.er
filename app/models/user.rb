# frozen_string_literal: true
class User < ActiveRecord::Base
  attr_accessor :remember_token
  has_many :links, dependent: :destroy

  scope :top_users, -> { order(links_count: :desc).limit(9) }

  before_save { self.email = email.downcase }

  validates :username, length: { maximum: 50 }, presence: true

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :email, presence: true, length: { maximum: 30 }, format: { with:
  VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }

  has_secure_password

  validates :password, presence: true, length: { minimum: 8 }

  def self.digest(string)
    cost = BCrypt::Engine.cost
    if ActiveModel::SecurePassword.min_cost
      cost = BCrypt::Engine::MIN_COST
    end
    BCrypt::Password.create(string, cost: cost)
  end

  def self.new_token
    SecureRandom.urlsafe_base64
  end

  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  def forget
    update_attribute(:remember_digest, nil)
  end
end
