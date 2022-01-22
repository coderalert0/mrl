class AddCountToMedicalSchoolPrograms < ActiveRecord::Migration[6.1]
  def change
    add_column :medical_school_programs, :percentage, :integer
  end
end
