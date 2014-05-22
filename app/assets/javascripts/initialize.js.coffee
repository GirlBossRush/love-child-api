@R = React.DOM

@App =
  CSRFToken: document.querySelector("meta[name='csrf-token']").content
  Models: {}
  Collections: {}
  Components: {}
  Routers: {}
  Debug: {}

  navigate: Backbone.history.navigate.bind(Backbone.history)

  Anchors:
    main: document.querySelector("main")

    sideMenu: document.getElementById("side-container")

  # Wrapper to avoid namespace typing repetition.
  render: (options = {props: {}, anchor: "main"}) ->
    component = @Components[options.component](options.props)
    anchor = @Anchors[options.anchor]

    React.renderComponent component, anchor

  init: ->
    new @Routers.Application()
    new @Routers.Stories()

    Backbone.history.start
      pushState: true

    @render
      component: "SideMenu"
      anchor: "sideMenu"

$ ->
  App.init()
