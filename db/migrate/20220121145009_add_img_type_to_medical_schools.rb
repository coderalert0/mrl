class AddImgTypeToMedicalSchools < ActiveRecord::Migration[6.1]
  def change
    add_column :medical_schools, :img_type, :integer
  end
end
