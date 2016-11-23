class Facility < ApplicationRecord
  has_many :reservations
  has_many :users, through: :reserves
end
