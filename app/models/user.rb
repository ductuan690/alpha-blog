class User < ActiveRecord::Base
  has_many :comments

  validates :username, presence: true,
            uniqueness: { case_sensitive: false },
            length: { minimum: 6, maximum: 20 }

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true,
            uniqueness: true,
            length: { maximum: 250 },
            format: { with: VALID_EMAIL_REGEX }
  
  has_secure_password
end