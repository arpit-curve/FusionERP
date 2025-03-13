# frozen_string_literal: true

class UserListPresenter
  def initialize(org_id)
    @org_id = org_id
  end

  def data
    build_user_data
  end

  private

  def build_user_data
    users = User.includes(:manager) # Eager loads manager to avoid N+1 queries
                .where(organization_id: @org_id)
                .select(:id, :dob, :doj, :email, :manager_id, :first_name, :last_name)

    users.as_json(methods: %i[full_name manager_name], except: %i[first_name last_name])
  end
end
