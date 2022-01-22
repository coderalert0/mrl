class MedicalSchool < ApplicationRecord
  has_many :medical_school_programs, dependent: :destroy
  has_many :programs, through: :medical_school_programs

  validates_presence_of :name

  enum img_type: { us_md_graduates: 0,
                   non_us_citizen_international_medical_graduates: 1,
                   us_citizen_international_medical_graduates: 2,
                   us_do_graduates: 3 }
end
