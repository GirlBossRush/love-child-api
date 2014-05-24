define ["backbone", "models/story"], (Backbone, Story) ->
  class Stories extends Backbone.Collection
    url: '/api/stories'
    model: Story
