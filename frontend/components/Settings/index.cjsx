Slider = require './Slider'
FloatInput = require '../common/FloatInput'
api = require '../api'

module.exports = React.createClass
  displayName: 'Settings'
  getInitialState: ->
    title: ''
  changeTitle: (e) ->
    @setState title: e.target.value

  sendTitle: ->
    api.send 'config', ['title', @state.title]
  componentDidMount: ->
    @setState title: @props.title
  componentDidUpdate: (prevProps, prevState) ->
    if prevProps.title != @props.title
      @setState title: @props.title

  render: ->
    <li id="settings">
      <div className="collapsible-header"><i className="mdi mdi-settings"></i>Einstellungen</div>
      <div className="collapsible-body">
        <div className="row">
          <div className="col m6 s12">
            <div className="label">Titel der Anlage</div>
            <div className="input-field">
              <input placeholder="Titel" id="input_title" type="text" onChange={@changeTitle} onBlur={@sendTitle} value={@state.title}/>
            </div>
            <div className="label">Koordinaten der Anlage</div>
            <div className="row">
              <FloatInput name="latitude" value={@props.latitude} title="Breitengrad" className="input-field col s6" />
              <FloatInput name="longitude" value={@props.longitude} title="Längengrad" className="input-field col s6" />
            </div>
            <div className="map" style={{backgroundImage:"url('http://staticmap.openstreetmap.de/staticmap.php?center=#{@props.latitude},#{@props.longitude}&zoom=14&size=500x300&maptype=mapnik')"}}>
              <i className="mdi mdi-map-marker"></i>
            </div>

          </div>
          <div className="col m6 s12">
            <div className="label">Sturmposition</div>
            <div className="row">
              <FloatInput name="stormAzimuth" value={@props.stormAzimuth} title="Azimuth" className="input-field col s4 degree" />
              <FloatInput name="stormElevation" value={@props.stormElevation} title="Elevation" className="input-field col s4 degree" />
              <FloatInput name="stormThreshold" value={@props.stormThreshold} title="Geschwindigkeit" className="input-field col s4 speed" />
            </div>
            <div className="label">Azimuth-Bereich</div>
            <Slider
              fromName="minAzimuth"
              from={@props.minAzimuth}
              toName="maxAzimuth"
              to={@props.maxAzimuth}
              max=360 />
            <div className="label">Elevation-Bereich</div>
            <Slider
              fromName="minElevation"
              from={@props.minElevation}
              toName="maxElevation"
              to={@props.maxElevation}
              max=90 />
            <div className="label">Azimuth-Sensor</div>
            <div className="row">
              <FloatInput name="azimuthScale" value={@props.azimuthScale} title="Skalierung" className="input-field col s4" />
              <FloatInput name="azimuthOffset" value={@props.azimuthOffset} title="Offset" className="input-field col s4" />
              <FloatInput name="azimuthTolerance" value={@props.azimuthTolerance} title="Toleranz" className="input-field col s4 degree" />
            </div>
            <div className="label">Elevation-Sensor</div>
            <div className="row">
              <FloatInput name="elevationScale" value={@props.elevationScale} title="Skalierung" className="input-field col s4" />
              <FloatInput name="elevationOffset" value={@props.elevationOffset} title="Offset" className="input-field col s4" />
              <FloatInput name="elevationTolerance" value={@props.elevationTolerance} title="Toleranz" className="input-field col s4 degree" />
            </div>

          </div>
        </div>
      </div>
    </li>
