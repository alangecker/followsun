module.exports = React.createClass
  render: ->
    <div>
      <div id="elevation">
        {if @props.sun > 0 and @props.sun < 180
          <div className="finger sun" style={{transform:"rotate(#{90-@props.sun}deg)"}}>
            <i className="mdi mdi-white-balance-sunny"></i>
          </div>
        }
        <div className="finger plant" style={{transform:"rotate(#{90-@props.plant}deg)"}}></div>
        <div className="plant_line" style={{transform:"rotate(#{90-@props.plant}deg)"}}></div>
      </div>
      <div className="data">
        <i className="mdi mdi-white-balance-sunny"></i> Sonne: {@props.sun}&#176;
        <span className="seperator">|</span>
        <i className="mdi mdi-view-module"></i> Anlage: {@props.plant}&#176;
      </div>
    </div>
