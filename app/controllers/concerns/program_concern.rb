module ProgramConcern
  extend ActiveSupport::Concern

  def matching_programs
    @programs = @programs.where('minimum_step_1_score <= ?', current_user.step_1_score)
                         .where('minimum_step_2_score <= ?', current_user.step_2ck_score || 300)
                         .where('years_since_graduation >= ? OR years_since_graduation IS NULL',
                                current_user.years_since_graduation)
                         .where(us_clinical_experience: [current_user.us_clinical_experience,
                                                         nil])

    visa_query
    step_2_cs_query
    sort_query
  end

  def sort_query
    @programs = @programs.select do |program|
      program.percentage(current_user.img_type) >= current_user.friendliness_threshold
    end
    @programs.sort_by { |program| program.percentage(@current_user.img_type) }.reverse
  end

  def visa_query
    @programs = case current_user.visa
                when 'no'
                  @programs.where('')
                when 'j1_or_h1'
                  @programs.where('j_1_sponsorship_through_ecfmg = ? OR h1_b = ?', 'Yes', 'Yes')
                else
                  @programs.where("#{current_user.visa} = ?", 'Yes')
                end
  end

  def step_2_cs_query
    if current_user.passed_step_2cs_first_attempt
      @programs
    else
      @programs.where('must_pass_step_2_cs_first_attempt = ?', 'No')
    end
  end
end
