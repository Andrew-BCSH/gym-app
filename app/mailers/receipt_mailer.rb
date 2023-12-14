# app/mailers/receipt_mailer.rb
class ReceiptMailer < ApplicationMailer
  def send_receipt(receipt)
    @receipt = receipt
    mail(to: 'andrew.bcsh@outlook.com', subject: 'Receipt for Top-Up')
  end
end
