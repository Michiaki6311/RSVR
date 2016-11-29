class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :facility

  validates :strat_time,
    presence: true

  validates :end_time,
    presence: true

  validate :date_cannot_be_in_the_past,
    :date_validate,
    :date_uniqueness,
    :date_uniqueness_two


  def date_validate
    errors.add(:end_time,"日付を正しく記入してください。") unless
    self.strat_time < self.end_time
  end

  def date_cannot_be_in_the_past
    errors.add(:end_time,"過去の日付は入力できません。") unless
    (self.strat_time - DateTime.now).to_i > 0
  end

  def date_uniqueness
    errors.add(:end_time,"その時間帯にはすでに予約があります。") if
    Reservation.where(strat_time: (self.strat_time)...(self.end_time)).present? || Reservation.where(end_time: ((self.strat_time)+Rational(1, 24 * 60 * 60))..(self.end_time)).present?
  end

  def date_uniqueness_two
    errors.add(:end_time,"その時間帯にはすでに予約があります。") if
    Reservation.where('strat_time <= ? AND end_time >= ?',self.strat_time,self.end_time).present?
  end
end
