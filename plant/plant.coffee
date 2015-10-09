gpio = require('onoff').Gpio
mcp3308 = require('mcp3308.js')

config = require '../config'

module.exports = plant =
  pins: {}
  adc: null

  setGPIO: (pin, v, cb) ->
    throw new Error("Pin #{pin} has not been setuped") unless @pins[pin]
    if config.gpioInverse
      v = if v then 0 else 1
    @pins[pin].writeSync v
    cb() if cb

  setupGPIO: (pin, type) ->
    @pins[pin] = new gpio(pin, type);

  setupSPI: ->
    @adc = new mcp3308(config.spidev)

  getSPIValue: (channel, cb) ->
    @adc.read channel, (value) ->
      cb(null, value)
