class CreateProgramNoteForm < BaseForm
  attr_writer :program_user

  nested_attributes :note, to: :program_user

  accessible_attr :note

  def program_user
    @program_user ||= ProgramUser.new
  end

  def _submit
    program_user.save!
  end

  private

  def initialize(args = {})
    super args_key_first args, :program_user
  end
end
