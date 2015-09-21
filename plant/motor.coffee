fakePlant = require './fakePlant'
config = require '../config'

module.exports =

  # current movement direction
  azimuthDirection: null

  # start azimuth motor in given direction
  startAzimuth: (direction) ->
    return false if direction != 'right' and direction != 'left'
    @azimuthDirection = direction

    fakePlant.setGPIO(config.azimuthRightPin, 1) if direction is 'right'
    fakePlant.setGPIO(config.azimuthLeftPin, 1) if direction is 'left'

  # stop azimuth movement
  stopAzimuth: ->
    fakePlant.setGPIO(config.azimuthRightPin, 0)
    fakePlant.setGPIO(config.azimuthLeftPin, 0)
    @azimuthDirection = null



  # ====================================================



  # current movement direction
  elevationDirection: null

  # start elevation motor in given direction
  startElevation: (direction) ->
    return false if direction != 'up' and direction != 'down'
    @elevationDirection = direction

    fakePlant.setGPIO(18, 1) if direction is 'up'
    fakePlant.setGPIO(19, 1) if direction is 'down'

  # stop elevation movement
  stopElevation: ->
    fakePlant.setGPIO(18, 0)
    fakePlant.setGPIO(19, 0)
    @elevationDirection = null
