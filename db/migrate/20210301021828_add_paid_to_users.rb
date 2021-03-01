class AddPaidToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :paid, :boolean
  end
end
