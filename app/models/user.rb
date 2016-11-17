class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :confirmable, :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+.[a-z]+\z/i
  VALID_PHONE_REGEX = /\A\d+-\d+-\d+\z/

  validates :email,
    presence: true,
    length: { maximum: 255 },
    format: { with: VALID_EMAIL_REGEX },
    uniqueness: { case_sensitive: false }

  validates :name,
    presence: true,
    on: :update

  validates :phone_number,
    presence: true,
    format: { with: VALID_PHONE_REGEX },
    on: :update

  validates :password,
    presence: true,
    length: { minimum: 6 },
    on: :update
  validates_confirmation_of :password


  before_save do
    self.email = self.email.downcase
  end

  def password_required?
    super if confirmed?
  end

end
