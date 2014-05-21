links = {
  "Home": "/"
  "Stories": "/stories"
  "Search": "/search"
  "Create": "/Create"
}

App.Components.SideMenu = React.createClass
  displayName: "sideMenu"

  getInitialState: ->
    expanded: false

  toggleExpansion: ->
    @state.expanded = !@state.expanded

    $("body").toggleClass("side-menu-expanded", @state.expanded)

    @forceUpdate()

  navigate: (e) ->
    href = $(e.target).attr("href")
    App.navigate(href, true)

  render: ->
    classes = React.addons.classSet
      "menu-content": true
      "expanded": @state.expanded

    R.div {className: classes},
      R.ul null,
        for name, href of links
          R.li {className: "link", href, key: href, onClick: @navigate}, name
      R.div {className: "menu-expander", onClick: @toggleExpansion},
        R.i {className: "fa fa-list fa-2x"}
      R.div {className: "click-mask", onClick: @toggleExpansion}
