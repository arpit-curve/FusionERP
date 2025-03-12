class Department < ApplicationRecord
  belongs_to :organization

  validates :name, presence: true, uniqueness: { scope: :organization_id }
  default_scope { where(organization_id: Current.organization_id) }
end
