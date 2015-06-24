Command = require '../command'


module.exports = new Command 'call', async: no, (callback) ->
  callback.call this
