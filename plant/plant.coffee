gpio = require('onoff').Gpio
mcp3008 = require('mcp3008.js')

config = require '../config'

module.exports = plant =
  pins: {}
  adc: null

  setGPIO: (pin, v, cb) ->
    @pins[pin].writeSync v
    cb() if cb

  setupGPIO: (pin, type) ->
    @pins[pin] = new gpio(pin, type);

  setupSPI: ->
    @adc = new mp3008(config.spidev)

  getSPIValue: (channel, cb) ->
    @adc.read channel, (value) ->
      cb(null, value)
