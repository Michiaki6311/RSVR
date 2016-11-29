class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :facility

  validates :strat_time,
    presence: true

  validates :end_time,
    presence: true

  validates :facility_id,
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
    Reservation.where("strat_time >= ? AND strat_time < ? AND facility_id = ?",self.strat_time,self.end_time,self.facility_id).present? || Reservation.where("end_time > ? AND end_time <= ? AND facility_id = ?",self.strat_time,self.end_time,self.facility_id).present?
  end

  def date_uniqueness_two
    errors.add(:end_time,"その時間帯にはすでに予約があります。") if
    Reservation.where('strat_time <= ? AND end_time >= ? AND facility_id = ?',self.strat_time,self.end_time,self.facility_id).present?
  end
end
