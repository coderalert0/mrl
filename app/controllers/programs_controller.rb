class ProgramsController < ApplicationController
  include ProgramConcern

  load_and_authorize_resource :speciality, find_by: :slug
  load_and_authorize_resource :program, through: :speciality, find_by: :slug
  layout :resolve_layout
  before_action :find_or_initialize_program_user, only: :show
  skip_before_action :authenticate_user, only: :show

  def show
    @form = CreateProgramNoteForm.new program_user: @program_user
    @program = @program.decorate
    render layout: current_user.nil? ? 'program' : 'application'
  end

  def index
    @programs = @programs.active.includes(:program_users)
    @matching_programs = if params['all'] == 'true'
                           @programs.order(:name)
                         elsif params['img'] == 'true'
                           @programs.where("#{current_user.img_type} > ?", 0).order(:name)
                         else
                           matching_programs
                         end

    @matching_program_count = @matching_programs.count
    @matching_programs = @matching_programs.first(5) unless current_user.paid?

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
      next_program = @program.speciality.programs.where("#{current_user.img_type} > ?", 0).order(:name).where(
        'name > ?', @program.name
      ).first
      redirect_to edit_speciality_program_path(@speciality, next_program)
    else
      render 'edit'
    end
  end

  private

  def resolve_layout
    'devise' if current_user.nil?
  end

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
