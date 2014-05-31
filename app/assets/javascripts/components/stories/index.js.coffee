define (require) ->
  BackboneReactComponent = require("backbone-react-component")
  DocumentHelper         = require("document-helper")
  R                      = require("react-dom")

  StoryList = BackboneReactComponent.extend
    displayName: "storyList"

    navigateStory: (id) ->
      DocumentHelper.navigate "/stories/#{id}", true

    delete: (id) ->
      model = @getCollection().get(id)

      model.destroy
        success: =>
          @forceUpdate()

    rowRender: (story) ->
      HumanTime = require("components/shared/human-time")

      R.tr {"data-id": story.id, key: story.id},
        R.td {className: "id"}, story.id
        R.td {className: "title"},
          R.span {className: "link", onClick: @navigateStory.bind(this, story.id)}, story.title
        R.td {className: "description"}, story.description
        R.td {className: "created-at"},
          HumanTime(datetime: story.created_at)
        R.td {className: "link delete-story", onClick: @delete.bind(this, story.id)}, "Delete"

    render: ->
      R.table {className: "table stories"},
        R.thead null,
          R.th {className: "id"}, "ID"
          R.th {className: "title"}, "Title"
          R.th {className: "description"}, "Description"
          R.th {className: "created-at"}, "Created At"
          R.th {className: "delete-story"}, "Delete"
        R.tbody null, @props.collection.map(@rowRender)
