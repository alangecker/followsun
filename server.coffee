#
#  followSun - An open source solution for tracking the sun
#
# Copyright (C) 2015 Andreas Langecker
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License
# as published by the Free Software Foundation; either version 2
# of the License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
#
# ############################################################################## 


path = require 'path'
express = require 'express'

app = express()
http = require('http').Server(app)
io = require('socket.io')(http)

config = require './config'

controller = require './plant/controller'
status = require './api/status'
suninfo = require './api/suninfo'
motor = require './api/motor'
configApi = require './api/config'
login = require './api/login'

# Start some stuff
config.loadSync()
controller.startAutoCheck()



# Backend / handle for socket.io connections
# -----------------------------------
io.on 'connection', (socket) ->
  socket.subs = []
  socket.loggedin = true
  socketRes = (type) ->
    send: (data) ->
      socket.emit type, data

  socket.on 'login', (args) -> login(socket, args)
  socket.on 'status', -> status(socket)
  socket.on 'status.sub', ->
    socket.subs.push = setInterval (-> status(socket)), 200
  socket.on 'suninfo', -> suninfo(socket)
  socket.on 'motor', (args) -> motor(socket, args)
  socket.on 'config', (args) -> configApi(socket, args)

  socket.on 'disconnect', ->
    clearInterval(interval) for interval in socket.subs



# Frontend
# -----------------------------------
app.use express.static path.join(__dirname, 'frontend/dist')

# catch 404 and forward to error handler
app.use (req, res, next) ->
  err = new Error('Not Found')
  err.status = 404
  next(err)

# -----------------------------------

# start server
server = http.listen config.serverPort, ->
  host = server.address().address
  port = server.address().port
  console.log 'followSun listening at http://%s:%s', host, port
