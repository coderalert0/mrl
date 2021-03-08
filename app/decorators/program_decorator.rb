class ProgramDecorator < Draper::Decorator
  delegate_all

  def us_clinical_experience_display
    us_clinical_experience ? 'Yes' : 'No'
  end

  def visa_types_sponsored_display
    output = []
    %i[j_1_sponsorship_through_ecfmg h1_b].each do |visa_type|
      output << visa_type if send(visa_type) == 'Yes'
    end
    output.map { |visa_type| I18n.t(visa_type, scope: :visa_types) }.join(', ')
  end

  def match_score_display; end
end
