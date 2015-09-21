api = require '../api'

module.exports = React.createClass
  displayName: 'ControlMode'
  toggleValue: ->
    api.send 'config', ['toggleAutomatic']


  render: ->
        <div className="col m4">
          <div className="title">Modus</div>
            <div className="label">Automatische Ausrichtung</div>
            <div className="switch">
              <label>
                Aus
                <input type="checkbox" onChange={@toggleValue} checked={@props.automatic}/>
                <span className="lever"></span>
                An
              </label>
            </div>
        </div>
