class UserMailer < ActionMailer::Base
  default from: "info@menumap.co.kr"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.account_activation.subject
  #
  def account_activation(user)
		@user = user
		mail to: user.email, subject: "MenuMap 계정을 활성화해주세요."
  end

  def password_reset
    @greeting = "Hi"

    mail to: "to@example.org"
  end
end
