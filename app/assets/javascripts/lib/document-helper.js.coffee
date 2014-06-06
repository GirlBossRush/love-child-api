# A collection of document related methods.

define (require) ->
  Backbone = require("backbone")
  _        = require("underscore")
  React    = require("react")

  DocumentHelper =
    # Sugar.
    navigate: Backbone.history.navigate.bind(Backbone.history)

    # Components should only be rendered out to an anchor listed here.
    anchors:
      mainContent:  document.getElementById("main-content")
      aboveContent: document.getElementById("above-content")
      asideContent:  document.getElementById("aside-content")

    render: (options = {}) ->
      _.defaults options,
        props: {}
        anchor: "mainContent"

      anchor = @anchors[options.anchor]

      if anchor
        React.renderComponent options.component, anchor
      else
        throw new Exceptions.UnknownAnchor(options.anchor)

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

# --- Exceptions ---

this.Exceptions =
  UnknownAnchor: (anchor) ->
    @anchor = anchor
    @message = "Unable to find anchor"

    @toString = ->
      "#{@message}: #{@anchor}"

    return
