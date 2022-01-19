class CreateMedicalSchoolPrograms < ActiveRecord::Migration[6.1]
  def change
    create_table :medical_school_programs do |t|
      t.references :program, null: false
      t.references :medical_school, null: false
      t.timestamps
    end
  end
end
