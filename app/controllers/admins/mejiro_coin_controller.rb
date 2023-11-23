# app/controllers/admins/mejiro_coin_controller.rb

class Admins::MejiroCoinController < ApplicationController
  include Admins::MejiroCoinHelper


  def index
    @transactions = MejiroCoinTransaction.all

    # Apply filters
    @transactions = @transactions.where(username: params[:username]) if params[:username].present?
    @transactions = @transactions.where(product: params[:product]) if params[:product].present?
    @transactions = @transactions.where(date: params[:date]) if params[:date].present?
    @transactions = @transactions.where(spend: params[:spend]) if params[:spend].present?
    @transactions = @transactions.where(time: params[:time]) if params[:time].present?

    # Calculate totals
    @total_spend_day = @transactions.where('created_at >= ?', Time.zone.now.beginning_of_day).sum(:spend_amount)
    @total_spend_week = @transactions.where('created_at >= ?', 1.week.ago).sum(:spend_amount)
    @total_spend_month = @transactions.where('created_at >= ?', 1.month.ago).sum(:spend_amount)
    @total_top_up_today = TopUp.where('created_at >= ?', Time.zone.now.beginning_of_day).sum(:amount_cents)
    @total_top_up_week = TopUp.where('created_at >= ?', 1.week.ago).sum(:amount_cents)
    @total_top_up_month = TopUp.where('created_at >= ?', 1.month.ago).sum(:amount_cents)

    render :index
  end
end
