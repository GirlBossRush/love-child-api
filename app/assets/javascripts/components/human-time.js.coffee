REFRESH_DELAY = 6000

@HumanTime = React.createClass
  displayName: "humantime"

  getInitialState: ->
    {relativeTime: @humanize(@props.datetime)}

  componentDidMount: ->
    @interval = setInterval(@refresh, REFRESH_DELAY)

  componentWillUnmount: ->
    clearInterval @interval

  humanize: (datetime) ->
    moment(datetime).fromNow()

  refresh: ->
    @setState relativeTime: @humanize(@props.datetime)

  render: ->
    R.time {className: "human-time", dateTime: @props.datetime},
      @state.relativeTime

