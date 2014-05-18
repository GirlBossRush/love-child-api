Object.defineProperty LC, "title",
  set: (value) ->
    base = "Love Child"

    title = if value?
      if $.isArray(value)
        prefixes = ""

        for subTitle in value
          prefixes += "#{subTitle} - "

        "#{prefixes}#{base}"
      else
        "#{value} - #{base}"
    else
      base

    document.title = title

  get: ->
    document.title
