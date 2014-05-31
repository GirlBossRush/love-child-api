define (require) ->
  BackboneReactComponent = require("backbone-react-component")
  React                  = require("react")
  R                      = require("react-dom")
  HumanTime              = require("components/shared/human-time")
  Markdown               = require("marked")
  _                      = require("underscore")

  StoryView = BackboneReactComponent.extend
    displayName: "storyEdit"

    getInitialState: ->
      paragraphs = @props.body.split('\n\n')

      # Setup internal representation of the body
      state =
        body: {}

      for paragraph in paragraphs
        state.body[_.uniqueId("paragraph")] =
          editing: false
          text: paragraph

      return state

    handleChange: (paragraph) ->
      body = @state.body

      body[paragraph.id].text = @refs[paragraph.id].getDOMNode().value

      @setState({body})

    enableEditMode: (paragraph) ->
      body = @state.body
      source = @refs[paragraph.id].getDOMNode()

      body[paragraph.id].editing = true
      @setState {body}, ->
        source.selectionBegin = 0
        source.selectionEnd = 0
        source.focus()

    disableEditMode: (paragraph) ->
      console.log "blured"
      body = @state.body

      body[paragraph.id].editing = false
      @setState({body})

    paragraphRender: (paragraph) ->
      classes = React.addons.classSet
        "paragraph-pair": true
        editing: paragraph.editing

      R.section {className: classes, key: paragraph.id},
        # Markdown representation.
        R.textarea
          className: "form-control markdown-source"
          value: paragraph.text
          ref: paragraph.id
          onChange: @handleChange.bind(this, paragraph)
          onBlur: @disableEditMode.bind(this, paragraph)
          name: "body"
          placeholder: "Body"

        # Rendered representation.
        R.p
          className: "rendered-paragraph"
          onClick: @enableEditMode.bind(this, paragraph)
          dangerouslySetInnerHTML:
            __html: Markdown.inlineLexer(paragraph.text, [])

    render: ->
      R.section {className: "story"},
        R.header {className: "headline"},
          R.div {className: "title"}, @props.title
          R.div {className: "description"}, @props.description
          R.div {className: "author"}, @props.author
          HumanTime {datetime: @props.updated_at}
          R.hr {className: "section-seperator"}

        R.article {className: "body"},
          for id, paragraph of @state.body
            @paragraphRender
              id: id
              text: paragraph.text
              editing: paragraph.editing

        R.footer {className: "summary"}
