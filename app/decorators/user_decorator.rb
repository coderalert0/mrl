class UserDecorator < Draper::Decorator
  delegate_all

  def us_clinical_experience_display
    us_clinical_experience ? 'Yes' : 'No'
  end

  def step_2cs_fail_display
    step_2cs_fail ? 'Yes' : 'No'
  end
end
