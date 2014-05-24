# A collection of document related methods.

define (require) ->
  Backbone = require("backbone")
  React    = require("react")

  DocumentHelper =
    # Sugar.
    navigate: Backbone.history.navigate.bind(Backbone.history)

    # Components should only be rendered out to an anchor listed here.
    anchors:
      main: document.querySelector("main")
      sideMenu: document.getElementById("side-container")

    render: (options = {props: {}, anchor: "main"}) ->
      anchor = @anchors[options.anchor]

      React.renderComponent options.component, anchor

  # Treat the document title like a property.
  Object.defineProperty DocumentHelper, "title",
    # Use base title if no prefix is provided. Arrays will be split and delimited.
    set: (value) ->
      base = "Love Child"

      title = if value?
        if $.isArray(value)
          prefixes = ""

          for subTitle in value
            prefixes += "#{subTitle} - "

          "#{prefixes}#{base}"
        else
          "#{value} - #{base}"
      else
        base

      document.title = title

    get: ->
      document.title

  return DocumentHelper
