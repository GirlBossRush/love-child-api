#= require modernizr/modernizr
#= require jquery/dist/jquery

DocumentHelper    = require("document-helper")

ApplicationRouter = require("routers/application")
StoriesRouter     = require("routers/stories")
History           = require("ampersand-router/ampersand-history")

SideMenu          = require("components/shared/side-menu")

$ ->
  new ApplicationRouter()
  new StoriesRouter()

  History.start(pushState: true)

  DocumentHelper.render
    component: SideMenu()
    anchor: "asideContent"
