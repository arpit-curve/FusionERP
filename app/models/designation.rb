class Designation < ApplicationRecord
  belongs_to :department
  has_many :users

  validates :name, presence: true, uniqueness: { scope: :department_id }
end
