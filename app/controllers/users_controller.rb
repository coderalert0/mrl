class UsersController < ApplicationController
  def edit
    @form = EditUserForm.new user: current_user
  end

  def update
    @form = edit_form(current_user)

    if @form.submit
      flash.notice = 'User profile edited successfully'
      redirect_to root_path
    else
      flash.alert = @form.display_errors
      render 'edit'
    end
  end

  private

  def edit_form(user)
    form_params = params.require(:edit_user_form).permit(EditUserForm.accessible_attributes)
    EditUserForm.new form_params.merge(user: user)
  end
end
