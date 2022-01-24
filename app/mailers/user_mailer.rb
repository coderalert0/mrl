class UserMailer < ApplicationMailer
  default from: email_address_with_name('gary@myresidencylist.com', 'Gary')
  before_action :load_user

  def welcome
    mail(
      to: email_address_with_name(@user.email, @user.first_name),
      subject: t(:welcome, scope: :email_subject)
    )
  end

  def upgrade
    mail(
      to: email_address_with_name(@user.email, @user.first_name),
      subject: t(:upgrade, scope: :email_subject)
    )
  end

  def load_user
    @user = params[:user]
  end
end
