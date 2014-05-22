oldSync = Backbone.sync

Backbone.sync = (method, model, options) ->
  options.beforeSend = (xhr) ->

    xhr.setRequestHeader('X-CSRFToken', App.CSRFToken)

  oldSync(method, model, options)
