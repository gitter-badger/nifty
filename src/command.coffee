_ = require 'lodash'
roca = require 'robust-callbacks'


class Command

  DEFAULT_OPTIONS =
    async: yes
    catchErrors: no
    timeout: 5000


  constructor: (@name, options, ..., @fn) ->
    options = {} if options is @fn
    @options = _.defaults options, DEFAULT_OPTIONS


  run: (context, args..., done) =>
    # Ensure done is called async to allow the queue to finish populating
    process.nextTick =>
      return done() if context.error? and @options.catchErrors is no

      if @options.async
        @_runAsync context, args, done
      else
        @_runSync context, args
        done()


  _runAsync: (context, args, done) ->
    roca.setTimeout @options.timeout
    @fn.call context, args..., roca (err) =>
      if _.contains err?.message, 'exceeded timeout'
        return done Error "#{@name} took longer than the timeout (#{@options.timeout}ms)"
      done err


  _runSync: (context, args) ->
    @fn.apply context, args


module.exports = Command
