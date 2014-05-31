define (require) ->
  BackboneReactComponent = require("backbone-react-component")
  R                      = require("react-dom")
  HumanTime              = require("components/shared/human-time")
  Markdown               = require("marked")
  _                      = require("underscore")

  StoryView = BackboneReactComponent.extend
    displayName: "storyEdit"
    getInitialState: ->
      paragraphs = @props.body.split('\n\n')

      state =
        mode: "preview"

        # Setup internal representation of the body
        body: {}

      for paragraph in paragraphs
        state.body[_.uniqueId("paragraph")] = paragraph

      return state

    handleChange: (id, text) ->
      body = @state.body

      body[id] = @refs[id].getDOMNode().value

      @setState({body})

    paragraphRender: (id, text) ->
      R.section {key: id},
        # Markdown representation.
        R.textarea
          className: "form-control"
          value: text
          ref: id
          onChange: @handleChange.bind(this, id, text)
          name: "body"
          rows: 3, placeholder: "Body"

        # Rendered representation.
        R.p
          className: "rendered-paragraph"
          dangerouslySetInnerHTML:
            __html: Markdown.inlineLexer(text, [])

    render: ->
      R.section {className: "story"},
        R.header {className: "headline"},
          R.div {className: "title"}, @props.title
          R.div {className: "description"}, @props.description
          R.div {className: "author"}, @props.author
          HumanTime {datetime: @props.updated_at}
          R.hr {className: "section-seperator"}

        R.article {className: "body"},
          for id, text of @state.body
            @paragraphRender(id, text)

        R.footer {className: "summary"}
