class Speciality < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged

  has_many :programs, dependent: :destroy

  scope :active, -> { where(active: 1) }

  validates_presence_of :name
end
