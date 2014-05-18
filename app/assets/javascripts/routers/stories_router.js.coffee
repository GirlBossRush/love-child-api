class LC.Routers.Stories extends Backbone.Router
  routes:
    'stories(/)': 'index'
    'stories/:id': 'show'

  index: ->
    stories = new LC.Collections.Stories()

    stories.fetch
      success: ->
        LC.render LC.Components.StoryList(collection: stories), document.querySelector("main")

  show: (id) ->
    story = new LC.Models.Story({id})

    story.fetch
      success: ->
        LC.render LC.Components.Story(model: story), document.querySelector("main")
