Timeago =
  getTimeAgoText: (datetime) ->
    console.log datetime
    moment(datetime).fromNow()

  refresh: (element, datetime) ->
    element.innerHTML = this.getTimeAgoText(datetime)

interval = undefined

Polymer "human-time",
  setup: ->
    datetime = this.datetime
    element = this.$.timeago

    element.innerHTML = Timeago.getTimeAgoText(@datetime)

    if @refresh == true
      if typeof interval != "undefined"
        clearInterval interval

      interval = setInterval ->
        Timeago.refresh(element, datetime)
      , this.delay

  datetimeChanged: (oldval, newval) ->
    @datetime = newval
    @setup()

  ready: ->
    @setup()

  attributeChanged: ->
    @setup()

  # datetime: "2012-05-05T17:06:14+09:00"
  refresh: false
  delay: 600
