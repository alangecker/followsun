module.exports = fakePlant =
  gpio: {
    16: false # Azimuth
    17: false # Azimuth
    18: false # Elevation
    19: false # Elevation
  }
  azimuth: 380
  elevation: 190

  setGPIO: (n, v) ->
    @gpio[n] = v

  start: ->
    setInterval @pretend, 100

  pretend: ->
    fakePlant.azimuth += 0.1 if fakePlant.gpio[16]
    fakePlant.azimuth -= 0.1 if fakePlant.gpio[17]
    fakePlant.elevation += 0.1 if fakePlant.gpio[18]
    fakePlant.elevation -= 0.1 if fakePlant.gpio[19]


fakePlant.start()
