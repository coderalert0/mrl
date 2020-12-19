class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, and :omniauthable
  devise :database_authenticatable, :registerable, :trackable,
         :recoverable, :rememberable, :validatable

  validates_presence_of :first_name, :last_name, :step_1_score, :img_type,
                        :us_clinical_experience, :years_since_graduation
end
