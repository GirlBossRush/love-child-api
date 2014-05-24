define ["backbone"], (Backbone) ->
  class Story extends Backbone.Model
    paramRoot: "story"

    urlRoot: "/api/stories"
