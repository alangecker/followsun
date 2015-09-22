plant = require './plant'
config = require '../config'

module.exports =

  # current movement direction
  azimuthDirection: null

  # start azimuth motor in given direction
  startAzimuth: (direction) ->
    return false if direction != 'right' and direction != 'left'
    @azimuthDirection = direction

    plant.setGPIO(config.azimuthRightPin, if direction is 'right' then 1 else 0)
    plant.setGPIO(config.azimuthLeftPin, if direction is 'left' then 1 else 0)

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

    plant.setGPIO(config.elevationUpPin, if direction is 'up' then 1 else 0)
    plant.setGPIO(config.elevationDownPin, if direction is 'down' then 1 else 0) 

  # stop elevation movement
  stopElevation: ->
    plant.setGPIO(18, 0)
    plant.setGPIO(19, 0)
    @elevationDirection = null
