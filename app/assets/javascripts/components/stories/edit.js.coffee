React                  = require("react")
R                      = require("react-dom")
HumanTime              = require("components/shared/human-time")
keyMap                 = require("lib/key-map")
_                      = require("underscore")

MediumEditor = require("medium-editor/dist/js/medium-editor")

UPDATE_THROTTLE = 1500

StoryEditor = React.createClass
  displayName: "storyEdit"

  render: ->
    R.section {className: "story edit"},
      @saveStateRender()

      R.header {className: "headline"},
        R.div {
          className: "title"
          onInput: @handleContentUpdate
          contentEditable: true
          ref: "title"
        }, @state.story.title

        R.div {
          className: "description",
          onInput: @handleContentUpdate,
          contentEditable: true
          ref: "description"
        }, @state.story.description

        R.div {className: "author"}, @state.story.author
        HumanTime {datetime: @state.story.updated_at}
        R.hr {className: "section-seperator"}

      R.article
        className: "body"
        ref: "body"
        contentEditable: true
        onInput: @handleContentUpdate

      R.footer {className: "summary"}

  saveStateRender: ->
    attributes = if !@state.isSaving and !@state.isSaved
      text: "Unsaved"
      className: "unsaved"
    else if @state.isSaving
      text: "Saving"
      className: "saving"
    else if @state.isSaved
      text: "Saved"
      className: "saved"
    else
      text: "?"
      className: "unknown"

    R.aside {className: "save-state #{attributes.className}"}, attributes.text

  saveStory: _.debounce ->
    model = @state.model
    model.set(@state.story)

    @state.isSaving = true
    @forceUpdate()

    model.save @state.story,
      success: =>
        @state.isSaving = false
        @state.isSaved  = true

      error: =>
        @state.isSaving = false
        @state.isSaved  = false

      complete: =>
        @forceUpdate()
  , UPDATE_THROTTLE

  handleContentUpdate: (e) ->
    if !@state.isSaving
      @state.isSaved = false
      @forceUpdate()

      contentFields = ["title", "description", "body"]

      for field in contentFields
        @state.story[field] = @refs[field].getDOMNode().innerHTML

      @saveStory()

  componentDidMount: ->
    body = @refs.body.getDOMNode()

    body.innerHTML = @state.story.body
    new MediumEditor(body)

  getInitialState: ->
    isSaving: false
    isSaved: true

    bodyCaretPosition: 0

    model: @props.model
    story: @props.model

module.exports = StoryEditor
