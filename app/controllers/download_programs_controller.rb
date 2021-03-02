class DownloadProgramsController < ApplicationController
  load_and_authorize_resource :speciality
  before_action :authorize

  def index
    @programs = @speciality.programs.where('minimum_step_1_score <= ?', current_user.step_1_score.to_s)
                           .where('minimum_step_2_score <= ?', current_user.step_2ck_score || 300)
                           .where("#{current_user.img_type} > ?", 0)
                           .where("#{current_user.visa} = ?", 'Yes') # handle situation where user doesnt need visa
                           .order("#{current_user.img_type} DESC")

    respond_to do |format|
      format.html
      format.csv { send_data @programs.to_csv(current_user), filename: "#{@speciality.name}-#{Date.today}.csv" }
    end
  end

  private

  def authorize
    return if current_user.paid?

    flash[:alert] = 'You are not allowed to download the programs csv'
    redirect_to speciality_programs_path(@speciality)
  end
end
