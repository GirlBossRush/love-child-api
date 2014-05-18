links = {
  "Home": "/"
  "Stories": "/stories"
  "Search": "/search"
  "Create": "/Create"
}

LC.Components.SideMenu = React.createClass
  displayName: "sideMenu"

  getInitialState: ->
    expanded: false

  toggleExpansion: ->
    console.log 'togglin, was ', @state.expanded
    if @state.expanded
      @state.expanded = false
    else
      @state.expanded = true

    @forceUpdate()

  navigate: (e) ->
    href = $(e.target).attr("href")
    LC.navigate(href, true)

  render: ->
    classes = React.addons.classSet
      "side-menu": true
      "expanded": @state.expanded

    R.div {className: classes},
      R.ul null,
        for name, href of links
          R.li {href, key: href, onClick: @navigate}, name
      R.div {className: "menu-expander", onClick: @toggleExpansion},
        R.i {className: "fa fa-list fa-2x"}



# polymer-element name="side-menu" attributes="expanded"
#   template
#   side-menu
#     header Alternative Fiction

#     ul
#       li href="/" Home
#       li href="/search" Search
#       li href="/Create" Create
#     #expander on-click="{{toggleExpansion}}"
#       i.fa.fa-list.fa-2x



