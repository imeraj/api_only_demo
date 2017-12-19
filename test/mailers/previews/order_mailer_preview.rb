# Preview all emails at http://localhost:3000/rails/mailers/order_mailer
class OrderMailerPreview < ActionMailer::Preview
  def send_confirmation
    OrderMailer.send_confirmation(Order.first)
   end
end
