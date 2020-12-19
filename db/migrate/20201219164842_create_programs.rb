class CreatePrograms < ActiveRecord::Migration[6.1]
  def change
    create_table :programs do |t|
      t.string :name, null: false
      t.string :accreditation_id, null: false
      t.string :address
      t.string :city
      t.string :state
      t.string :zip_code
      t.string :program_director_name
      t.string :phone
      t.string :email
      t.boolean :non_caribbean_img_friendly
      t.boolean :caribbean_img_friendly
      t.boolean :j1_visa
      t.boolean :h1_visa
      t.boolean :us_clinical_experience
      t.integer :minimum_step_1_score
      t.integer :minimum_step_2ck_score
      t.string :step_1_notes
      t.string :step_2ck_notes
      t.boolean :step_1_failure
      t.boolean :step_2ck_failure
      t.boolean :step_2cs_failure
      t.integer :years_since_graduation
      t.string :notes
      t.string :website
      t.integer :active
      t.timestamps
    end
  end
end
