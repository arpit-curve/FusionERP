# frozen_string_literal: true

class Role < ApplicationRecord
  has_many :users, dependent: :restrict_with_error
  belongs_to :organization

  validates :name, presence: true, uniqueness: { scope: :organization_id }
  default_scope { where(organization_id: Current.organization_id) }
end
