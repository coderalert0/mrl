class RemoveF1FromPrograms < ActiveRecord::Migration[6.1]
  def change
    remove_column :programs, :f_1
  end
end
