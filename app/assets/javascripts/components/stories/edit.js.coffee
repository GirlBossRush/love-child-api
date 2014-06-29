React                  = require("react")
R                      = require("react-dom")
HumanTime              = require("components/shared/human-time")
keyMap                 = require("lib/key-map")

MediumEditor = require("medium-editor/dist/js/medium-editor")


StoryEditor = React.createClass
  displayName: "storyEdit"

  render: ->
    R.section {className: "story edit"},
      @saveStateRender()

      R.header {className: "headline"},
        R.div {className: "title"}, @state.story.title
        R.div {className: "description"}, @state.story.description
        R.div {className: "author"}, @state.story.author
        HumanTime {datetime: @state.story.updated_at}
        R.hr {className: "section-seperator"}

      R.article
        className: "body"
        ref: "body"
        onInput: @handleBodyUpdate
        dangerouslySetInnerHTML:
          __html: @state.story.body

      R.footer {className: "summary"}

  storeCaretPosition: ->
    body = @refs.body.getDOMNode()

    @state.caretPostion = rangy.getSelection().saveCharacterRanges(body)

  saveStateRender: ->
    attributes = if @state.saveStatus == "saved"
      text: "Saved"
      className: "saved"
    else if @state.saveStatus == "saving"
      text: "Saving"
      className: "saving"
    else
      text: "Unsaved"
      className: "unsaved"

    R.aside {className: "save-state #{attributes.className}"}, attributes.text

  saveStory: ->
    model = @state.model
    model.set(@state.story)

    @state.saveStatus = "saving"
    @forceUpdate()
    console.log "saving"

    if !@state.isSaving
      model.save @state.story,
        success: =>
          @state.saveStatus = "saved"

        error: =>
          @state.saveStatus = "unsaved"

        complete: =>
          @forceUpdate()

  handleBodyUpdate: ->
    @state.saveStatus = "unsaved"
    @forceUpdate()

    body = @refs.body.getDOMNode()

    @state.story.body = body.innerHTML
    @saveStory()

  componentWillUpdate: ->
    @storeCaretPosition()

  componentDidUpdate: ->
    body = @refs.body.getDOMNode()

    rangy.getSelection().restoreCharacterRanges(body, @state.caretPostion)

  componentDidMount: ->
    body = @refs.body.getDOMNode()
    new MediumEditor(body)

  getInitialState: ->
    saveStatus: "saved"
    isSaving: false

    bodyCaretPosition: 0

    model: @props.model
    story: @props.model

module.exports = StoryEditor
