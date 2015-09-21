api = require '../api'
CalibrationLine = require './CalibrationLine'

module.exports = React.createClass
  displayName: 'CalibrationForm'
  getInitialState: ->
    values: []
    calculatedScale: NaN
    calculatedOffset: NaN

  addHandler: ->
    values = @state.values
    values.push
      raw: @props.raw
      value: null
    @calculate(values)
    @setState values: values

  changeHandler: (index, field, value) ->
    values = @state.values
    values[index][field] = value
    @calculate(values)
    @setState values: values

  deleteHandler: (index) ->
    values = @state.values
    values.splice(index, 1)
    @calculate(values)
    @setState values: values

  calculate: (values) ->
    console.log values
    avgRaw = @helpers.avgRaw(values)
    avgValue = @helpers.avgValue(values)

    scale = @helpers.calculateScale(values, avgRaw, avgValue)
    offset = @helpers.calculateOffset(scale, avgRaw, avgValue)
    @setState
      calculatedScale: scale
      calculatedOffset: offset
    console.log scale, offset

  helpers:
    avgRaw: (values) ->
      return false unless values.length
      sum = 0
      (sum += v.raw if v.raw) for v in values
      return sum/values.length

    avgValue: (values) ->
      return false unless values.length
      sum = 0
      (sum += v.value if v.value)  for v in values
      return sum/values.length

    calculateScale: (values, avgRaw, avgValue) ->
      a = 0
      b = 0
      for v in values
        raw_m = v.raw-avgRaw
        value_m = v.value-avgValue
        a += raw_m*value_m
        b += raw_m*raw_m
      return a/b

    calculateOffset: (scale, avgRaw, avgValue) ->
      return avgValue-scale*avgRaw

  save: ->
    @props.saveHandler @state.calculatedScale, @state.calculatedOffset


  render: ->
    <div>
      {@state.values.map (l, i) =>
        <CalibrationLine
          index={i}
          raw={l.raw}
          value={l.value}
          changeHandler={@changeHandler}
          deleteHandler={@deleteHandler}
        />
      }
      <CalibrationLine
        raw={@props.raw}
        disabled=true
        addHandler={@addHandler} />
      <div className="row calculated">
        <div className="col s2">
            <i className="mdi mdi-settings"></i>
        </div>
        <div className="input-field col s4">
          <div>{if isNaN(@state.calculatedScale) then '-' else @state.calculatedScale}</div>
          <label className="active">Skalierung</label>
        </div>
        <div className="input-field col s4">
          <div>{if isNaN(@state.calculatedOffset) then '-' else @state.calculatedOffset}</div>
          <label className="active">Offset</label>
        </div>
        <div className="col s2">
        {if isNaN(@state.calculatedScale) or isNaN(@state.calculatedOffset)
          <a className="btn disabled tooltipped" data-position="bottom" data-delay="50" data-tooltip="Werte ungültig"><i className="mdi left mdi-send"></i></a>
        else
          <a className="waves-effect waves-light btn tooltipped" data-position="bottom" data-delay="50" data-tooltip="Werte übernehmen" onClick={@save}><i className="mdi left mdi-send"></i></a>
        }

        </div>
      </div>
    </div>
