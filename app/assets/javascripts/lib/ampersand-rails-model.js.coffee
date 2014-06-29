AmpersandModel = require("ampersand-model/ampersand-model")
sync = require('ampersand-sync')

module.exports = AmpersandModel.extend
  sync: (method, model, options) ->
    if method is "update" or method is "create"
      token = document.querySelector("meta[name='csrf-token']").content

      options.beforeSend = (xhr) ->
        xhr.setRequestHeader("X-CSRF-Token", token)

    sync.call(this, method, model, options)
