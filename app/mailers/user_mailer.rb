class UserMailer < ApplicationMailer
  default from: 'no-reply@jungle.com'

  def confirmation_email(user)
    @user = user
    @url  = 'http://localhost:3000'
    mail(to: @user.email, subject: 'Your order has been confirmed!')
  end
end
