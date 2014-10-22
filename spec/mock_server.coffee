_ = require 'lodash'
http = require 'http'
portfinder = require 'portfinder'


class MockServer

  constructor: ->
    @requests = []
    @response = ''
    @server = http.createServer @handleServerRequest


  handleServerRequest: (req, res) =>
    @requests.push req
    res.end @response


  respondWith: (@response) ->


  requestsTo: (url) ->
    _.filter @requests, (request) -> request.url is url


  start: (done) ->
    portfinder.getPort (err, @port) =>
      return done err if err
      @server.listen @port, done


module.exports = MockServer
