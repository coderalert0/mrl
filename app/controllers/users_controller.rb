class UsersController < ApplicationController
  before_action :redirect_paid_user, except: %i[index show]
  load_and_authorize_resource :user, only: %i[show destroy]

  def show
    @user = @user.decorate
  end

  def index
    @users = User.includes(:visits, :events)
                 .where.not(email: '')
                 .order(created_at: :desc)

    @users = @users.decorate
  end

  def edit
    @form = EditUserForm.new user: current_user
  end

  def update
    @form = edit_form(current_user, @current_ability)

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

  def destroy
    if @user.destroy
      flash.notice = 'User successfully deleted'
      redirect_to users_path
    else
      render 'show'
    end
  end

  private

  def edit_form(user, ability)
    form_params = params.require(:edit_user_form).permit(EditUserForm.accessible_attributes)
    EditUserForm.new form_params.merge(user: user, ability: ability)
  end

  def redirect_paid_user
    redirect_to root_path unless current_ability.edit_profile?
  end
end
