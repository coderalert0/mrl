class EditProgramForm < BaseForm
  attr_writer :program

  nested_attributes :name, :address, :acgme_program_code, :website, :phone, :email, :program_coordinator,
                    :program_coordinator_email, :program_director, :minimum_step_1_score, :step_2_required,
                    :minimum_step_2_score, :j_1_sponsorship_through_ecfmg, :h1_b,
                    :must_pass_step_2_cs_first_attempt, :us_md_graduates, :us_do_graduates,
                    :non_us_citizen_international_medical_graduates, :us_citizen_international_medical_graduates,
                    :us_clinical_experience, :years_since_graduation, :notes, :active, :speciality_id, to: :program

  accessible_attr :name, :address, :acgme_program_code, :website, :phone, :email, :program_coordinator,
                  :program_coordinator_email, :program_director, :minimum_step_1_score, :step_2_required,
                  :minimum_step_2_score, :j_1_sponsorship_through_ecfmg, :h1_b,
                  :must_pass_step_2_cs_first_attempt, :us_md_graduates, :us_do_graduates,
                  :non_us_citizen_international_medical_graduates, :us_citizen_international_medical_graduates,
                  :us_clinical_experience, :years_since_graduation, :notes, :active, :speciality_id

  def program
    @program ||= Program.new
  end

  def _submit
    program.save!
  end

  private

  def initialize(args = {})
    super args_key_first args, :program
  end
end
