controller = require './plant/controller'
motor = require './plant/motor'
sensor = require './plant/sensor'


showStats = ->
  sensor.getCurrentAzimuth (v,raw) ->
    console.log "[sensor] Azimuth: \t#{raw}\t#{v}°"
  sensor.getCurrentElevation (v,raw) ->
    console.log "[sensor] Elevation: \t#{raw}\t#{v}°"

motorTestAzimuth = (direction)->
  console.log '[motor] Azimuth start - Direction: '+direction
  setTimeout(->
    motor.startAzimuth()
    setTimeout( ->
      motorTestAzimuth(if direction == 'right' then 'left' else 'right')
    , 10000)
  ,1000)

motorTestAzimuth = (direction)->
  console.log '[motor] Elevation start - Direction: '+direction
  setTimeout(->
    motor.startAzimuth()
    setTimeout( ->
      motorTestAzimuth(if direction == 'up' then 'down' else 'up')
    , 10000)
  ,1000)




controller.setup ->
  setInterval(showStats, 1000)
  setTimeout(motorTestAzimuth, 1000)
  setTimeout(motorTestElevation, 5000)
