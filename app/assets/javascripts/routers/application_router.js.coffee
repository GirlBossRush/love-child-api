class LC.Routers.Application extends Backbone.Router
  routes:
    '': 'foundation'
    '*undefined': 'notFound'

  foundation: ->
    console.debug "foundation!"

  notFound: (path) ->
    LC.render LC.Components.errorPage({code: 404, path}), $("main")[0]
