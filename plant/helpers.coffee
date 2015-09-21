suncalc = require 'suncalc'
config = require '../config'
module.exports =

  # get sun-position at given time
  getSunPosition: (time) ->
    res = suncalc.getPosition time, config.latitude, config.longitude

    azimuth: (res.azimuth * 180/Math.PI)+180
    altitude: (res.altitude * 180/Math.PI)

  # get current sun-position
  currentSunPosition: ->
    @getSunPosition new Date()

  # get sun-position at sunrise
  morningSunPosition: ->
    @getSunPosition @sunTimes().sunrise

  # get the morning-position for the plant
  # => as close to the sun-position as possible
  morningPosition: ->
    pos = @morningSunPosition()
    pos.azimuth = config.minAzimuth if pos.azimuth < config.minAzimuth
    pos.azimuth = config.maxAzimuth if pos.azimuth > config.maxAzimuth

    pos.altitude = config.minElevation if pos.altitude < config.minElevation
    pos.altitude = config.maxElevation if pos.altitude > config.maxElevation
    return pos

  # get all times that a single-star-system can have
  sunTimes: ->
    suncalc.getTimes(new Date(), config.latitude, config.longitude)


  # calculate the azimuth position from the sensorValue in degrees
  calculateAzimuth: (sensorValue) ->
    config.azimuthScale*sensorValue+config.azimuthOffset


  # calculate the elevation position from the sensorValue in degrees
  calculateElevation: (sensorValue) ->
    config.elevationScale*sensorValue+config.elevationOffset
