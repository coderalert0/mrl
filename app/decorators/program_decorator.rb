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

  %i[us_md_graduates us_do_graduates non_us_citizen_international_medical_graduates
     us_citizen_international_medical_graduates].each do |attribute|
    define_method :"#{attribute}_friendliness_score" do
      h.content_tag :div do
        h.concat h.content_tag :span, "#{friendliness_score(attribute)}/100",
                               class: friendliness_score_class(attribute)
      end
    end
  end

  def has_friendliness_data?
    (us_md_graduates + non_us_citizen_international_medical_graduates + us_citizen_international_medical_graduates + us_do_graduates).positive?
  end

  private

  def friendliness_score(attribute)
    if send(attribute).zero?
      other_applicant_types = User.img_types.keys.map(&:to_sym) - [attribute]
      other_applicant_type_sum = other_applicant_types.reduce(0) { |sum, attribute| sum + send(attribute).to_i }

      other_applicant_type_sum == 100 ? 0 : 100 - other_applicant_type_sum
    else
      send(attribute)
    end
  end

  def friendliness_score_class(img_type)
    percentage = friendliness_score(img_type)

    if percentage.zero?
      'text-muted'
    elsif percentage.positive? && percentage <= 25
      'text-warning'
    elsif percentage > 25 && percentage <= 50
      'text-info'
    elsif percentage > 50 && percentage <= 75
      'text-primary'
    else
      'text-success'
    end
  end
end
