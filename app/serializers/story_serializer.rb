class StorySerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :created_at, :updated_at, :body, :path

  has_one :user

  def path
    story_path(object)
  end

  def created_at
    object.created_at.iso8601
  end

  def updated_at
    object.updated_at.iso8601
  end
end
