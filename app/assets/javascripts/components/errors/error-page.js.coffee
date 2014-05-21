App.Components.ErrorPage = React.createClass
  displayName: "errorPage"
  render: ->
    R.div {className: "error-page", "data-code": @props.code},
      R.h1 null, @props.code
      R.p null, "'#{@props.path}' is invalid."
