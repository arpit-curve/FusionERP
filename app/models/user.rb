class User < ApplicationRecord
  belongs_to :organization
  has_secure_password

  # Self-referential association (a user can have one manager, and a manager can have many users)
  belongs_to :manager, class_name: 'User', optional: true
  has_many :subordinates, class_name: 'User', foreign_key: 'manager_id'

  # Self-referential HR association
  belongs_to :hr, class_name: 'User', optional: true
  has_many :employees, class_name: 'User', foreign_key: 'hr_id'

  validates :email, presence: true, uniqueness: true
  validates :role, presence: true
  validates :password, length: { minimum: 6 }, allow_nil: true

  # Soft delete
  def soft_delete(deleted_by_user)
    update(deleted_at: Time.current, deleted_by: deleted_by_user.id)
  end

  # Check if user is deleted
  def deleted?
    deleted_at.present?
  end
end
