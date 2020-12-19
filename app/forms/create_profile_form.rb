class CreateProfileForm < BaseForm
  attr_writer :user

  nested_attributes :step_1_score, :step_2ck_score, :us_clinical_experience,
                    :visa, :img_type, :years_since_graduation, to: :user

  accessible_attr :step_1_score, :step_2ck_score, :us_clinical_experience,
                  :visa, :img_type, :years_since_graduation

  def user
    @user ||= User.new
  end

  def _submit
    user.save!
  end
  alias save submit

  private

  def initialize(args = {})
    super args_key_first args, :user
  end
end
