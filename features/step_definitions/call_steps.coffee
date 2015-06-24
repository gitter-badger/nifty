module.exports = ->

  @Then /^the parameter "done" is called with no arguments$/, (done) ->
    expect(@spies.done).to.have.been.calledOnce
    expect(@spies.done.firstCall.args).to.eql []
    done()


  @Then /^(?:the parameter )?"([^"]+)" is called with the arguments `([^`]+)`$/, (spyName, args, done) ->
    expect(@spies[spyName]).to.have.been.calledOnce
    if args?
      parsedArgs = args.split(',').map JSON.parse
      expect(@spies[spyName]).to.have.been.calledWithExactly parsedArgs...
    done()


  @Then /^"([^"]+)" is never called$/, (spyName, done) ->
    expect(@spies[spyName]).to.not.have.been.called
    done()


  @Then /^(?:the parameter )?"done" is called with the error "([^"]+)"$/, (error, done) ->
    expect(@spies.done).to.have.been.calledOnce
    expect(@spies.done.firstCall.args[0]).to.be.an.instanceof Error
    expect(@spies.done.firstCall.args[0].toString()).to.contain error
    done()
