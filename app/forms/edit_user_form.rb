class EditUserForm < BaseForm
  nested_attributes :img_type, :step_1_score, :step_2ck_score, :step_1_fail, :step_2ck_fail,
                    :passed_step_2cs_first_attempt, :us_clinical_experience, :years_since_graduation, :visa, to: :user

  accessible_attr :img_type, :step_1_score, :step_2ck_score, :step_1_fail, :step_2ck_fail,
                  :passed_step_2cs_first_attempt, :us_clinical_experience, :years_since_graduation, :visa

  validate :disable_if_paid

  attr_accessor :user, :ability

  def _submit
    user.save!
  end

  private

  def initialize(args = {})
    super args_key_first args, :user
  end

  def disable_if_paid
    errors.add(:base, 'You cannot edit your profile') unless ability.edit_profile?
  end
end
