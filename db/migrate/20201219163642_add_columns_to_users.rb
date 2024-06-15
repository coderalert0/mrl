class AddColumnsToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :img_type, :integer, null: false
    add_column :users, :step_1_score, :integer, null: false
    add_column :users, :step_2ck_score, :integer
    add_column :users, :step_1_fail, :boolean
    add_column :users, :step_2ck_fail, :boolean
    add_column :users, :step_2cs_fail, :boolean
    add_column :users, :us_clinical_experience, :boolean
    add_column :users, :years_since_graduation, :integer, null: false
    add_column :users, :visa, :integer, null: false
    add_column :users, :admin, :integer
  end
end
