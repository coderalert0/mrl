class Program < ApplicationRecord
  belongs_to :specialty

  validates_presence_of :accredidation_id, :name
end
