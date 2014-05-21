class App.Routers.Application extends Backbone.Router
  routes:
    '': 'foundation'
    '*undefined': 'notFound'

  foundation: ->
    App.title = null

    console.debug "foundation!"

  notFound: (path) ->
    App.title = "404 - Error"

    App.render
      components: "ErrorPage"
      props: {code: 404, path}
      "main"
