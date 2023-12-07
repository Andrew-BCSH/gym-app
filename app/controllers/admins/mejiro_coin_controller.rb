# app/controllers/admins/mejiro_coin_controller.rb

# app/controllers/admins/mejiro_coin_controller.rb
class Admins::MejiroCoinController < ApplicationController
  include Admins::MejiroCoinHelper

  def index
    @receipts = Receipt.all

    # Apply filters
    @receipts = @receipts.joins(:user).where(users: { username: params[:username] }) if params[:username].present?
    @receipts = @receipts.where(product: params[:product]) if params[:product].present?
    @receipts = @receipts.where(date: params[:date]) if params[:date].present?
    @receipts = @receipts.where('product_price <= ?', params[:spend].to_i) if params[:spend].present?
    @receipts = @receipts.where(time: params[:time]) if params[:time].present?

    # Calculate totals
    @total_spend_day = @receipts.where('timestamp >= ?', Time.zone.now.beginning_of_day).sum(:product_price)
    @total_spend_week = @receipts.where('timestamp >= ?', 1.week.ago).sum(:product_price)
    @total_spend_month = @receipts.where('timestamp >= ?', 1.month.ago).sum(:product_price)
    @total_top_up_today = TopUp.where('created_at >= ?', Time.zone.now.beginning_of_day).sum(:amount_cents)
    @total_top_up_week = TopUp.where('created_at >= ?', 1.week.ago).sum(:amount_cents)
    @total_top_up_month = TopUp.where('created_at >= ?', 1.month.ago).sum(:amount_cents)

    render :index
  end
end
