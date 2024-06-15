class CreateMedicalSchools < ActiveRecord::Migration[6.1]
  def change
    create_table :medical_schools do |t|
      t.string :name, null: false
      t.timestamps
    end
  end
end
