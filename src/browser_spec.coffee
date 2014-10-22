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

    describe 'click', ->

      beforeEach (done) ->
        @mockServer.respondWith '<a href="/click-me" class="click-me">click me</a>'
        @browser.visit @url, done

      it 'clicks on elements', (done) ->
        @browser.$('.click-me').click (err) =>
          expect(@mockServer.requestsTo('/click-me').length).to.equal 1
          done()

      it 'returns errors', (done) ->
        @browser.$('.nonexistent-element').click (err) =>
          expect(err).to.exist
          done()


    describe 'text', ->

      beforeEach (done) ->
        @mockServer.respondWith '<div id="element">this <span>is</span> <strong>the</strong> text</div>'
        @browser.visit @url, done

      it 'returns the text of the element', (done) ->
        @browser.$('#element').text (err, text) =>
          expect(text).to.equal 'this is the text'
          done(err)


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
