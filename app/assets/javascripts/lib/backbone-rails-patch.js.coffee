define (require) ->
  Backbone = require("vendor-backbone")

  oldSync = Backbone.sync

  Backbone.sync = (method, model, options) ->
    # --- Add CSRF token.
    options.beforeSend = (xhr) ->
      xhr.setRequestHeader("X-CSRF-Token", document.querySelector("meta[name='csrf-token']").content)

    # --- Nest model attributes
    model.vendorToJSON = model.toJSON

    # Override this model instance.
    model.toJSON = ->
      json = {}
      json[model.paramRoot] = model.vendorToJSON()

      return json

    # Call original sync method
    response = oldSync(method, model, options)

    # restore original toJSON() on this model instance
    model.toJSON = model.vendorToJSON

    return response

  return Backbone

