Polymer "side-menu",
  isExpanded: ->
    @getAttribute("expanded")?

  enteredView: ->
    @.ownerDocument.addEventListener "click", (e) =>
      return unless @isExpanded()
      if e.target.className == "mask"
        @toggleExpansion()

  toggleExpansion: ->
    body = @ownerDocument.querySelector("body")
    if @isExpanded()
      body.classList.remove("disabled")
      @removeAttribute("expanded")
    else
      body.classList.add("disabled")
      @setAttribute("expanded", "")

