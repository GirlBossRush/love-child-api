dependencies = [
  "modernizr"
  "jquery"
  "bootstrap"
  "backbone"
  "routers/application"
  "routers/stories"
  "document-helper"
  "components/shared/modal"
  "components/shared/side-menu"
]

require dependencies, (Modernizr, $, bootstrap, Backbone, ApplicationRouter, StoriesRouter, DocumentHelper, Modal, SideMenu) ->
  new ApplicationRouter()
  new StoriesRouter()

  $ ->
    Backbone.history.start
      pushState: true

    DocumentHelper.render
      component: SideMenu()
      anchor: "asideContent"
