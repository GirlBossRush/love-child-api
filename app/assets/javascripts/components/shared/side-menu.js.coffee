# Side menu component.
# Arguments:
# * navigationItems: Array of objects {label, icon, path}.

React          = require("react/react-with-addons")
R              = require("react-dom")
DocumentHelper = require("document-helper")

module.exports = React.createClass
  displayName: "sideMenu"

  navigate: (path) ->
    DocumentHelper.navigate(path, true)

  navigationItem: (item) ->
    R.li {className: "list-group-item", key: item.path, onClick: @navigate.bind(this, item.path)},
      item.label
      R.span {className: "accent glyphicon glyphicon-#{item.icon}"}, ""

  render: ->
    R.div {className: "menu-content"},
      R.ul {className: "list-group"},
        @props.navigationItems.map(@navigationItem)
