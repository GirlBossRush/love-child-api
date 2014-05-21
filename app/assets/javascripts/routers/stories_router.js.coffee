class App.Routers.Stories extends Backbone.Router
  routes:
    'stories(/)': 'index'
    'stories/new': 'new'
    'stories/:id': 'show'

  index: ->
    stories = new App.Collections.Stories()

    stories.fetch
      success: (collection) ->
        App.title = "(#{collection.length}) Stories"

        App.render
          component: "StoryList"
          props: {collection}
          anchor: "main"

  show: (id) ->
    story = new App.Models.Story({id})

    story.fetch
      success: (model) ->
        App.title = [model.attributes.title, "Stories"]

        App.render
          component: "Story"
          props: {model}
          anchor: "main"

  new: ->
    App.render
      component: "NewStory"
      anchor: "main"
