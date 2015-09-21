motor = require '../plant/motor'
controller = require '../plant/controller'

module.exports = (socket, args) ->
  if not socket.loggedin
    socket.emit 'showError', 'Nicht eingeloggt'
    return

  if args[0] == 'azimuth'
    switch args[1]
      when 'right', 'left'
        motor.startAzimuth args[1]
      when 'stop'
        motor.stopAzimuth()
      else
        controller.setAzimuth args[1], (error) ->
          socket.emit 'showError', error

  else if args[0] == 'elevation'
    switch args[1]
      when 'top', 'down'
        motor.startElevation args[1]
      when 'stop'
        motor.stopElevation()
      else
        controller.setElevation args[1], (error) ->
          socket.emit 'showError', error
