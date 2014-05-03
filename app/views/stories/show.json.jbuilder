json.extract! @story, :created_at_formatted, :description, :body
json._id @story.id
json._title @story.title
