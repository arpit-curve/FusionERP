class Organization < ApplicationRecord
  # Validations
  validates :name, presence: true

  # Associations
  has_many :users, dependent: :destroy
end
