class RegistrationController < ApplicationController
  include Wicked::Wizard
  steps :profile, :user

  def show
    if @step == 'wicked_finish'
      ahoy.track('Visitor signed up')

      send_emails

      sign_in_user
    else
      @form = send("show_#{step}_form")
      ahoy.track("Visitor viewed registration step: #{step}")

      render_wizard
    end
  end

  def update
    @form = send("update_#{step}_form")
    if @form.submit
      ahoy.track("Visitor submitted registration step: #{step}")

      session[:user_id] = @form.user.id
    end
    render_wizard @form
  end

  private

  def send_emails
    UserMailer.with(user: user).welcome.deliver_later
  end

  def show_profile_form
    CreateProfileForm.new(user: user)
  end

  def show_user_form
    CreateUserForm.new(user: user)
  end

  def update_profile_form
    CreateProfileForm.new params.require(:create_profile_form)
                                .permit(CreateProfileForm.accessible_attributes)
                                .merge(user: user)
  end

  def update_user_form
    CreateUserForm.new params.require(:create_user_form)
                             .permit(CreateUserForm.accessible_attributes)
                             .merge(user: user)
  end

  def sign_in_user
    if sign_in(user, bypass: true)
      user.update(sign_in_count: 1, last_sign_in_at: DateTime.now)
      ahoy.authenticate(user)
    end
    redirect_to root_path
  end

  def user
    session[:user_id] ? User.find(session[:user_id]) : User.new
  end
end
