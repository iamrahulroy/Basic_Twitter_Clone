class User < ActiveRecord::Base
  attr_accessible :avatar_url, :email, :name, :password_digest, :username
  has_secure_password

  validates :name, presence: true

  validates :username, uniqueness: true, presence: true

  validates :email, uniqueness: true, presence: true, format: { with: /^[\w.+-]+@([\w]+.)+\w+$/}

  before_validation :prep_email
  before_save :create_avatar_url


  private
  def prep_email
  	self.email = self.email.strip.downcase if self.email
  end

  def create_avatar_url
    self.avatar_url = "http://www.gravatar.com/avatar/#{Digest::MD5.hexdigest(self.email)}?s=50"
end


end
