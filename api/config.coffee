config = require '../config'
controller = require '../plant/controller'
module.exports = (socket, args) ->

  if args
    if not socket.loggedin
      socket.emit 'showError', 'Nicht eingeloggt'
      return
    switch args[0]
      when 'toggleAutomatic'
        config.set 'automatic', !config.automatic
        controller.startAutoCheck()

      when 'latitude'
        value = parseFloat(args[1])
        config.set 'latitude', value if value >= -90 and value <= 90
      when 'longitude'
        value = parseFloat(args[1])
        config.set 'longitude', value if value >= -180 and value <= 180

      when 'stormAzimuth', 'stormThreshold', 'minAzimuth', 'maxAzimuth'
        value = parseInt(args[1])
        config.set args[0], value if value >= 0 and value <= 360

      when 'stormElevation', 'minElevation', 'maxElevation'
        value = parseInt(args[1])
        config.set args[0], value if value >= 0 and value <= 90

      when 'azimuthScale', 'azimuthOffset', 'elevationScale', 'elevationOffset'
        config.set args[0], parseFloat(args[1])

      when 'azimuthTolerance', 'elevationTolerance'
        value = parseFloat(args[1])
        config.set args[0], value if value >= 0 and value <= 90

      when 'azimuthCalibration'
        scale = parseFloat args[1]
        offset = parseFloat args[2]
        config.set 'azimuthScale', scale unless isNaN scale
        config.set 'azimuthOffset', offset unless isNaN offset
        socket.emit 'success', 'Azimuth-Sensor wurde erfolgreich kalibriert'

      when 'elevationCalibration'
        scale = parseFloat args[1]
        offset = parseFloat args[2]
        config.set 'elevationScale', scale unless isNaN scale
        config.set 'elevationOffset', offset unless isNaN offset
        socket.emit 'success', 'Elevation-Sensor wurde erfolgreich kalibriert'

      when 'title'
        console.log args
        config.set 'title', args[1]


  socket.emit 'config', config.getSoftConf()
