fs = require 'fs'
path = require 'path'


class CommandLoader

  # Directories to look for commands in
  @searchDirectories: [
    path.join __dirname, 'commands'
  ]


  constructor: ->
    @commands = {}


  getCommands: ->
    @loadDirectory directory for directory in CommandLoader.searchDirectories
    @commands


  loadCommand: (filePath) ->
    command = require filePath
    @commands[command.name] = command


  loadDirectory: (directoryPath) ->
    for file in fs.readdirSync directoryPath
      continue unless @_isValidCommandFile file
      @loadCommand path.join(directoryPath, file)


  _isValidCommandFile: (fileName) ->
    # Don't require hidden files
    return no if fileName[0] is '.'

    # Don't require non-js or non-coffee files
    return no unless path.extname(fileName) in ['.js', '.coffee']

    yes


module.exports = CommandLoader
