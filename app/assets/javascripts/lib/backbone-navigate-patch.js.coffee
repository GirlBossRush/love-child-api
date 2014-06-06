define (require) ->
  BackboneVendor = require("backbone-vendor")

  vendorNavigate = BackboneVendor.history.navigate

  return (fragment, options) ->
    window.scrollTo(0, 0)

    vendorNavigate.apply(this, arguments)
