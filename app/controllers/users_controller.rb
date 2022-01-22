class UsersController < ApplicationController
  before_action :redirect_paid_user, except: :index

  def index
    @users = User.where.not(email: '').decorate.order(created_at: :desc)
  end

  def edit
    @form = EditUserForm.new user: current_user
  end

  def update
    @form = edit_form(current_user)

    if @form.submit
      ahoy.track('User updated profile')

      flash.notice = 'User profile edited successfully'
      redirect_to root_path
    else
      ahoy.track('User failed to update profile')

      flash.alert = @form.display_errors
      redirect_to edit_user_path
    end
  end

  private

  def edit_form(user)
    form_params = params.require(:edit_user_form).permit(EditUserForm.accessible_attributes)
    EditUserForm.new form_params.merge(user: user)
  end

  def redirect_paid_user
    redirect_to root_path if current_user.paid
  end
end
