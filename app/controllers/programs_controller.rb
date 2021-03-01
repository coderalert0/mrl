class ProgramsController < ApplicationController
  load_and_authorize_resource :speciality
  load_and_authorize_resource :program, through: :speciality, find_by: :slug
  before_action :find_or_initialize_program_user, only: :show

  def show
    @form = CreateProgramNoteForm.new program_user: @program_user
    @program = @program.decorate
  end

  def index
    @programs = @programs.active.includes(:program_users)

    @matching_programs = if params['all'] == 'true'
                           @programs.order(:name)
                         else
                           @programs.where('minimum_step_1_score <= ?', current_user.step_1_score.to_s)
                                    .where('minimum_step_2_score <= ?', current_user.step_2ck_score || 300)
                                    .where("#{current_user.img_type} > ?", 0)
                                    .where("#{current_user.visa} = ?", 'Yes') # handle where user doesnt need visa
                                    .order("#{current_user.img_type} DESC")
                         end

    @matching_program_count = @matching_programs.count
    @matching_programs = @matching_programs.limit(5) unless current_user.paid?

    bookmark_count = ProgramUser.where(program: @matching_programs, user: current_user, bookmark: true).count
    @fee = calculate_fee(bookmark_count)
  end

  def edit
    @form = EditProgramForm.new program: @program
  end

  def update
    @form = edit_form

    if @form.submit
      flash.notice = 'Program edited successfully'
      redirect_to edit_speciality_program_path(@speciality, @program)
    else
      render 'edit'
    end
  end

  private

  def edit_form
    form_params = params.require(:edit_program_form).permit(EditProgramForm.accessible_attributes)
    EditProgramForm.new form_params.merge(program: @program)
  end

  def calculate_fee(bookmark_count)
    if bookmark_count.between?(1, 10)
      99
    elsif bookmark_count.between?(11, 20)
      16 * bookmark_count
    elsif bookmark_count.between?(21, 30)
      20 * bookmark_count
    elsif bookmark_count >= 31
      26 * bookmark_count
    else
      0
    end
  end

  def find_or_initialize_program_user
    @program_user = ProgramUser.find_or_initialize_by(program: @program, user: current_user)
  end
end
