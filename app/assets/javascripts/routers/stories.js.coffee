define (require) ->
  Backbone          = require("backbone")
  react             = require("react")
  DocumentHelper    = require("document-helper")

  Story             = require("models/story")
  StoriesCollection = require("collections/stories")

  StoryList         = require("components/stories/story-list")
  StoryView         = require("components/stories/story")
  NewStoryView      = require("components/stories/new-story")

  class StoriesRouter extends Backbone.Router
    routes:
      'stories(/)': 'index'
      'stories/new': 'new'
      'stories/:id': 'show'

    index: ->
      stories = new StoriesCollection()

      stories.fetch
        success: (collection) ->
          DocumentHelper.title = "(#{collection.length}) Stories"

          DocumentHelper.render
            component: StoryList({collection})
            anchor: "main"

    show: (id) ->
      story = new Story({id})

      story.fetch
        success: (model) ->
          DocumentHelper.title = [model.attributes.title, "Stories"]

          DocumentHelper.render
            component: StoryView({model})
            anchor: "main"

    new: ->
      DocumentHelper.title = "New Story"
      collection = new StoriesCollection()

      DocumentHelper.render
        component: NewStoryView({collection})
        anchor: "main"
