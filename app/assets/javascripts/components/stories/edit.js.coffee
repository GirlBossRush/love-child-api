React                  = require("react")
R                      = require("react-dom")
HumanTime              = require("components/shared/human-time")
keyMap                 = require("lib/key-map")
# rangy = require("rangy/rangy-core")
# require("rangy/rangy-textrange")
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
        onKeyUp: @storeCaretPosition
        dangerouslySetInnerHTML:
          __html: @state.story.body

      R.footer {className: "summary"}

  storeCaretPosition: ->
    body = @refs.body.getDOMNode()

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
    console.debug "saving"

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
    # body  = @refs.body.getDOMNode()
    # range = document.createRange();
    # sel   = window.getSelection();

    # range.setStart(body.childNodes[0], @state.bodyCaretPosition)
    # range.setStart(body.childNodes[0], 0)

    # range.collapse(true)
    # sel.removeAllRanges()
    # sel.addRange(range)

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
