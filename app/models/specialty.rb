class Specialty < ApplicationRecord
  has_many :programs, dependent: :destroy

  validates_presence_of :name
end
