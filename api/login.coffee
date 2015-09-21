config = require '../config'
module.exports = (socket, pw) ->
  if pw == config.password
    socket.emit 'login', {success:true}
    socket.loggedin = true
  else
    socket.emit 'login', {success:false}
