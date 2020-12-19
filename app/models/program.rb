class Program < ApplicationRecord
  belongs_to :specialty

  validates_presence_of :name
end
