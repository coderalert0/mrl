class NotesController < ApplicationController
  load_and_authorize_resource :speciality, find_by: :slug
  load_and_authorize_resource :program, find_by: :slug

  def create
    @form = create_form

    if @form.submit
      ahoy.track("User added/edited a note: #{@program.name}")

      flash.notice = 'Program Note edited successfully'
      redirect_to speciality_program_path(@speciality, @program)
    else
      flash.alert = @form.display_errors
    end
  end

  private

  def create_form
    form_params = params.require(:create_program_note_form).permit(CreateProgramNoteForm.accessible_attributes)
    CreateProgramNoteForm.new form_params.merge(program_user: program_user)
  end

  def program_user
    ProgramUser.find_or_initialize_by(program: @program, user: current_user)
  end
end
