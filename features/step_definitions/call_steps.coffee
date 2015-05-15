{validate} = require 'jsonschema'
orderly = require 'orderly'


module.exports = ->

  @Then /^the parameter "done" is called with (?:no arguments|the arguments `([^`]+)`)?$/, (args, done) ->
    expect(@done).to.have.been.calledOnce
    if args?
      parsedArgs = args.split(',').map JSON.parse
      expect(@done).to.have.been.calledWithExactly parsedArgs...
    done()


  @Then /^the parameter "done" is called with the (1|2)(?:st|nd) parameter matching the orderly schema$/, (parameterNum, orderlySchema, done) ->
    parameter = JSON.stringify @done.firstCall.args[parameterNum - 1], null, 2
    jsonSchema = orderly.parse orderlySchema
    validation = validate JSON.parse(parameter), jsonSchema
    expect(
      validation.errors
      """
        Expected
        #{parameter}
        to match the orderly schema:
        #{orderlySchema}
        Errors:
          #{validation.errors.join '\n  '}

      """
    ).to.be.empty
    done()


  @Then /^the parameter "done" is called with the error "([^"]+)"$/, (error, done) ->
    expect(@done).to.have.been.calledOnce
    expect(@done.firstCall.args[0]).to.be.an.instanceof Error
    expect(@done.firstCall.args[0].toString()).to.contain error
    done()
