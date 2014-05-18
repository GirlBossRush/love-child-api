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

    LC.render LC.Components.SideMenu(), document.getElementById("side-container")

$ ->
  LC.init()
