class StorySerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :created_at, :updated_at, :user, :body

  def user
    if object.user
      object.user.slice(:id, :name, :email)
    else
      nil
    end
  end

  def created_at
    object.created_at.iso8601
  end

  def updated_at
    object.updated_at.iso8601
  end
end
