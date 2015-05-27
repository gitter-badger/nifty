eventLoggerFn = ->
  httpRequest = new XMLHttpRequest


  getEventObject = (event) ->
    eventObject =
        event: event.type
        tag: event.target?.tagName?.toLowerCase()
        functionName: event.detail.functionName
    if event.type is 'keydown'
      eventObject.shortcut = "#{if event.ctrlKey then 'ctrl'}+#{String.fromCharCode event.keyCode}".toLowerCase()
    eventObject


  ['click', 'keydown', 'functionCall'].forEach (eventType) ->
    document.addEventListener eventType, (event) ->
      httpRequest.open 'POST', '/log-event'
      httpRequest.setRequestHeader 'Content-Type', 'application/json'
      httpRequest.send JSON.stringify getEventObject event


  # Client-side spy functions:
  ['myFn'].forEach (functionName) ->
    window[functionName] = ->
      event = new CustomEvent 'functionCall', detail: {functionName}
      document.dispatchEvent event


module.exports = "<script>(#{eventLoggerFn})()</script>"
