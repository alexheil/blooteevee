class UserMailer < ApplicationMailer
  default from: 'noisaea-notifications@blooteevee.com'

  def subscriber_email(user)
    @user = user
    mail(to: @user.email, subject: 'You have new subscribers | Bloo TeeVee')
  end

end