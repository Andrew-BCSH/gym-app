
class Admins::MejiroCoinController < AdminController
  include Admins::MejiroCoinHelper

  def index
    @receipts = Receipt.all

    # Apply filters
    @receipts = @receipts.joins(:user).where(users: { username: params[:username] }) if params[:username].present?
    @receipts = @receipts.where(product: params[:product]) if params[:product].present?
    @receipts = @receipts.where(date: params[:date]) if params[:date].present?
    @receipts = @receipts.where('product_price <= ?', params[:spend].to_i) if params[:spend].present?
    @receipts = @receipts.where(time: params[:time]) if params[:time].present?

    # Paginate the @receipts collection
    @receipts = @receipts.order(timestamp: :desc).paginate(page: params[:page], per_page: 10)

    # Calculate totals
    @total_spend_day = @receipts.where('timestamp >= ?', Time.zone.now.beginning_of_day).sum(:product_price)
    @total_spend_week = @receipts.where('timestamp >= ?', 1.week.ago).sum(:product_price)
    @total_spend_month = @receipts.where('timestamp >= ?', 1.month.ago).sum(:product_price)
    @total_credit_today = Receipt.where("DATE(timestamp) = ?", Date.today).sum(:credit_amount)
    @total_credit_week = Receipt.where("timestamp >= ? AND timestamp <= ?", Date.today.beginning_of_week, Date.today.end_of_week).sum(:credit_amount)
    @total_credit_month = Receipt.where("DATE_PART('month', timestamp) = ? AND DATE_PART('year', timestamp) = ?", Date.today.month, Date.today.year).sum(:credit_amount)


    render :index
  end

  def add_credit
    @user = User.find_by(id: params[:user_id])  # Changed to params[:user_id]

    if @user
      credit_amount = params[:credit_amount].to_i
      puts "Params Credit Amount: #{params[:credit_amount]}"
      puts "Credit Amount: #{credit_amount}"

      @credit = @user.credit

      if @credit
        # Update the balance by adding the credit amount
        @credit.update(balance: @credit.balance + credit_amount)
        flash[:notice] = 'Credit added successfully.'

        # Create a receipt for the Mejiro Coin top-up
        receipt = Receipt.create(
          user_id: @user.id,
          timestamp: Time.now,
          credit_amount: credit_amount
        )

        puts "Receipt ID: #{receipt.id}"  # Add this line to check the receipt ID

        # Create a top-up record
        TopUp.create(
          user_id: @user.id,
          amount_cents: credit_amount * 100  # Assuming amount_cents is in cents
        )
      else
        flash[:alert] = 'Credit record not found for the user.'
      end
    else
      flash[:alert] = 'User not found.'
    end

    # Respond with a redirect or other response if needed
    redirect_to admins_mejiro_coin_records_path
  end
end
