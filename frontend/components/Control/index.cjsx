ControlAzimuth = require './ControlAzimuth'
ControlElevation = require './ControlElevation'
ControlMode = require './ControlMode'

module.exports = React.createClass
  displayName: 'Control'
  render: ->
    <li id="control">
      <div className="collapsible-header"><i className="mdi mdi-arrow-all"></i>Steuerung</div>
      <div className="collapsible-body"><div className="row">
        <ControlAzimuth
          current={@props.azimuth}
          active={@props.azimuthMovement != null}
          disabled={@props.automatic}
        />
        <ControlElevation
          current={@props.elevation}
          active={@props.elevationMovement != null}
          disabled={@props.automatic}
        />
        <ControlMode
          automatic={@props.automatic}
        />
      </div></div>
    </li>
