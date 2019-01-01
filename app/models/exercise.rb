class Exercise < ApplicationRecord
  belongs_to :user

  validates :duration, numericality: { greater_than: 0.0 }
  validates :details, presence: true
  validates :activity_date, presence: true
end
