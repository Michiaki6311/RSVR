class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  belongs_to :user_interim_registrations
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+.[a-z]+\z/i

  after_initialize :set_access_token

  validates :email,
    presence: true,
    length: { maximum: 255 },
    format: { with: VALID_EMAIL_REGEX },
    uniqueness: { case_sensitive: false }
  validates :name,
    presence: true,
    length: { maximum: 50 }
  validates :phone_number,
    presence: true,
    length: { maximum: 16 },
    uniqueness: true
  validates_uniqueness_of :access_token
  validates_presence_of :access_token

  before_save do
    self.email = self.email.downcase
  end

  has_secure_password

  # Class methods
  class << self
    def digest(string)
      cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
        BCrypt::Engine.cost
      BCrypt::Password.create(string, cost: cost)
    end
  end

  private
  def set_access_token
    self.access_token = self.access_token.blank? ? generate_access_token : self.access_token
  end

  def generate_access_token
    tmp_token = SecureRandom.urlsafe_base64(6)
    self.class.where(:access_token => tmp_token).blank? ? tmp_token : generate_access_token
  end
end
