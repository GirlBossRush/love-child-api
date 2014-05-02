json.array!(@stories) do |story|
  json.extract! story, :id
  json.url story_url(story, format: :json)
end
