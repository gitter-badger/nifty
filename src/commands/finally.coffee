Command = require '../command'


module.exports = new Command 'finally', async: no, catchErrors: yes, (callback) ->
  callback.call this, @error

  # Unset the error so we don't throw when finishing the job queue
  @error = null
