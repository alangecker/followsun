sensor = require '../plant/sensor'
motor = require '../plant/motor'
helpers = require '../plant/helpers'
controller = require '../plant/controller'
config = require '../config'


isSame = (a,b,tolerance) -> Math.abs(a-b) < tolerance

module.exports = (socket) ->
  sun = helpers.currentSunPosition()
  sensor.getCurrentAzimuth (azimuth,rawAzimuth ) -> sensor.getCurrentElevation (elevation,rawElevation) ->
    socket.currentStatus = {} unless socket.currentStatus
    values =
      plantAzimuth: (Math.round azimuth*100)/100
      rawAzimuth: rawAzimuth
      plantElevation: (Math.round elevation*100)/100
      rawElevation: rawElevation
      sunAzimuth: (Math.round sun.azimuth*10)/10
      sunElevation: (Math.round sun.altitude*10)/10
      azimuthMovement: motor.azimuthDirection
      elevationMovement: motor.elevationDirection
      wind: 20
      loggedin: socket.loggedin
      status: null

    # current status
    morningPosition = helpers.morningPosition()
    if isSame(morningPosition.azimuth, values.plantAzimuth, config.azimuthTolerance) and isSame(morningPosition.altitude, values.plantElevation, config.elevationTolerance)
      values.status = 'morning'
    else if isSame(values.sunAzimuth, values.plantAzimuth, config.azimuthTolerance) and isSame(values.sunElevation, values.plantElevation, config.elevationTolerance)
      values.status = 'sun'
    else if controller.stormActive
      values.status = 'storm'


    # compare for changes
    changes = {}
    (changes[k]=v if v != socket.currentStatus[k]) for k,v of values
    socket.currentStatus = values

    socket.emit 'status', changes if Object.keys(changes).length
