class ChangeMinimumStep1ColumnType < ActiveRecord::Migration[6.1]
  def change
    change_column :programs, :minimum_step_1_score, :integer
  end
end
