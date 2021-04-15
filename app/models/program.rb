require 'csv'

class Program < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged

  belongs_to :speciality
  has_many :program_users

  scope :active, -> { where(active: 1) }

  validates_presence_of :acgme_program_code, :name
  validates_inclusion_of :minimum_step_1_score, in: 0..300, message: I18n.t(:invalid_score_error)
  validates_inclusion_of :minimum_step_2_score, in: 0..300, allow_nil: true,
                                                message: I18n.t(:invalid_score_error)

  def bookmarked?(user)
    program_users.select { |pu| pu.program == self && pu.user == user && pu.bookmark == true }.present?
  end

  def self.to_csv(user)
    attributes = %w[acgme_program_code name minimum_step_1_score step_2_required minimum_step_2_score
                    must_pass_step_2_cs_first_attempt j_1_sponsorship_through_ecfmg h1_b address
                    website program_director email program_coordinator program_coordinator_email phone]

    CSV.generate(headers: true) do |csv|
      csv << ['Match Score'].concat(attributes.map { |attribute| attribute.humanize.titleize }).concat(['Bookmarked'])

      all.each do |program|
        bookmarked = ProgramUser.where(program: program, user: user, bookmark: true).present?

        csv << [program.send(user.img_type)]
               .concat(attributes.map { |attr| program.send(attr) })
               .concat([bookmarked ? 'Yes' : 'No'])
      end
    end
  end
end
