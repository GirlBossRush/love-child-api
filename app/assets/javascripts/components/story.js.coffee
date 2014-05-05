Polymer "x-story",
  humanize: ->
    @story.created_at_humanized = moment(@story.created_at_formatted).fromNow()

  ready: ->

  clicked: ->
    @bar += 1

  populate: (el, data) ->
    @story = data.response

    # @humanize()
    # setInterval =>
    #   @humanize.call(@)
    # , 60000
