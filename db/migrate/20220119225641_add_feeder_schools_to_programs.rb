class AddFeederSchoolsToPrograms < ActiveRecord::Migration[6.1]
  def change
    add_column :programs, :feeder_schools, :boolean
  end
end
