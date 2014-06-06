define (require) ->
  Backbone       = require("backbone")
  DocumentHelper = require("document-helper")
  ErrorPage      = require("components/errors/error-page")

  class ApplicationRouter extends Backbone.Router
    routes:
      '': 'foundation'
      '*undefined': 'notFound'

    foundation: ->
      DocumentHelper.title = null

      console.debug "foundation!"

    notFound: (path) ->
      DocumentHelper.title = "404 - Error"

      DocumentHelper.render
        component: ErrorPage({code: 404, path})
