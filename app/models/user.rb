class User < ApplicationRecord
  before_save { self.email = self.email.downcase }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
    format: { with: VALID_EMAIL_REGEX },
    uniqueness: { case_sensitive: false }
  validates_uniqueness_of :access_token
  validates_presence_of :access_token
  after_initialize :set_access_token
  validates :name, presence: true, length: { maximum: 50 }
  validates :phone_number, presence: true, length: { maximum: 16 },
    uniqueness: true
  has_secure_password
  private
  def set_access_token
    self.access_token = self.access_token.blank? ? generate_access_token : self.access_token
  end

  def generate_access_token
    tmp_token = SecureRandom.urlsafe_base64(6)
    self.class.where(:access_token => tmp_token).blank? ? tmp_token : generate_access_token
  end
end
