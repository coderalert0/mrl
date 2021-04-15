class UserDecorator < Draper::Decorator
  delegate_all

  def us_clinical_experience_display
    us_clinical_experience ? 'Yes' : 'No'
  end

  def passed_step_2cs_first_attempt_display
    passed_step_2cs_first_attempt ? 'Yes' : 'No'
  end
end
