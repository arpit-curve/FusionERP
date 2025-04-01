# frozen_string_literal: true

class UserListPresenter
  def initialize(org_id, page, per_page)
    @org_id = org_id
    @page = page || 1
    @per_page = per_page || 10
  end

  def data
    paginated_users
  end

  private

  def paginated_users
    users = User.includes(:manager, :designation, :role)
                .where(organization_id: @org_id, deleted_at: nil)
                .select(:id, :dob, :doj, :email, :manager_id, :first_name, :last_name, :designation_id, :role_id)
                .page(@page)
                .per(@per_page)

    {
      users: users.as_json(methods: %i[full_name manager_name current_designation current_experience profile_picture_url], # rubocop:disable Layout/LineLength
                           except: %i[first_name last_name]),
      pagination: {
        current_page: users.current_page,
        total_pages: users.total_pages,
        total_count: users.total_count,
        per_page: users.limit_value
      }
    }
  end
end
