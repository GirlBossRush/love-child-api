Polymer "story-list",
  resource:
    stories: "/stories.json"
    story: (id) ->
      "/stories/#{id}.json"

  populate: (el, data) ->
    @stories = data.response

  removeRow: (id) ->
    @shadowRoot
      .querySelector(".stories tr[data-id='#{id}']")
      .setAttribute("hidden")

  deleteStory: (e, d, el) ->
    id = el.parentElement.dataset.id

    request = document.createElement "polymer-ajax"

    _.extend request, LC.AJAX.DELETE,
      url: @resource.story(id)

    .addEventListener "polymer-response", =>
      @removeRow(id)

    request.go()

