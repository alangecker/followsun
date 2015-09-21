api = require '../api'
module.exports = React.createClass
  displayName: 'Slider'
  slider: null
  getDefaultProps: ->
    from: 0
    to: 100
    max: 100
  componentDidUpdate: ->
    @slider.noUiSlider.set [@props.from, @props.to]
  componentDidMount: ->
    @slider = $("> div", @getDOMNode()).get(0)
    noUiSlider.create @slider,
    	start: [ @props.from, @props.to ],
    	step: 1, # Slider moves in increments of '10'
    	margin: 10, # Handles must be more than '20' apart
    	connect: true, # Display a colored bar between the handles
    	# orientation: 'vertical', # Orient the slider vertically
    	behaviour: 'tap-drag', # Move handle on tap, bar is draggable
    	range: { # Slider can select '0' to '100'
    		'min': 0,
    		'max': @props.max
    	},
    	pips:
    		mode: 'count',
    		values: 7,
    		density: 3,
    		stepped: true


    @slider.noUiSlider.on 'change', @changeHandler

  changeHandler: ->
    values = @slider.noUiSlider.get()
    from = parseInt values[0]
    to = parseInt values[1]
    api.send 'config', [@props.fromName, from] if from != parseInt @props.from
    api.send 'config', [@props.toName, to] if to != parseInt @props.to
  render: ->
    <div className="sliderBox">
      <div></div>
    </div>
