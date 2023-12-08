# app/models/class_schedule.rb
class ClassSchedule < ApplicationRecord
  belongs_to :user
  #has_one_attached :weekly_class_schedule
end
