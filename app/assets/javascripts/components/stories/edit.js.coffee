define (require) ->
  BackboneReactComponent = require("backbone-react-component")
  React                  = require("react")
  R                      = require("react-dom")
  HumanTime              = require("components/shared/human-time")
  Markdown               = require("marked")
  _                      = require("underscore")

  StoryView = BackboneReactComponent.extend
    # --- Utility ---
    displayName: "storyEdit"

    generateID: ->
      _.uniqueId("paragraph")

    getInitialState: ->
      paragraphs = @props.body.split('\n\n')

      # Setup internal representation of the body.
      body: for paragraph, i in paragraphs
        id: @generateID()
        editing: false
        text: paragraph
        index: i

    # Paragraphs must be reindexed when data is added or removed.
    reindex: (body, callback) ->
      for paragraph, i in body
        paragraph.index = i

      @setState {body}, callback

    deleteParagraph: (paragraph) ->
      index = paragraph.index
      body = @state.body
      body.splice(index, 1)

      @reindex body, =>
        neighborParagraph = if index == body.length
          # Last element was removed. The next "last" element will be in the position
          # before this index.
           body[index - 1]
        else
          # After removing this paragraph, the next target should be in the same position.
           body[index]

        @enableEditMode(neighborParagraph)

    insertParagraph: (index) ->
      body      = @state.body
      newID     = @generateID()

      body.splice index, 0,
        id: newID
        text: ""
        editing: false

      @reindex body, =>
        @enableEditMode({id: newID, index: index})

    # --- Editing ---

    enableEditMode: (paragraph) ->
      body   = @state.body
      source = @refs[paragraph.id].getDOMNode()

      body[paragraph.index].editing = true

      @setState {body}, ->
        source.focus()

    disableEditMode: (paragraph) ->
      body = @state.body

      body[paragraph.index].editing = false
      @setState({body})

    # --- Handlers ---

    handleChange: (paragraph) ->
      body = @state.body
      source = @refs[paragraph.id].getDOMNode()

      # Empty paragraph blocks should be removed unless only one remains.
      if source.value.length || body.length == 1
        body[paragraph.index].text = source.value
        @setState({body})
      else
        @deleteParagraph(paragraph)

    handleKeyDown: (paragraph, e) ->
      body = @state.body

      switch e.nativeEvent.keyCode
        when 8 # Backspace.
          # The change event does not occur on empty text areas.
          # Backspacing an empty field should remove it.
          @handleChange(paragraph)

        when 9 # Tab
          e.preventDefault()

          # Imitate a typical form tab index.
          index = paragraph.index + (if e.nativeEvent.shiftKey then -1 else 1)

          if index < 0
            # Insert new paragraph before the first existing paragraph.
            @insertParagraph(0)

          else if index < body.length
            neighborParagraph = @state.body[index]
            @disableEditMode(paragraph)
            @enableEditMode(neighborParagraph)

          else
            # Insert new paragraph after last existing paragraph.
            @insertParagraph(paragraph.index + 1)

    # --- Renderers ---

    potentialParagraph: (index) ->
      R.span
        className: "glyphicon glyphicon-plus new-paragraph"
        onClick: @insertParagraph.bind(this, index)

    paragraph: (paragraph) ->
      classes = React.addons.classSet
        "paragraph-pair": true
        editing: paragraph.editing

      R.section {className: classes, key: paragraph.id},
        # Markdown representation.
        R.textarea
          className: "form-control markdown-source"
          value: paragraph.text
          ref: paragraph.id
          onKeyDown: @handleKeyDown.bind(this, paragraph)
          onChange: @handleChange.bind(this, paragraph)
          onBlur: @disableEditMode.bind(this, paragraph)
          placeholder: "..."

        # Rendered representation.
        R.p
          className: "rendered-paragraph"
          onClick: @enableEditMode.bind(this, paragraph)
          dangerouslySetInnerHTML:
            __html: Markdown.inlineLexer(paragraph.text, [])

        @potentialParagraph(paragraph.index + 1)

    render: ->
      R.section {className: "story"},
        R.header {className: "headline"},
          R.div {className: "title"}, @props.title
          R.div {className: "description"}, @props.description
          R.div {className: "author"}, @props.author
          HumanTime {datetime: @props.updated_at}
          R.hr {className: "section-seperator"}

        R.article {className: "body"},
          @potentialParagraph(0)
          @state.body.map(@paragraph)

        R.footer {className: "summary"}
