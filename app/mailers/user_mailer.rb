class UserMailer < ApplicationMailer
  def created_user(user)
    @user = user
    mail(to: @user.email, subject: 'Account created')
  end
end