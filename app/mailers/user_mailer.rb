class UserMailer < ApplicationMailer
  default from: 'noreply@todoapp.com'

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.confirmation_email.subject
  #
  def confirmation_email(user)
    @user = user
    @confirmation_url = confirm_email_url(token: user.confirmation_token)
    
    mail to: user.email, subject: 'Confirme seu cadastro na Todo App'
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.password_reset.subject
  #
  def password_reset(user)
    @user = user
    @reset_url = reset_password_url(token: user.reset_password_token)
    
    mail to: user.email, subject: 'Instruções para redefinir sua senha'
  end
end
