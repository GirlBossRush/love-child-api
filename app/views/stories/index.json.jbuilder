json.array!(@stories) do |story|
  json.extract! story, :title, :description

  json.created_at story.created_at.iso8601
  json.updated_at story.updated_at.iso8601

  json._id story.id
  json._title story.title

  json.url story_url(story)
end
