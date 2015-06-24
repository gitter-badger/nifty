CommandLoader = require './command_loader'


class CommandQueue

  constructor: (@context) ->
    @commandQueue = []
    @commandQueueRunning = no
    @wrappedCommands = {}

    @commands = new CommandLoader().getCommands()
    @wrapCommand commandName for own commandName of @commands

    return @wrappedCommands


  # Starts the command queue if it isn't already running
  kickoffCommandQueue: ->
    return if @commandQueueRunning
    if @commandQueue.length is 0
      throw @context.error if @context.error
      return
    @commandQueueRunning = yes
    {commandName, args} = @commandQueue.shift()
    @commands[commandName].run @context, args..., (err) =>
      @context.error = err if err
      @commandQueueRunning = no
      @kickoffCommandQueue()


  # Creates a public-facing chainable function and saves it to @wrappedCommands
  wrapCommand: (commandName) ->
    @wrappedCommands[commandName] = (args...) =>
      @commandQueue.push {commandName, args}
      @kickoffCommandQueue()
      # Return wrappedCommands to allow chaining
      @wrappedCommands


module.exports = CommandQueue
