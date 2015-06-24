Command = require './command'
CommandQueue = require './command_queue'


describe 'CommandQueue', ->

  beforeEach ->
    commands =
      foo: new Command 'foo', @fooSpy = sinon.spy (done) -> setTimeout done
      bar: new Command 'bar', @barSpy = sinon.spy (done) -> setTimeout done
      baz: new Command 'baz', @bazSpy = sinon.spy (done) -> setTimeout done
      call: new Command 'call', async: no, (fn) -> fn()

    @context = {}
    @commandQueue = new CommandQueue {commands, @context}


  describe 'chaining commands', ->
    beforeEach (done) ->
      @commandQueue.foo()
                   .bar()
                   .baz()
                   .call done

    it 'calls all methods', ->
      expect(@fooSpy).to.have.been.calledOnce
      expect(@barSpy).to.have.been.calledOnce
      expect(@bazSpy).to.have.been.calledOnce

    it 'calls the methods in the proper order', ->
      expect(@fooSpy).to.have.been.calledBefore @barSpy
      expect(@barSpy).to.have.been.calledBefore @bazSpy

    it 'calls the methods with passed context', ->
      expect(@fooSpy).to.have.been.calledOn @context
      expect(@barSpy).to.have.been.calledOn @context
      expect(@bazSpy).to.have.been.calledOn @context
