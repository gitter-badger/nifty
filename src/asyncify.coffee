class Asyncify

  constructor: ->
    for own methodName, method of @asyncify
      @[methodName] = @_curryAsync method.bind this


  _curryAsync: (fn) -> (args..., maybeDone) =>
    if typeof maybeDone is 'function'
      @_nodeify maybeDone, fn args...
    else
      (done) =>
        @_nodeify done, fn args..., maybeDone


  _nodeify: (callback, promise) ->
    return callback() unless promise?
    return callback promise if promise instanceof Error

    promise.then (data) ->
      # Run the callback in a separate tick otherwise if the callback throws
      # thenCatch gets called resulting in callback being called twice
      process.nextTick -> callback null, data
    promise.thenCatch (err) -> callback err


module.exports = Asyncify
