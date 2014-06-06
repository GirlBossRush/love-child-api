define (require) ->
  BackboneVendor = require("backbone-vendor")
  syncPatch      = require("backbone-sync-patch")
  navigatePatch  = require("backbone-navigate-patch")


  BackboneVendor.sync = syncPatch
  BackboneVendor.history.navigate = navigatePatch

  return BackboneVendor

