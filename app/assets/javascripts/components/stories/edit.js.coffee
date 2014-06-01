define (require) ->
  BackboneReactComponent = require("backbone-react-component")
  React                  = require("react")
  R                      = require("react-dom")
  HumanTime              = require("components/shared/human-time")
  keyMap                 = require("lib/key-map")
  require("editor")

  StoryView = BackboneReactComponent.extend
    displayName: "storyEdit"

    render: ->
      R.section {className: "story edit"},
        R.header {className: "headline"},
          R.div {className: "title"}, @props.title
          R.div {className: "description"}, @props.description
          R.div {className: "author"}, @props.author
          HumanTime {datetime: @props.updated_at}
          R.hr {className: "section-seperator"}

        R.article
          className: "body"
          ref: "body"
          dangerouslySetInnerHTML:
              __html: @state.body

        R.footer {className: "summary"}

    componentDidMount: ->
      body = @refs.body.getDOMNode()
      new MediumEditor(body)

    getInitialState: ->
      paragraphs = @props.body.split('\n\n')
      body: @props.body


