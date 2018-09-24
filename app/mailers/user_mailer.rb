class ArtistMailer < ApplicationMailer
  default from: 'noisaea-notifications@blooteevee.com'

  def subscriber_email(user)
    @user = user
    mail(to: @user.email, subject: 'You have some new subscribers | Bloo TeeVee')
  end

end