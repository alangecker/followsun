module.exports = fakePlant =
  gpio: {
    16: false # Azimuth
    17: false # Azimuth
    18: false # Elevation
    19: false # Elevation
  }
  spi: {
    0: 380
    1: 190
  }
  azimuth: 380
  elevation: 190

  setGPIO: (n, v, cb) ->
    @gpio[n] = v
    cb() if cb

  start: ->
    setInterval @pretend, 100

  pretend: ->
    fakePlant.spi[0] += 0.1 if fakePlant.gpio[4]
    fakePlant.spi[0] -= 0.1 if fakePlant.gpio[17]
    fakePlant.spi[1] += 0.1 if fakePlant.gpio[18]
    fakePlant.spi[1] -= 0.1 if fakePlant.gpio[19]

  setupGPIO: (pin, type) ->
    console.log 'setup '+pin

  setupSPI: ->

  getSPIValue: (channel, cb) ->
    cb(null, @spi[channel])


fakePlant.start()
