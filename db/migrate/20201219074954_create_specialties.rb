class CreateSpecialties < ActiveRecord::Migration[6.1]
  def change
    create_table :specialties do |t|
      t.string :name, null: false
      t.boolean :enabled
      t.timestamps
    end
  end
end
