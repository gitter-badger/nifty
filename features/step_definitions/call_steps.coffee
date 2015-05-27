module.exports = ->


  @Then /^the parameter "done" is called with (?:no arguments|the arguments `([^`]+)`)?$/, (args, done) ->
    expect(@done).to.have.been.calledOnce
    if args?
      parsedArgs = args.split(',').map JSON.parse
      expect(@done).to.have.been.calledWithExactly parsedArgs...
    done()


  @Then /^the parameter "done" is called with the error "([^"]+)"$/, (error, done) ->
    expect(@done).to.have.been.calledOnce
    expect(@done.firstCall.args[0]).to.be.an.instanceof Error
    expect(@done.firstCall.args[0].toString()).to.contain error
    done()


  @Then /^the "([^"]+)" javascript function is called in my browser$/, (functionName, done) ->
    expect(@testWebServer.getEvents event: 'functionCall', functionName: functionName).to.have.length 1
    done()
