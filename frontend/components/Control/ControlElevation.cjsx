api = require '../api'

module.exports = React.createClass
  displayName: 'ControlElevation'
  getInitialState: ->
    value: null

  valueChange: (e) ->
    @setState value: e.target.value


  startUp: ->
    api.send 'motor', ['elevation', 'up']
  startDown: ->
    api.send 'motor', ['elevation', 'down']
  stop: ->
    api.send 'motor', ['elevation', 'stop']

  setValue: ->
    api.send 'motor', ['elevation', parseInt @state.value ] if @state.value != null and @state.value != ''


  renderEnabled: ->
    <div className="stopped">
      <div className="degree_select">
        <input id="azimuth_set" placeholder={@props.current} type="text" className="validate" value={@state.value} onChange={@valueChange}/>&#176;
        <a className="waves-effect waves-light btn tooltipped" data-position="bottom" data-delay="50" data-tooltip="Gewählten Wert einstellen" onClick={@setValue}><i className="mdi mdi-keyboard-return"></i></a>
      </div>
      <a className="waves-effect waves-light btn tooltipped" data-position="bottom" data-delay="50" data-tooltip="Hoch" onClick={@startUp}><i className="mdi mdi-chevron-double-up"></i></a>
      <a className="waves-effect waves-light btn tooltipped" data-position="bottom" data-delay="50" data-tooltip="Runter" onClick={@startDown}><i className="mdi mdi-chevron-double-down"></i></a>
    </div>

  renderDisabled: ->
    <div className="stopped">
      <div className="degree_select">
        <input id="azimuth_set" placeholder={@props.current} type="text" className="validate" value={@state.value} onChange={@valueChange}/>&#176;
        <a className="btn disabled" data-position="bottom" data-delay="50" data-tooltip="Deaktiviert (Automodus ist aktiviert)" ><i className="mdi mdi-keyboard-return"></i></a>
      </div>
      <a className="btn disabled" data-position="bottom" data-delay="50" data-tooltip="Deaktiviert (Automodus ist aktiviert)"><i className="mdi mdi-chevron-double-up"></i></a>
      <a className="btn disabled" data-position="bottom" data-delay="50" data-tooltip="Deaktiviert (Automodus ist aktiviert)"><i className="mdi mdi-chevron-double-down"></i></a>
    </div>

  render: ->
    <div className={"col s12 m4"+(if @props.active then ' active' else '')}>
    <div className="title">Elevation</div>
      {if @props.disabled then @renderDisabled() else @renderEnabled()}
      <div className="running">
          <div className="preloader-wrapper small active">
            <div className="spinner-layer spinner-green-only">
              <div className="circle-clipper left">
                <div className="circle"></div>
              </div><div className="gap-patch">
                <div className="circle"></div>
              </div><div className="circle-clipper right">
                <div className="circle"></div>
              </div>
            </div>
          </div><span className="current">{Math.round @props.current}&#176;</span><br />
          <a className="waves-effect waves-light btn" onClick={@stop}><i className="mdi mdi-block-helper"></i> Stop</a>
      </div>
    </div>
