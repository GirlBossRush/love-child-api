class UsersSerializer < ActiveModel::Serializer
  attributes :id, :email, :name, :description, :created_at, :updated_at, :url

  def url
    user_url(object)
  end

  def created_at
    object.created_at.iso8601
  end

  def updated_at
    object.updated_at.iso8601
  end
end
