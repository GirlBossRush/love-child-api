require ["modernizr", "routers/application", "routers/stories", "document-helper", "components/shared/side-menu"],
  (Modernizr, ApplicationRouter, StoriesRouter, DocumentHelper, SideMenu) ->
    new ApplicationRouter()
    new StoriesRouter()

    $ ->
      Backbone.history.start
        pushState: true

      DocumentHelper.render
        component: SideMenu()
        anchor: "sideMenu"
