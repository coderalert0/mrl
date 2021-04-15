class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, and :omniauthable
  devise :database_authenticatable, :registerable, :trackable,
         :recoverable, :rememberable, :validatable

  validates_presence_of :step_1_score, :img_type, :years_since_graduation, :visa
  validates_inclusion_of :step_1_score, in: 1..300, message: I18n.t(:invalid_score_error)
  validates_inclusion_of :step_2ck_score, in: 1..300, allow_nil: true,
                                          message: I18n.t(:invalid_score_error)
  validates_inclusion_of :us_clinical_experience, in: [true, false]
  validates_inclusion_of :passed_step_2cs_first_attempt, in: [true, false]
  validates_uniqueness_of :email, conditions: -> { where.not(email: '') }

  enum img_type: { us_md_graduates: 0,
                   non_us_citizen_international_medical_graduates: 1,
                   us_citizen_international_medical_graduates: 2,
                   us_do_graduates: 3 }

  enum visa: { no: 0,
               j_1_sponsorship_through_ecfmg: 1,
               h1_b: 2,
               j1_or_h1: 3 }

  protected

  def password_required?
    false
  end

  def email_required?
    false
  end
end
