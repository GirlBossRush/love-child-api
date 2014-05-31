define (require) ->
  BackboneReactComponent = require("backbone-react-component")
  R                      = require("react-dom")
  HumanTime              = require("components/shared/human-time")
  Markdown               = require("marked")

  StoryView = BackboneReactComponent.extend
    displayName: "story"
    render: ->
      R.section {className: "story"},
        R.header {className: "headline"},
          R.div {className: "title"}, @props.title
          R.div {className: "description"}, @props.description
          R.div {className: "author"}, @props.author
          HumanTime {datetime: @props.updated_at}
          R.hr {className: "section-seperator"}

        R.article {className: "body", dangerouslySetInnerHTML: {__html: Markdown.parse(@props.body)}}
        R.footer {className: "summary"}
