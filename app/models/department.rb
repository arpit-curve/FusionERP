# frozen_string_literal: true

class Department < ApplicationRecord
  belongs_to :organization
  has_many :designations, dependent: :destroy
  belongs_to :department_head, class_name: 'User', foreign_key: 'department_head_id'

  validates :name, presence: true, uniqueness: { scope: :organization_id }
  validates :department_head, presence: true
  default_scope { where(organization_id: Current.organization_id) }
end
