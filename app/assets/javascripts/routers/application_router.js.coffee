class LC.Routers.Application extends Backbone.Router
  routes:
    '': 'foundation'
    '*undefined': 'notFound'

  foundation: ->
    LC.title = null

    console.debug "foundation!"

  notFound: (path) ->
    LC.title = "404 - Error"

    LC.render LC.Components.errorPage({code: 404, path}), document.querySelector("main")
