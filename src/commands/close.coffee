Command = require '../command'
nodeify = require 'nodeify'


module.exports = new Command 'close', (done) ->
  nodeify @driver.quit(), done
