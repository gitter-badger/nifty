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
    promise.then (data) -> callback null, data
           .thenCatch (err) -> callback err


module.exports = Asyncify
