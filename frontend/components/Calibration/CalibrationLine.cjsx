FloatInput = require '../common/FloatInput'

module.exports = React.createClass
  displayName: 'CalibrationLine'
  addDelete: ->
    if @props.addHandler
      @props.addHandler()
    else
      @props.deleteHandler(@props.index)

  updateRaw: (value) ->
    v = parseFloat value
    @props.changeHandler @props.index, 'raw', v if v != @props.raw

  updateValue: (value) ->
    v = parseFloat value
    @props.changeHandler @props.index, 'value', v if v != @props.value

  render: ->
    <div className="row">
      <div className="col s2"><a className="btn-floating waves-effect waves-light" onClick={@addDelete}><i className={"mdi mdi-"+(if @props.addHandler then 'plus' else 'delete')}></i></a></div>
      <FloatInput name="calibration_raw" value={@props.raw} title="Rohwert" className="input-field col s4" disabled={@props.disabled} submit={@updateRaw} />
      <FloatInput name="calibration_real" value={@props.value} title="Grad" className="input-field col s4 degree" disabled={@props.disabled} submit={@updateValue} />
    </div>
