class Activity < ApplicationRecord
  belongs_to :project
  belongs_to :user
  belongs_to :customer
  belongs_to :invoice, optional: true

  validates :description, presence: true
  validates :project, presence: true
  validates :start_time, presence: true
  validates :end_time, presence: true
end
