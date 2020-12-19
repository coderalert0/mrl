class RegistrationController < ApplicationController
  include Wicked::Wizard
  steps :profile, :user

  def show
    if @step == 'wicked_finish'
      sign_in_user
    else
      @form = send("show_#{step}_form")
      render_wizard
    end
  end

  def update
    @form = send("update_#{step}_form")
    session[:user_id] = @form.user.id if @form.submit
    render_wizard @form
  end

  private

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
    sign_in(user, bypass: true)
    redirect_to root_path
  end

  def user
    session[:user_id] ? User.find(session[:user_id]) : User.new
  end
end
