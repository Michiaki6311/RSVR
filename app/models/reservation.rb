class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :facility

  validates :strat_time,
    presence: true

  validates :end_time,
    presence: true

  validate :date_cannot_be_in_the_past

  validate :date_validate


  def date_validate
    errors.add(:end,"の日付を正しく記入してください。") unless
    self.strat_time < self.end_time
  end

  def date_cannot_be_in_the_past
    errors.add(:end,"の日付を正しく記入してください。") unless
    (self.strat_time - DateTime.now).to_i > 0
  end

end
