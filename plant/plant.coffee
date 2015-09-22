gpio = require('onoff').Gpio
mcp3008 = require('mcp3008.js')

config = require '../config'

module.exports = plant =
  pins: {}
  adc: null

  setGPIO: (pin, v, cb) ->
    if config.gpioInverse
      v = 0 if v
      v = 1 if not v
    console.log "[GPIO] set pin #{pin} to #{v}"
    @pins[pin].writeSync v
    cb() if cb

  setupGPIO: (pin, type) ->
    @pins[pin] = new gpio(pin, type);

  setupSPI: ->
    @adc = new mcp3008(config.spidev)

  getSPIValue: (channel, cb) ->
    console.log "[SPI] read channel #{channel}"
    @adc.read channel, (value) ->
      cb(null, value)
