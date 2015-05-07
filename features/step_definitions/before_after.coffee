async = require 'async'
chai = require 'chai'
TestWebServer = require '../support/test_web_server'

chai.use require 'sinon-chai'
global.sinon = require 'sinon'
global.expect = chai.expect


module.exports = ->

  @Before (done) ->
    @testWebServer = new TestWebServer
    @cleanupTasks = []
    @cleanupTasks.push @testWebServer.close
    @testWebServer.listen 5000, done


  @After (done) ->
    async.parallel @cleanupTasks, done
