class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, and :omniauthable
  devise :database_authenticatable, :registerable, :trackable,
         :recoverable, :rememberable, :validatable

  validates_presence_of :step_1_score, :img_type, :years_since_graduation, :visa
  validates_inclusion_of :step_1_score, in: 1..300
  validates_inclusion_of :step_2ck_score, in: 1..300, allow_nil: true
  validates_inclusion_of :us_clinical_experience, in: [true, false]
  validates_uniqueness_of :email, conditions: -> {where.not(:email => '')}

  enum img_type: { us_medical_graduate: 0,
                   non_caribbean_img: 1,
                   caribbean_img: 2 }

  enum visa: { no: 0,
               j1: 1,
               h1: 2,
               j1_and_h1: 3 }

  protected

  def password_required?
    false
  end

  def email_required?
    false
  end
end
