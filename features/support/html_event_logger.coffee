eventLoggerFn = ->
  httpRequest = new XMLHttpRequest

  document.addEventListener 'click', (event) ->
    httpRequest.open 'POST', '/log-event'
    httpRequest.setRequestHeader 'Content-Type', 'application/json'
    httpRequest.send JSON.stringify
      event: event.type
      tag: event.target.tagName.toLowerCase()


module.exports = "<script>(#{eventLoggerFn})()</script>"
