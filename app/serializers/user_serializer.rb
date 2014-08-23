class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :email, :description, :last_login, :last_activity, :created_at, :updated_at, :path

  def path
    user_path(object)
  end

  def created_at
    object.created_at.iso8601
  end

  def updated_at
    object.updated_at.iso8601
  end
end
