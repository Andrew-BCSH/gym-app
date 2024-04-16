# app/models/class_schedule.rb
class ClassSchedule < ApplicationRecord
  belongs_to :scheduleable, polymorphic: true
  #has_one_attached :weekly_class_schedule
end

class Admin < ApplicationRecord
  has_many :class_schedules, as: :scheduleable
end

class User < ApplicationRecord
  has_many :class_schedules, as: :scheduleable
end
