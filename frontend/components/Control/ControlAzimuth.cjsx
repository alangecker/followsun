api = require '../api'

module.exports = React.createClass
  displayName: 'ControlAzimuth'
  getInitialState: ->
    value: null

  valueChange: (e) ->
    @setState value: e.target.value


  startLeft: ->
    api.send 'motor', ['azimuth', 'left']
  startRight: ->
    api.send 'motor', ['azimuth', 'right']
  stop: ->
    api.send 'motor', ['azimuth', 'stop']

  setValue: ->
    api.send 'motor', ['azimuth', parseInt @state.value ] if @state.value != null and @state.value != ''

  renderEnabled: ->
    <div className="stopped">
      <div className="degree_select">
        <input id="azimuth_set" placeholder={@props.current} type="text" className="validate" value={@state.value} onChange={@valueChange}/>&#176;
        <a className="waves-effect waves-light btn tooltipped" data-position="bottom" data-delay="50" data-tooltip="Gewählten Wert einstellen" onClick={@setValue}><i className="mdi mdi-keyboard-return"></i></a>
      </div>
      <a className="waves-effect waves-light btn tooltipped" data-position="bottom" data-delay="50" data-tooltip="Im Uhrzeigersinn" onClick={@startRight}><i className="mdi mdi-rotate-right"></i></a>
      <a className="waves-effect waves-light btn tooltipped" data-position="bottom" data-delay="50" data-tooltip="Gegen Uhrzeigersinn" onClick={@startLeft}><i className="mdi mdi-rotate-left"></i></a>
    </div>

  renderDisabled: ->
    <div className="stopped">
      <div className="degree_select">
        <input id="azimuth_set" placeholder={@props.current} type="text" className="validate" value={@state.value} onChange={@valueChange}/>&#176;
        <a className="btn disabled" data-position="bottom" data-delay="50" data-tooltip="Deaktiviert (Automodus ist aktiviert)" ><i className="mdi mdi-keyboard-return"></i></a>
      </div>
      <a className="btn disabled" data-position="bottom" data-delay="50" data-tooltip="Deaktiviert (Automodus ist aktiviert)"><i className="mdi mdi-rotate-right"></i></a>
      <a className="btn disabled" data-position="bottom" data-delay="50" data-tooltip="Deaktiviert (Automodus ist aktiviert)"><i className="mdi mdi-rotate-left"></i></a>
    </div>

  render: ->
    <div className={"col s12 m4"+(if @props.active then ' active' else '')}>
    <div className="title">Azimuth</div>
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
