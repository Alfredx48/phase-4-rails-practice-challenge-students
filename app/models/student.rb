class Student < ApplicationRecord
  belongs_to :instructor

  validates_presence_of :name
  validates :age, numericality: { greater_than_or_equal_to: 18 }
end
