class UserDecorator < Draper::Decorator
  delegate_all

  def us_clinical_experience_display
    us_clinical_experience ? 'Yes' : 'No'
  end

  def passed_step_2cs_first_attempt_display
    passed_step_2cs_first_attempt ? 'Yes' : 'No'
  end

  def full_name_display
    "#{first_name} #{last_name}"
  end

  def paid_display
    paid? ? 'Yes' : 'No'
  end

  %i[created_at last_sign_in_at].each do |attribute|
    define_method :"#{attribute}_display" do
      send(attribute).try(:strftime, '%B %d, %Y')
    end
  end
end
