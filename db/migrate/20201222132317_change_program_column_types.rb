class ChangeProgramColumnTypes < ActiveRecord::Migration[6.1]
  def change
    change_column :programs, :minimum_step_1_score, 'integer USING CAST(minimum_step_1_score AS integer)'
    change_column :programs, :minimum_step_2_score, 'integer USING CAST(minimum_step_2_score AS integer)'
    change_column :programs, :us_md_graduates, 'integer USING CAST(us_md_graduates AS integer)'
    change_column :programs, :us_do_graduates, 'integer USING CAST(us_do_graduates AS integer)'
    change_column :programs, :non_us_citizen_international_medical_graduates, 'integer USING CAST(non_us_citizen_international_medical_graduates AS integer)'
    change_column :programs, :us_citizen_international_medical_graduates, 'integer USING CAST(us_citizen_international_medical_graduates AS integer)'
  end
end
