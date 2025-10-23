class UserMailer < ApplicationMailer
  default from: "manan.sheth@freshworks.com"

  def booking_confirmation(user, booking)
    @user = User.find(2)
    @booking = Booking.find(4)
    puts "Inside email sending "
    mail(to: "manansheth1993@gmail.com", subject: "Your Booking Confirmation")
  end
end
