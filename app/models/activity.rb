class Activity < ApplicationRecord
  belongs_to :project
  belongs_to :user
  belongs_to :customer

  validates :description, presence: true
  validates :project, presence: true
  validates :start_time, presence: true
  validates :end_time, presence: true
end
