class DashboardController < ApplicationController
  def show
    ahoy.track('User visited dashboard')

    redirect_to registration_path(:profile) if current_user.nil?
    @specialities = Speciality.where(active: true).order(:name)
  end
end
