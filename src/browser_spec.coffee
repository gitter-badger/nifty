MockServer = require '../spec/mock_server.coffee'
Browser = require './browser'

describe 'Browser', ->

  beforeEach (done) ->
    @browser = new Browser
    @mockServer = new MockServer
    @mockServer.start =>
      @url = "http://localhost:#{@mockServer.port}"
      done()

  afterEach (done) ->
    @browser.close done


  describe '$', ->

    beforeEach (done) ->
      @browser.visit @url, done

    describe 'click', ->

      it 'clicks on elements', (done) ->
        @browser.$('.click-me').click (err) =>
          expect(@mockServer.requestsTo('/click-me').length).to.equal 1
          done()

      it 'returns errors', (done) ->
        @browser.$('.nonexistent-element').click (err) =>
          expect(err).to.exist
          done()


  describe 'visit', ->

    describe 'standard api', ->

      it 'visits a webpage', (done) ->
        @browser.visit @url, (err) =>
          expect(@mockServer.requestsTo('/').length).to.equal 1
          done(err)

      it 'returns errors', (done) ->
        @browser.visit 'invalid-url', (err) =>
          expect(err).to.exist
          done()

    describe 'curried api', ->

      it 'visits a webpage', (done) ->
        @browser.visit(@url) (err) =>
          expect(@mockServer.requestsTo('/').length).to.equal 1
          done(err)

      it 'returns errors', (done) ->
        @browser.visit('invalid-url') (err) =>
          expect(err).to.exist
          done()
