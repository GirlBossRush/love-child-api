navigationItems = [
  {
    label: "Home"
    icon: "home"
    path: "/"
  }

  {
    label: "Stories"
    icon: "list-alt"
    path: "/stories"
  }

  {
    label: "Search"
    icon: "search"
    path: "/stories/search"
  }

  {
    label: "Create"
    icon: "file"
    path: "stories/new"
  }

  {
    label: "Settings"
    icon: "user"
    path: "/settings"
  }

  {
    label: "Library"
    icon: "book"
    path: "/library"
  }
]

define (require) ->
  React          = require("react")
  R              = require("react-dom")
  DocumentHelper = require("document-helper")

  SideMenu = React.createClass
    displayName: "sideMenu"

    getInitialState: ->
      expanded: false

    toggleExpansion: ->
      @state.expanded = !@state.expanded

      $("body").toggleClass("side-menu-expanded", @state.expanded)

      @forceUpdate()

    navigate: (path) ->
      DocumentHelper.navigate(path, true)

      @toggleExpansion()

    navigationItem: (item) ->
      R.li {className: "list-group-item", key: item.path, onClick: @navigate.bind(@, item.path)},
        R.span {className: "accent glyphicon glyphicon-#{item.icon}"}, ""
        item.label

    render: ->
      classes = React.addons.classSet
        "menu-content": true
        "expanded": @state.expanded

      R.div {className: classes},
        R.ul {className: "list-group"},
          navigationItems.map(@navigationItem)

        R.div {className: "menu-expander", onClick: @toggleExpansion},
          R.i {className: "glyphicon glyphicon-list"}
        R.div {className: "click-mask", onClick: @toggleExpansion}
