json.array!(@stories) do |story|
  json.extract! story, :description, :created_at_formatted
  json._id story.id
  json._title story.title

  json.url story_url(story, format: :json)
end
