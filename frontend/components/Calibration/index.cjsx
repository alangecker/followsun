api = require '../api'
CalibrationLine = require './CalibrationLine'
CalibrationForm = require './CalibrationForm'

module.exports = React.createClass
  displayName: 'Calibration'

  saveAzimuth: (scale, offset) ->
    api.send 'config', ['azimuthCalibration', scale, offset]

  saveElevation: (scale, offset) ->
    api.send 'config', ['elevationCalibration', scale, offset]


  render: ->
    <li id="calibration">
      <div className="collapsible-header"><i className="mdi mdi-screen-rotation"></i>Kalibrierung</div>
      <div className="collapsible-body">
        <div className="row">
          <div className="col s12 m6">
            <div className="label">Azimuth-Sensor</div>
            <CalibrationForm raw={@props.rawAzimuth} saveHandler={@saveAzimuth} />
          </div>
          <div className="col s12 m6">
            <div className="label">Elevation-Sensor</div>
            <CalibrationForm raw={@props.rawElevation} saveHandler={@saveElevation} />
          </div>
        </div>
      </div>
    </li>
