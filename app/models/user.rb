class User < ActiveRecord::Base
  has_secure_password
  has_many :reviews

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :password, length: {minimum: 5}, allow_nil: true
  validates :email, presence:true, uniqueness: true
  
end
