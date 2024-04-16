# app/controllers/admins/weekly_class_schedule_controller.rb
class Admins::WeeklyClassScheduleController < AdminController
  before_action :authenticate_admin!
  before_action :set_weekly_class_schedule, only: [:index, :update]

  def new
    @admin = current_admin || Admin.new
    # Your other logic here
  end

  def index
    flash.now[:notice] = 'You are uploading a new weekly class schedule.'
  end

  def update
    if @admins_weekly_class_schedule.update(admins_weekly_class_schedule_params)
      flash[:notice] = 'Class schedule updated successfully.'
      redirect_to admins_weekly_class_schedule_index_path
    else
      flash[:alert] = 'Failed to update class schedule.'
      render :index
    end
  end

  private

  def set_weekly_class_schedule
    @admins_weekly_class_schedule = current_admin.weekly_class_schedule || current_admin.build_weekly_class_schedule
  end

  def admins_weekly_class_schedule_params
    params.require(:admins_weekly_class_schedule).permit(:weekly_class_schedule)
  end
end
