# frozen_string_literal: true

class Department < ApplicationRecord
  belongs_to :organization
  has_many :designations, dependent: :destroy

  validates :name, presence: true, uniqueness: { scope: :organization_id }
  default_scope { where(organization_id: Current.organization_id) }
end
