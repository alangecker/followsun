api = require '../api'

module.exports = React.createClass
  displayName: 'FloatInput'
  getInitialState: ->
    value: ''
    manual: false

  componentWillReceiveProps: ->
    @setState value: @props.value unless @state.manual

  componentWillMount: ->
    @setState value: @props.value

  update: (e) ->
    v = e.target.value.replace(',', '.')
    match = v.match(/^\-?[0-9]*\.?[0-9]*$/)
    @setState(
      value: v
      manual: true
    ) if match

  submit: (e) ->
    if @state.value != @props.value
      if @props.submit
        @props.submit(@state.value)
      else
        api.send 'config', [@props.name, @state.value]

  render: ->
    <div className={@props.className}>
      <input id={'input_'+@props.name} placeholder="" type="text" value={@state.value} onChange={@update} onBlur={@submit} disabled={@props.disabled} />
      <label htmlFor={'input_'+@props.name} className="active">{@props.title}</label>
    </div>
