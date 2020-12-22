class ProgramsController < ApplicationController
  load_and_authorize_resource :speciality
  load_and_authorize_resource :program

  def show; end

  def index
    @programs = Program
                .where(speciality: @speciality)
                .where('minimum_step_1_score <= ?', current_user.step_1_score.to_s)
                .where('minimum_step_2_score <= ?', current_user.step_2ck_score || 300)
                .where("#{current_user.img_type} > ?", 0)
                .where("#{current_user.visa} = ?", 'Yes')
                .order("#{current_user.img_type} DESC")
  end
end
