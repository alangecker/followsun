fs = require 'fs'

module.exports = config =

  # webserver settings
  # ------------------------------
  serverPort: 3000
  password: 'test'


  # Hardware settings
  # ------------------------------
  # GPIO
  gpioInverse: true
  azimuthRightPin: 4
  azimuthLeftPin: 17
  elevationUpPin: 11
  elevationDownPin: 12

  # SPI
  spidev: '/dev/spidev0.0'
  azimuthSensorChannel: 0
  elevationSensorChannel: 1


  # SOFT CONFIGURATIONS
  # => all parameters which are editable by the frontend
  #   will be saved in an JSON-File
  # ======================================
  # instead of calling directly (maybe multiple changes at the same moment)
  # it waits for 10 secs after the last change

  softConfFile: './config.soft.json'

  # gets the whole conf parameters
  getSoftConf: ->
    softConf = {}
    softConf[key] = @[key] for key in softConfKeys
    return softConf

  _saveTimeout: null
  # sets the variable at this object and waits if other changes
  set: (key, value) ->
    @[key] = value
    clearTimeout @_saveTimeout if @_saveTimeout
    @_saveTimeout = setTimeout config.save, 10000

  # save after the timeout
  save: ->
    json = JSON.stringify(config.getSoftConf(), null, 4)
    fs.writeFile config.softConfFile, json, (err) ->
      console.log err if err
      console.log("config saved to " + config.softConfFile) unless err

  # load the .json-file
  loadSync: ->
    json = JSON.parse fs.readFileSync config.softConfFile
    @[key] = json[key] for value,key of softConfKeys


# possible keys
softConfKeys = [
  'title'
  'automatic'
  'latitude'
  'longitude'
  'stormAzimuth'
  'stormElevation'
  'stormThreshold' # in m/s
  'minAzimuth' # in degrees
  'maxAzimuth' # in degrees
  'azimuthScale'
  'azimuthOffset' # in degrees, calibration
  'azimuthTolerance'
  'minElevation' # in degrees
  'maxElevation' # in degrees
  'elevationScale'
  'elevationOffset' # in degrees, calibration
  'elevationTolerance'
]
