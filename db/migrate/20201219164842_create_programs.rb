class CreatePrograms < ActiveRecord::Migration[6.1]
  def change
    create_table :programs do |t|
      t.string :name, null: false
      t.string :address
      t.string :acgme_program_code, null: false
      t.string :website
      t.string :phone
      t.string :email
      t.string :program_coordinator
      t.string :program_coordinator_email
      t.string :program_director
      t.string :minimum_step_1_score
      t.string :step_2_required
      t.string :minimum_step_2_score
      t.string :j_1_sponsorship_through_ecfmg
      t.string :h1_b
      t.string :f_1
      t.string :must_pass_step_2_cs_first_attempt
      t.string :us_md_graduates
      t.string :us_do_graduates
      t.string :non_us_citizen_international_medical_graduates
      t.string :us_citizen_international_medical_graduates
      t.boolean :us_clinical_experience
      t.integer :years_since_graduation
      t.string :notes
      t.integer :active
      t.references :speciality, null: false
      t.timestamps
    end
  end
end
