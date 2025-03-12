# frozen_string_literal: true

class DashboardPresenter
  def initialize(org)
    @org = org
    @top_level_users = User.where(manager_id: nil)
  end

  def data
    {
      'total_employees': fetch_total_employees,
      'hierarchy': build_hierarchy,
      'upcoming_leaves': fetch_upcoming_leaves,
      'working_remote': fetch_employees_working_remote,
      'on_leave': fetch_employees_on_leave
    }
  end

  private

  def fetch_total_employees
    @org.users.count
  end

  def build_hierarchy
    @top_level_users.map(&:hierarchy)
  end

  def fetch_upcoming_leaves
    {}
  end

  def fetch_employees_working_remote
    {}
  end

  def fetch_employees_on_leave
    {}
  end
end
