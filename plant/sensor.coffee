helpers = require './helpers'
plant = require './plant'
config = require '../config'
module.exports =

  # get value from sensor, calculate real position in degrees
  # and call callback
  getCurrentAzimuth: (cb) ->
    plant.getSPIValue config.azimuthSensorChannel, (err, raw) ->
      cur = helpers.calculateAzimuth(raw) # TODO: read from MCP3008
      cb(cur, raw) if cb


  # get value from sensor, calculate real position in degrees
  # and call callback
  getCurrentElevation: (cb) ->
    plant.getSPIValue config.elevationSensorChannel, (err, raw) ->
      cur = helpers.calculateElevation(raw) # TODO: read from MCP3008
      cb(cur, raw) if cb
