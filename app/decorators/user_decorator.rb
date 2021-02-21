class UserDecorator < Draper::Decorator
  delegate_all

  def us_clinical_experience_display
    us_clinical_experience ? 'Yes' : 'No'
  end
end
