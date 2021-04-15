module ProgramConcern
  extend ActiveSupport::Concern

  def matching_programs
    @programs = @programs.where('minimum_step_1_score <= ?', current_user.step_1_score)
                         .where('minimum_step_2_score <= ?', current_user.step_2ck_score || 300)
                         .where("#{current_user.img_type} > ?", 0)
                         .where('years_since_graduation >= ? OR years_since_graduation IS NULL',
                                current_user.years_since_graduation)
                         .where(us_clinical_experience: [current_user.us_clinical_experience,
                                                         nil])

    visa_query.order("#{current_user.img_type} DESC")
  end

  def visa_query
    case current_user.visa
    when 'no'
      @programs.where('')
    when 'j1_or_h1'
      @programs.where('j_1_sponsorship_through_ecfmg = ? OR h1_b = ?', 'Yes', 'Yes')
    else
      @programs.where("#{current_user.visa} = ?", 'Yes')
    end
  end
end
