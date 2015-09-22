plant = require './plant'
config = require '../config'

module.exports =

  # current movement direction
  azimuthDirection: null

  # start azimuth motor in given direction
  startAzimuth: (direction) ->
    return false if direction != 'right' and direction != 'left'
    @azimuthDirection = direction

    plant.setGPIO(config.azimuthRightPin, 1) if direction is 'right'
    plant.setGPIO(config.azimuthLeftPin, 1) if direction is 'left'

  # stop azimuth movement
  stopAzimuth: ->
    plant.setGPIO(config.azimuthRightPin, 0)
    plant.setGPIO(config.azimuthLeftPin, 0)
    @azimuthDirection = null



  # ====================================================



  # current movement direction
  elevationDirection: null

  # start elevation motor in given direction
  startElevation: (direction) ->
    return false if direction != 'up' and direction != 'down'
    @elevationDirection = direction

    plant.setGPIO(18, 1) if direction is 'up'
    plant.setGPIO(19, 1) if direction is 'down'

  # stop elevation movement
  stopElevation: ->
    plant.setGPIO(18, 0)
    plant.setGPIO(19, 0)
    @elevationDirection = null
