class DashboardController < ApplicationController
  def show
    @specialities = Speciality.where(active: true)
  end
end
