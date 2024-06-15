class AddDoximityUrlToPrograms < ActiveRecord::Migration[6.1]
  def change
    add_column :programs, :doximity_url, :string
  end
end
