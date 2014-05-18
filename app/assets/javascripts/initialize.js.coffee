@R = React.DOM

@LC =
  Models: {}
  Collections: {}
  Components: {}
  Routers: {}
  Debug: {}

  navigate: Backbone.history.navigate.bind(Backbone.history)
  render: React.renderComponent.bind(React)

  init: ->
    new @Routers.Application()
    new @Routers.Stories()

    Backbone.history.start
      pushState: true

$ ->
  $("html").removeClass "no-js"

  LC.init()
