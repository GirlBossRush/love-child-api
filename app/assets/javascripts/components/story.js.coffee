LC.Components.Story = Backbone.React.Component.extend
  render: ->
    R.section {className: "story"},
      R.header {className: "headline"},
        R.div {className: "title"}, @props.title
        R.div {className: "description"}, @props.description
        R.div {className: "author"}, @props.author
        LC.Components.HumanTime {datetime: @props.updated_at}
        R.hr {className: "section-seperator"}

      R.article {className: "body"}, @props.body
      R.footer {className: "summary"}
