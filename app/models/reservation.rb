class Reservation < ApplicationRecord
  belongs_to :room

  validates :start_day, presence: true
  validates :end_day, presence: true
  validates :number_of_people, presence: true

  validate :end_day_not_before_start_day
  validate :start_day_not_before_today

  private
    def end_day_not_before_start_day
      if end_day && start_day
        errors.add(:end_day, 'は開始日より後の日付を選択して下さい') if end_day < start_day
      end
    end

    def start_day_not_before_today
      if start_day.present? && start_day < Date.yesterday
        errors.add(:start_day, 'は現在日より後の日付を選択して下さい')
      end
    end
end
