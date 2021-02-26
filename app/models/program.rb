require 'csv'

class Program < ApplicationRecord
  belongs_to :speciality
  has_many :program_users

  scope :active, -> { where(active: 1) }

  validates_presence_of :acgme_program_code, :name
  validates_inclusion_of :minimum_step_1_score, in: 1..300, message: 'Invalid score (Valid score is between 1 and 300)'
  validates_inclusion_of :minimum_step_2_score, in: 1..300, allow_nil: true, message: 'Invalid score (Valid score is between 1 and 300)'


  def bookmarked?(user)
    program_users.select { |pu| pu.program == self && pu.user == user && pu.bookmark == true }.present?
  end

  def self.to_csv
    attributes = %w[acgme_program_code name minimum_step_1_score step_2_required minimum_step_2_score
                    must_pass_step_2_cs_first_attempt us_clinical_experience years_since_graduation
                    j_1_sponsorship_through_ecfmg h1_b f_1 address website program_director email
                    program_coordinator program_coordinator_email phone]

    CSV.generate(headers: true) do |csv|
      csv << attributes.map { |attribute| attribute.humanize.titleize }

      all.find_each do |user|
        csv << attributes.map { |attr| user.send(attr) }
      end
    end
  end
end
