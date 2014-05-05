humanize =
  convert: (datetime) ->
    moment(datetime).fromNow()

  set: (element, datetime) ->
    element.innerHTML = @convert(datetime)

interval = undefined

Polymer "human-time",
  refresh: true
  delay: 600

  setup: ->
    @datetime
    element  = @shadowRoot.querySelector "time"

    humanize.set(element, @datetime)

    if @refresh
      if interval?
        clearInterval interval

      interval = setInterval =>
        humanize.set(element, @datetime)
      , @delay

  datetimeChanged: (oldVal, newVal) ->
    @datetime = newVal
    @setup()

  ready: ->
    @setup()
