async = require 'async'
bodyParser = require 'body-parser'
eventLoggerHtml = require './html_event_logger'
express = require 'express'
fs = require 'fs'
http = require 'http'
https = require 'https'
sslKeys = require './ssl_keys'


class TestWebServer

  constructor: ->
    @respondWithHtml = ''
    @eventHistory = []
    @requestHistory = []

    @app = express()
    @app.use bodyParser.json()
    @app.post '/log-event', @_handleLogEvent
    @app.get '*', @_handleRequest


  close: (done) =>
    async.parallel [
      @server.close.bind @server
      @sslServer.close.bind @sslServer
    ], done


  # Returns an array of events from event history optionally filtered by the passed object
  getEvents: (filters={}) ->
    @eventHistory.filter (event) ->
      for own filterKey, filterValue of filters
        return no if event[filterKey] isnt filterValue
      yes


  listen: (port, done) ->
    async.parallel
      server: (taskDone) =>
        @server = http.createServer(@app).listen port, taskDone

      sslServer: (taskDone) =>
        @sslServer = https.createServer(sslKeys, @app).listen port + 1, taskDone
    , done


  respondWith: (@respondWithHtml) ->


  _handleLogEvent: (req, res) =>
    @eventHistory.push req.body
    res.end()


  _handleRequest: (req, res) =>
    @requestHistory.push "#{req.protocol}://#{req.headers.host}#{req.url}"
    res.write @respondWithHtml
    res.write eventLoggerHtml
    res.end()


module.exports = TestWebServer
