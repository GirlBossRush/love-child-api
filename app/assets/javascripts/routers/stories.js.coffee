define (require) ->
  Backbone       = require("backbone")
  react          = require("react")
  DocumentHelper = require("document-helper")

  Story          = require("models/story")
  Stories        = require("collections/stories")

  views =
    index: require("components/stories/index")
    show:  require("components/stories/show")
    new:   require("components/stories/new")

  class StoriesRouter extends Backbone.Router
    routes:
      'stories(/)': 'index'
      'stories/new': 'new'
      'stories/:id': 'show'

    index: ->
      stories = new Stories()

      stories.fetch
        success: (collection) ->
          DocumentHelper.title = "(#{collection.length}) Stories"

          DocumentHelper.render
            component: views.index({collection})
            anchor: "main"

    show: (id) ->
      story = new Story({id})

      story.fetch
        success: (model) ->
          DocumentHelper.title = [model.attributes.title, "Stories"]

          DocumentHelper.render
            component: views.show({model})
            anchor: "main"

    new: ->
      DocumentHelper.title = "New Story"
      collection = new Stories()

      DocumentHelper.render
        component: views.new({collection})
        anchor: "main"
