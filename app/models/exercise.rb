class Exercise < ApplicationRecord
  belongs_to :user

  validates :duration, numericality: { greater_than: 0.0 }
  validates :details, presence: true
  validates :activity_date, presence: true

  default_scope { where('activity_date > ?', 7.days.ago).order(activity_date: :desc) }
end
