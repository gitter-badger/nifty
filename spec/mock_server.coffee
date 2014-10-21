_ = require 'lodash'
http = require 'http'
portfinder = require 'portfinder'


class MockServer

  constructor: ->
    @requests = []
    @server = http.createServer @handleServerRequest


  handleServerRequest: (req, res) =>
    @requests.push req
    res.end '<a href="/click-me" class="click-me">click me</a>'


  requestsTo: (url) ->
    _.filter @requests, (request) -> request.url is url


  start: (done) ->
    portfinder.getPort (err, @port) =>
      return done err if err
      @server.listen @port, done


module.exports = MockServer
