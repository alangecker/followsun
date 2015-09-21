config = require '../config'
helpers = require './helpers'
sensor = require './sensor'
motor = require './motor'

module.exports = Controller =
  stormActive: false


  # start the Auto-Interval
  autoInterval: null
  startAutoCheck: ->
    @_checkAutomatic()
    clearInterval @autoInterval if @autoInterval
    @autoInterval = setInterval @_checkAutomatic, 60000

  # Callback for the interval
  _checkAutomatic: ->
    return unless config.automatic
    Controller.setToSun()


  # move plant to the sun,
  # or to the morning-position if it after midnight
  # (take care of ranges)
  setToSun: ->
    pos = helpers.currentSunPosition()

    # sun already down and after midnight?
    if pos.altitude < 0 and (new Date()).getHours() < 12
      pos = helpers.morningSunPosition()

    # values in range?
    pos.azimuth = config.minAzimuth if pos.azimuth < config.minAzimuth
    pos.azimuth = config.maxAzimuth if pos.azimuth > config.maxAzimuth
    pos.altitude = config.minElevation if pos.altitude < config.minElevation
    pos.altitude = config.maxElevation if pos.altitude > config.maxElevation

    # move to position
    @setAzimuth pos.azimuth
    @setElevation pos.altitude



  # ====================================================

  # ***
  # Azimuth
  # ***
  azimuthMovementInterval: null
  azimuthTarget: null
  setAzimuth: (degrees, cb) ->
    console.log "set azimuth to #{degrees}°"

    # check if azimuth is possible
    if degrees < config.minAzimuth or degrees > config.maxAzimuth
      cb "#{degrees}° is outside the azimuth-range"
      return false

    # get current azimuth
    sensor.getCurrentAzimuth (curDegrees) =>

      # do nothing if in tolerance
      return if Math.abs(curDegrees-degrees) < config.azimuthTolerance

      # decide the direction and start
      if curDegrees > degrees then motor.startAzimuth('left')
      else motor.startAzimuth('right')

      @azimuthTarget = degrees
      @azimuthMovementInterval = setInterval(@_checkAzimuthMovement, 500)

  # callback for movement-check-Interval
  _checkAzimuthMovement: =>
    return @_stopAzimuthMovement() unless motor.azimuthDirection
    sensor.getCurrentAzimuth (curDegrees) =>
      _this = Controller # small fix

      # check if target azimuth is reached
      if motor.azimuthDirection is 'right' and curDegrees >= @azimuthTarget
          @_stopAzimuthMovement()
      else if motor.azimuthDirection is 'left' and curDegrees <= @azimuthTarget
          @_stopAzimuthMovement()


  # stop movement
  _stopAzimuthMovement: ->
      console.log 'stop azimuth movement'
      clearInterval @azimuthMovementInterval
      motor.stopAzimuth()



  # ====================================================

  # ***
  # Elevation
  # ***
  elevationMovementInterval: null
  elevationTarget: null
  setElevation: (degrees, cb) ->
    console.log "set elevation to #{degrees}°"

    # check if elevation is possible
    if degrees < config.minElevation or degrees > config.maxElevation
      cb "#{degrees}° is outside the elevation-range"
      return false

    # get current elevation
    sensor.getCurrentElevation (curDegrees) =>

      # do nothing if in tolerance
      return if Math.abs(curDegrees-degrees) < config.elevationTolerance

      # decide the direction and start
      if curDegrees > degrees then motor.startElevation('down')
      else motor.startElevation('up')

      @elevationTarget = degrees
      @elevationMovementInterval = setInterval(@_checkElevationMovement, 500)

  # interval-callback
  _checkElevationMovement: =>
    return @_stopElevationMovement() unless motor.elevationDirection
    sensor.getCurrentElevation (curDegrees) =>
      _this = Controller # small fix

      # check if target elevation is reached
      if motor.elevationDirection is 'up' and curDegrees >= @elevationTarget
          @_stopElevationMovement()
      else if motor.elevationDirection is 'down' and curDegrees <= @elevationTarget
          @_stopElevationMovement()


  # stop movement
  _stopElevationMovement: ->
      console.log 'stop elevation movement'
      clearInterval @elevationMovementInterval
      motor.stopElevation()
