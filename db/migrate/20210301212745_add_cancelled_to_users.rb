class AddCancelledToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :cancelled, :boolean
  end
end
