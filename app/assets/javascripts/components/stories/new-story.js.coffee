define (require) ->
  BackboneReactComponent = require("backbone-react-component")
  R                      = require("react-dom")
  Story                  = require("models/story")
  DocumentHelper         = require("document-helper")

  NewStory = BackboneReactComponent.extend
    displayName: "newStory"

    getInitialState: ->
      title: ""
      description: ""
      body: ""

    handleChange: (e) ->
      target = e.target
      key = target.getAttribute('name')
      nextState = {}
      nextState[key] = target.value
      this.setState(nextState)

    handleSubmit: (e) ->
      e.preventDefault()

      collection = @getCollection()
      model      = new Story(@state)

      collection.create model,
        wait: true

        success: (model, data) ->
          DocumentHelper.navigate "/stories/#{model.id}", true

        error: (model, data) ->
          console.log model, data

    createForm: ->
      R.form {role: "form", onSubmit: @handleSubmit},
        R.h1 null, "New Story"
        R.input {type: "hidden", value: @state.id}

        R.div {className: "form-group"},
          R.label {className: "sr-only"}, "Title"

          R.input
            className: "form-control"
            type: "text"
            value: @state.title
            onChange: @handleChange
            name: "title"
            placeholder: "Title"

        R.div {className: "form-group"},
          R.label {className: "sr-only"}, "Description"

          R.input
            className: "form-control"
            type: "text"
            value: @state.description
            onChange: @handleChange
            name: "description"
            placeholder: "Description"

        R.div {className: "form-group"},
          R.label {className: "sr-only"}, "body"

          R.textarea
            className: "form-control"
            value: @state.body
            onChange: @handleChange
            name: "body"
            rows: 3, placeholder: "Body"

        R.div {className: "form-group"},
          R.input
            className: "btn btn-default"
            type: "submit"
            value: "Create Story"


    render: ->
      R.div {className: "new-story"},
        @createForm()
