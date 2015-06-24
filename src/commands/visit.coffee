Command = require '../command'
_ = require 'lodash'
nodeify = require 'nodeify'
url = require 'url'


module.exports = new Command 'visit', (pathname, done) ->
  try
    promise = @driver.get url.format _.defaults(
      {pathname}        # pathname takes precedence
      @host             # Fill in all other fields from @host
    )
    nodeify promise, done
  catch err
    done Error "Cannot visit #{JSON.stringify pathname}:\n#{err.message}"
