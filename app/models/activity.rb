class TimeValidator < ActiveModel::Validator
  def validate(record)
    if !record.end_time.nil? && !record.start_time.nil?
      if record.end_time <= record.start_time
        record.errors[:base] << "End time must be after start time"
      end
    end
  end
end

class Activity < ApplicationRecord
  belongs_to :project
  belongs_to :user
  belongs_to :customer
  belongs_to :invoice, optional: true

  validates :description, presence: true
  validates :project, presence: true
  validates :start_time, presence: true
  validates :end_time, presence: true
  validates_with TimeValidator
end
