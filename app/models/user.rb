class User < ActiveRecord::Base
  before_save :downcase_email
  has_secure_password
  has_many :reviews

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :password, length: {minimum: 5}, allow_nil: true
  validates :email, presence:true, uniqueness: { case_sensitive: false }

  def authenticate_with_credentials(email, password)
    @user = User.find_by_email(email.strip.downcase)
    if @user && @user.authenticate(password)
      @user 
    end
  end 
  
  def downcase_email
    self.email.downcase!
  end 

end
