require 'csv'

class Program < ApplicationRecord
  belongs_to :speciality

  validates_presence_of :acgme_program_code, :name

  def bookmarked?(user)
    ProgramUser.where(program: self, user: user, bookmark: true).present?
  end

  def self.to_csv
    attributes = %w[acgme_program_code name minimum_step_1_score step_2_required minimum_step_2_score
                    must_pass_step_2_cs_first_attempt us_clinical_experience years_since_graduation j_1_sponsorship_through_ecfmg h1_b f_1 address website program_director email program_coordinator program_coordinator_email phone]

    CSV.generate(headers: true) do |csv|
      csv << attributes.map { |attribute| attribute.humanize.titleize }

      all.find_each do |user|
        csv << attributes.map { |attr| user.send(attr) }
      end
    end
  end
end
