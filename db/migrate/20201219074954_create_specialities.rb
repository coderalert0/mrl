class CreateSpecialities < ActiveRecord::Migration[6.1]
  def change
    create_table :specialities do |t|
      t.string :name, null: false
      t.boolean :active
      t.timestamps
    end
  end
end
