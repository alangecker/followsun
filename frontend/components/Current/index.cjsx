Azimuth = require './CurrentAzimuth'
Elevation = require './CurrentElevation'

module.exports = React.createClass
  displayName: 'Current'
  render: ->
    <li id="info">
      <div className="collapsible-header active">
        <i className="mdi mdi-leaf"></i>
        Aktuelle Daten
        {switch @props.status
          when 'sun'
            <div className="chip tooltipped" data-position="bottom" data-delay="50" data-tooltip="Anlage steht direkt zur Sonne gerichtet"><i className="mdi mdi-weather-sunny"></i>In der Sonne</div>
          when 'storm'
            <div className="chip tooltipped" data-position="bottom" data-delay="50" data-tooltip="In Sturmposition"><i className="material-icons">wb_sunny</i>Sturmposition</div>
          when 'morning'
            <div className="chip tooltipped" data-position="bottom" data-delay="50" data-tooltip="Bereit für den Sonnenaufgang"><i className="mdi mdi-weather-sunset-up"></i>Sonnenaufgang</div>
        }
        {if @props.automatic
            <div className="chip tooltipped" data-position="bottom" data-delay="50" data-tooltip="Anlage richtet sich automatisch aus"><i className="material-icons">wb_sunny</i> Automatik</div>
        }
      </div>
      <div className="collapsible-body">
        <div className="row">
          <div className="col m6">
            <Azimuth
              plant={@props.plantAzimuth}
              sun={@props.sunAzimuth}
              sunrise={@props.sunriseAzimuth}
              sunset={@props.sunsetAzimuth}

            />
          </div>
          <div className="col m6">
              <Elevation
                plant={@props.plantElevation}
                sun={@props.sunElevation}
              />
          </div>
        </div>
      </div>
    </li>
