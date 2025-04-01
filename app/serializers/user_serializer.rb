class UserSerializer < ActiveModel::Serializer
  attributes :id, :full_name, :gender_string, :dob, :doj, :employee_id, :manager_name, :hr_name, :current_role,
             :current_designation, :current_experience, :profile_picture_url, :email

  def gender_string
    object.gender
  end

  def full_name
    object.full_name
  end

  def manager_name
    object.manager_name
  end

  def hr_name
    object.hr_name
  end

  def current_role
    object.current_role
  end

  def current_designation
    object.current_designation
  end

  def current_experience
    object.current_experience
  end

  def profile_picture_url
    object.profile_picture_url
  end
end
