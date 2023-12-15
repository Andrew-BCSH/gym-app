# app/controllers/admins/weekly_class_schedule_controller.rb
class Admins::WeeklyClassScheduleController < AdminController
  before_action :authenticate_admin!

  def index
    @admin = current_admin
    @admin ||= Admin.new  # If current_admin is nil, create a new Admin instance
  end

  # app/controllers/admins/weekly_class_schedule_controller.rb
def update
  @admin = current_admin
  if @admin.update(admin_params)
    flash[:notice] = 'Class schedule updated successfully.'
  else
    flash[:alert] = 'Failed to update class schedule.'
    Rails.logger.error(@admin.errors.full_messages)  # Log errors for debugging
  end
  redirect_to admins_weekly_class_schedule_index_path
end


  private

  def admin_params
    params.require(:admin).permit(:weekly_class_schedule)
  end
end
