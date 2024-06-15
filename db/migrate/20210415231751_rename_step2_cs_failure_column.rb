class RenameStep2CsFailureColumn < ActiveRecord::Migration[6.1]
  def change
    rename_column :users, :step_2cs_fail, :passed_step_2cs_first_attempt
  end
end
