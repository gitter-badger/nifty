Command = require './command'


describe 'Command', ->

  describe 'run', ->

    context 'running working commands', ->

      beforeEach (done) ->
        @spy = sinon.spy (arg, callback) -> process.nextTick callback
        @context = {}
        @command = new Command 'my_extension', @spy
        @command.run @context, 'foo', (@err) => done()

      it 'runs code', ->
        expect(@spy).to.have.been.calledOnce

      it 'forwards arguments to the function', ->
        expect(@spy).to.have.been.calledWith 'foo'

      it 'runs the code with the proper context', ->
        expect(@spy).to.have.been.calledOn @context

      it 'does not create errors', ->
        expect(@err).to.not.exist


    context 'running an erroring command', ->

      beforeEach (done) ->
        @command = new Command 'my_extension', (callback) -> callback 'some error'
        @command.run {}, (@err) => done()

      it 'forwards the error', ->
        expect(@err).to.equal 'some error'


    context 'running a command that never calls callback', ->

      beforeEach (done) ->
        @command = new Command 'my_extension', timeout: 10, (callback) ->
        @command.run {}, (@err) => done()

      it 'calls done with an error indicating the timeout', ->
        expect(@err.message).to.equal 'my_extension took longer than the timeout (10ms)'


    context 'running a command that calls a callback too late', ->

      beforeEach (done) ->
        @command = new Command 'my_extension', timeout: 10, (callback) -> setTimeout callback, 20
        @command.run {}, @spy = sinon.spy (@err) => done()

      it 'calls done with an error indicating the timeout', ->
        expect(@err.message).to.equal 'my_extension took longer than the timeout (10ms)'

      it 'does not call the original callback twice', (done) ->
        # Wait to allow the setTimeout in beforeEach to fire.
        setTimeout =>
          expect(@spy).to.have.been.calledOnce
          done()
        , 30
