Nifty = require '../..'
nodeify = require 'nodeify'


module.exports = new Nifty.Command 'close', (done) ->
  nodeify @driver.quit(), done
