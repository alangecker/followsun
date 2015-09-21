apiURL = ''

# just a small API layer on top on socket.io
module.exports = api =
  socket: null
  connected: false
  connect: (cb) ->
    @socket = io(apiURL)

    @socket.on 'connect', =>
      @connected = true
      cb() if cb


  on: (key, cb) ->
    @socket.on key, cb

  connected: (cb) ->
    return cb() unless @connected
    @socket.on 'connect', cb

  send: (key, value) ->
    @socket.emit key, value

api.connect()
