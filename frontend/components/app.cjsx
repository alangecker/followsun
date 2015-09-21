Current = require './Current'
Control = require './Control'
Settings = require './Settings'
Calibration = require './Calibration'
Login = require './Login'
api = require './api'


App = React.createClass
  getInitialState: ->
    plantAzimuth: null
    plantElevation: null
    sunAzimuth: null
    sunElevation: null
    wind: null
    sun:
      sunrisePos: {}
      sunsetPos: {}
    config: {}
    loggedin: false

  # if @state.loggedin changes call collapsible() and tooltip() to
  #  fix fresh appeared materialize-components
  componentDidUpdate: (prevProps, prevState) ->
    if prevState.loggedin != @state.loggedin
      $('.collapsible', React.findDOMNode(@)).collapsible();
      $('.tooltipped', React.findDOMNode(@)).tooltip()


  componentDidMount: ->
    # when API is connected send a few requests for informations
    api.connected ->
      api.send 'status.sub'
      api.send 'suninfo'
      api.send 'config'

    # set states when API responses
    api.on 'status', (res) =>
      @setState res
    api.on 'suninfo', (res) =>
      @setState sun: res
    api.on 'config', (res) =>
      @setState config: res

    # check login
    api.on 'login', (res) =>
      if res.success
        @setState loggedin: true
      else
        Materialize.toast('<b>Fehler: </b> Passwort ist falsch', 4000)

    # toasts!
    api.on 'showError', (res) =>
      Materialize.toast('<b>Fehler: </b> '+res, 4000)

    api.on 'success', (res) =>
      Materialize.toast('<b>Erfolgreich: </b> '+res, 4000)


  render: ->
    <div>
      <div className="container">
        <div className="banner">
          <img src="/images/banner.png" />
          <div id="title">{@state.config.title}</div>
          <div id="version">FollowSun 0.1.0 - GPL 2.0<br />Andreas Langecker - <a href="https://github.com/alangecker/followsun">GitHub</a></div>
        </div>
        <ul className="collapsible" data-collapsible="expandable">
          <Current
            plantAzimuth={@state.plantAzimuth}
            sunAzimuth={@state.sunAzimuth}
            sunriseAzimuth={@state.sun.sunrisePos.azimuth}
            sunsetAzimuth={@state.sun.sunsetPos.azimuth}
            plantElevation={@state.plantElevation}
            sunElevation={@state.sunElevation}
            azimuthTolerance={@state.config.azimuthTolerance}
            status={@state.status}
            automatic={@state.config.automatic} />
          {if not @state.loggedin
            <Login />
          }
          {if @state.loggedin
            <Control
              azimuth={@state.plantAzimuth}
              elevation={@state.plantElevation}
              azimuthMovement={@state.azimuthMovement}
              elevationMovement={@state.elevationMovement}
              automatic={@state.config.automatic}
            />
          }
          {if @state.loggedin
            <Settings {...@state.config} />
          }
          {if @state.loggedin
            <Calibration
              rawAzimuth={@state.rawAzimuth}
              rawElevation={@state.rawElevation}
            />
          }
        </ul>
      </div>
    </div>

React.render <App />, document.getElementById('wrapper')
