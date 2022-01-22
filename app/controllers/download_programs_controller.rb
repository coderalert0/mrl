class DownloadProgramsController < ApplicationController
  include ProgramConcern

  load_and_authorize_resource :speciality, find_by: :slug
  before_action :authorize

  def index
    @programs = @speciality.programs

    respond_to do |format|
      format.html
      format.csv do
        send_data Program.to_csv(matching_programs, current_user), filename: "#{@speciality.name}-#{Date.today}.csv"
      end
    end
  end

  private

  def authorize
    return if current_user.paid?

    flash[:alert] = 'You are not allowed to download the programs csv'
    redirect_to speciality_programs_path(@speciality)
  end
end
