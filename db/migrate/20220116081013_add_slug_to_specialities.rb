class AddSlugToSpecialities < ActiveRecord::Migration[6.1]
  def change
    add_column :specialities, :slug, :string
    add_index :specialities, :slug, unique: true
  end
end
