class ProgramDecorator < Draper::Decorator
  include ProgramConcern

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
     us_citizen_international_medical_graduates].each do |type|
    define_method :"#{type}_friendliness_score" do
      h.content_tag :div do
        h.concat h.content_tag :span, "#{percentage(type.to_s)}%", class: friendliness_score_class(type.to_s)
      end
    end
  end

  def friendliness_data?
    medical_schools.present? || (us_md_graduates + non_us_citizen_international_medical_graduates + us_citizen_international_medical_graduates + us_do_graduates).positive?
  end

  private

  def friendliness_score_class(img_type)
    percentage = percentage(img_type)

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
