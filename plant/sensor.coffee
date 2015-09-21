debug = require('debug')('sensor')
helpers = require './helpers'
fakePlant = require './fakePlant'

module.exports =

  # get value from sensor, calculate real position in degrees
  # and call callback
  getCurrentAzimuth: (cb) ->
    raw = fakePlant.azimuth
    cur = helpers.calculateAzimuth(raw) # TODO: read from MCP3008
    cb(cur, raw) if cb


  # get value from sensor, calculate real position in degrees
  # and call callback
  getCurrentElevation: (cb) ->
    raw = fakePlant.elevation
    cur = helpers.calculateElevation(raw) # TODO: read from MCP3008
    cb(cur, raw) if cb
