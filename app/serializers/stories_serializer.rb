class StoriesSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :created_at, :updated_at, :author, :url

  def url
    story_url(object)
  end

  def created_at
    object.created_at.iso8601
  end

  def updated_at
    object.updated_at.iso8601
  end
end
