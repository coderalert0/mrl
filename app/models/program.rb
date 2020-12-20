class Program < ApplicationRecord
  belongs_to :speciality

  validates_presence_of :acgme_program_code, :name
end
