class CreateProgramUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :program_users do |t|
      t.references :program, null: false
      t.references :user, null: false
      t.boolean :bookmark
      t.string :note
      t.timestamps
    end
  end
end
