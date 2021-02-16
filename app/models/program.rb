class Program < ApplicationRecord
  belongs_to :speciality

  validates_presence_of :acgme_program_code, :name

  def bookmarked?(user)
    ProgramUser.where(program: self, user: user, bookmark: true).present?
  end
end
