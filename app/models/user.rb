# frozen_string_literal: true

class User < ApplicationRecord
  belongs_to :organization
  has_secure_password

  # Self-referential association (a user can have one manager, and a manager can have many users)
  belongs_to :manager, class_name: 'User', optional: true
  has_many :subordinates, class_name: 'User', foreign_key: 'manager_id'

  # Self-referential HR association
  belongs_to :hr, class_name: 'User', optional: true
  has_many :employees, class_name: 'User', foreign_key: 'hr_id'

  belongs_to :designation
  delegate :department, to: :designation

  validates :email, presence: true, uniqueness: true
  belongs_to :role
  validates :password, length: { minimum: 6 }, allow_nil: true

  # Soft delete
  def soft_delete(deleted_by_user)
    update(deleted_at: Time.current, deleted_by: deleted_by_user.id)
  end

  # Check if user is deleted
  def deleted?
    deleted_at.present?
  end

  def admin?
    role == Role.find_by(name: 'Admin')
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  def hierarchy
    {
      id: id,
      name: full_name,
      role: role,
      manager_id: manager_id,
      subordinates: subordinates.map(&:hierarchy)
    }
  end

  def manager_name
    manager&.full_name
  end
end
