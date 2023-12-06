class WeeklyClassScheduleController < ApplicationController

  def weekly_class_schedule
    @user = current_user # Or however you retrieve the user in your application
  end
end
