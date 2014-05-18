LC.Components.StoryList = Backbone.React.Component.extend
  displayName: "storyList"

  navigateStory: (id) ->
    LC.navigate "/stories/#{id}", true

  delete: (id) ->
    model = @getCollection().get(id)

    model.destroy
      success: =>
        @forceUpdate()

  rowRender: (story) ->
    R.tr {"data-id": story.id, key: story.id},
      R.td {className: "id"}, story.id
      R.td {className: "title"},
        R.span {className: "link", onClick: @navigateStory.bind(this, story.id)}, story.title
      R.td {className: "description"}, story.description
      R.td {className: "created-at"},
        LC.Components.HumanTime(datetime: story.created_at)
      R.td {className: "link delete-story", onClick: @delete.bind(this, story.id)}, "Delete"

  render: ->
    R.table {className: "stories common-table"},
      R.thead null,
        R.th {className: "id"}, "ID"
        R.th {className: "title"}, "Title"
        R.th {className: "description"}, "Description"
        R.th {className: "created-at"}, "Created At"
        R.th {className: "delete-story"}, "Delete"
      R.tbody null, @props.collection.map(@rowRender)
