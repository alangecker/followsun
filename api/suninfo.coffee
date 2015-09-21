sensor = require '../plant/sensor'
helpers = require '../plant/helpers'

module.exports = (socket) ->
  response = times = helpers.sunTimes()
  sun = helpers.currentSunPosition()

  response.sunrisePos = helpers.getSunPosition(times.sunrise)
  response.sunsetPos = helpers.getSunPosition(times.sunset)

  socket.emit 'suninfo',  response
