class UserDecorator < Draper::Decorator
  delegate_all

  def us_clinical_experience_display
    us_clinical_experience ? 'Yes' : 'No'
  end

  def passed_step_2cs_first_attempt_display
    passed_step_2cs_first_attempt ? 'Yes' : 'No'
  end

  def full_name_display
    "#{first_name} #{last_name}".titleize
  end

  def paid_display
    paid? ? 'Yes' : 'No'
  end

  def applicant_type_display
    I18n.t(img_type, scope: :img_types)
  end

  def visa_display
    I18n.t(visa, scope: :visa_types)
  end

  %i[created_at last_sign_in_at].each do |attribute|
    define_method :"#{attribute}_display" do
      send(attribute).try(:strftime, '%D')
    end
  end
end
