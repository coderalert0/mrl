class MedicalSchool < ApplicationRecord
  has_many :medical_school_programs, dependent: :destroy

  validates_presence_of :name
end
