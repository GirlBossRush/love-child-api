class LC.Routers.Stories extends Backbone.Router
  routes:
    'stories(/)': 'index'
    'stories/:id': 'show'

  index: ->
    stories = new LC.Collections.Stories()

    stories.fetch
      success: (collection) ->
        LC.render LC.Components.StoryList({collection}), document.querySelector("main")

  show: (id) ->
    story = new LC.Models.Story({id})

    story.fetch
      success: (model) ->
        LC.render LC.Components.Story({model}), document.querySelector("main")
