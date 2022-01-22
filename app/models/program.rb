require 'csv'

class Program < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged

  belongs_to :speciality
  has_many :program_users
  has_many :users, through: :program_users
  has_many :medical_school_programs
  has_many :medical_schools, through: :medical_school_programs
  scope :active, -> { where(active: 1) }

  validates_presence_of :acgme_program_code, :name
  validates_inclusion_of :minimum_step_1_score, in: 0..300, message: I18n.t(:invalid_score_error)
  validates_inclusion_of :minimum_step_2_score, in: 0..300, allow_nil: true,
                                                message: I18n.t(:invalid_score_error)

  def bookmarked?(user)
    program_users.select { |pu| pu.program == self && pu.user == user && pu.bookmark == true }.present?
  end

  def percentage(type)
    return send(type) unless medical_schools.present?

    medical_school_ids = medical_schools
                         .select { |medical_school| medical_school.img_type == type }
                         .pluck(:id)

    type_sum = medical_school_programs
               .select { |medical_school_program| medical_school_ids.include? medical_school_program.medical_school_id }
               .pluck(:percentage).sum

    total_sum = medical_school_programs.to_a.pluck(:percentage).sum

    (type_sum.fdiv(total_sum) * 100).round
  end
end
