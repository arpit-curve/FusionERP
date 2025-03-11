# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Clear existing data (Caution: Use only in development)
Organization.destroy_all
User.destroy_all

# Create an organization
org = Organization.create!(
  name: 'Acme Corp',
  slug: 'acme-corp',
  admin_email: 'admin@acme.com',
  is_deleted: false,
  deleted_by: nil
)

puts "✅ Organization created: #{org.name} (Slug: #{org.slug})"

# Create Admin user
admin_user = User.create!(
  first_name: 'Alice',
  last_name: 'Admin',
  dob: '1990-05-15',
  doj: '2022-01-01',
  employee_id: 'EMP001',
  gender: 'Female',
  email: org.admin_email, # Using the admin email from the organization
  password: 'password123', # BCrypt will hash this
  role: 'Admin',
  deleted_at: nil,
  deleted_by: nil,
  organization: org,
  manager: nil,
  hr: nil
)

puts "✅ Admin User created: #{admin_user.email} (Role: #{admin_user.role})"

# Create Standard user (Reports to Admin)
standard_user = User.create!(
  first_name: 'Bob',
  last_name: 'User',
  dob: '1995-08-20',
  doj: '2023-06-15',
  employee_id: 'EMP002',
  gender: 'Male',
  email: 'user@acme.com',
  password: 'password123',
  role: 'Standard',
  deleted_at: nil,
  deleted_by: nil,
  organization: org,
  manager: admin_user, # Reports to the admin
  hr: nil
)

puts "✅ Standard User created: #{standard_user.email} (Role: #{standard_user.role})"
