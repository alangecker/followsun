module.exports = React.createClass
  displayName: 'CurrentAzimuth'
  render: ->
    <div>
      <div id="azimuth">
        <div className="finger sunRiseSet" style={{transform:"rotate(#{@props.sunrise}deg)"}}></div>
        <div className="finger sunRiseSet" style={{transform:"rotate(#{@props.sunset}deg)"}}></div>
        <div className="finger sun" style={{transform:"rotate(#{@props.sun}deg)"}}>
          <i className="mdi mdi-white-balance-sunny"></i>
        </div>
        <div className="finger plant" style={{transform:"rotate(#{@props.plant}deg)"}}>
          <i className="mdi mdi-view-module"></i>
        </div>
      </div>
      <div className="data">
        <i className="mdi mdi-white-balance-sunny"></i> Sonne: {@props.sun}&#176;
        <span className="seperator">|</span>
        <i className="mdi mdi-view-module"></i> Anlage: {@props.plant}&#176;
      </div>
    </div>
