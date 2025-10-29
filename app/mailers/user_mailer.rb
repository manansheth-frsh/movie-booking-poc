class UserMailer < ApplicationMailer
  default from: "manan.sheth@freshworks.com"

  def booking_confirmation(user, booking)
    @user = User.find(2)
    @booking = Booking.find(4)
    puts "Inside email sending "
    mail(to: @user.email, subject: "Your Booking Confirmation")
  end

  def reminder_email(user, booking)
    @user = user
    @booking = booking
    @show = booking.show
    mail(
      to: @user.email,
      subject: "Reminder: Your booking for #{@show.movie.name} is today!"
    )
  end

end
