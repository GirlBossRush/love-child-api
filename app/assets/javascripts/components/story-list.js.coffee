Polymer "story-list",
  humanize: ->
    for story in @stories
      story.created_at_humanized = moment(story.created_at_formatted).fromNow()

  populate: (el, data) ->
    @stories = data.response

    @humanize()
    setInterval =>
      @humanize.call(@)
    , 60000

  deleteStory: (el, data) ->
    console.log el, data

