define (require) ->
  React          = require("react")
  R              = require("react-dom")
  DocumentHelper = require("document-helper")
  _              = require("underscore")

  Modal = React.createClass
    displayName: "modal"

    render: ->
      R.div {className: "modal fade", id: "myModal", tabIndex: "-1", role: "dialog", ariaLabelledby: "myModalLabel", ariaHidden: "true"},
        R.div {className: "modal-dialog modal-sm"},
          R.div {className: "modal-inner"},
            R.div {className: "modal-content"},
              R.header {className: "modal-header"},
                R.h5 {className: "modal-title #{@state.type}", id: "myModalLabel"}, @state.title

              R.article {className: "modal-body"}, @props.body

              R.footer {className: "modal-footer"},
                R.div {className: "actions"}, @props.actions.map(@actionRender)

    actionRender: (action) ->
      _.defaults action,
        className: "btn-default"

      # R.span({className: "btn btn-primary", "data-dismiss": "modal"}, "No")
      R.span {className: "btn dark #{action.className}"}, action.text
    getInitialState: ->
      type: @props.type || "info"
      title: @props.title || "Information"
