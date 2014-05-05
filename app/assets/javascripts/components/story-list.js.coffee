Polymer "story-list",
  populate: (el, data) ->
    @stories = data.response

  deleteStory: (el, data) ->
    console.log el, data

