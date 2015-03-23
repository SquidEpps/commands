exec = require 'child_process'
   .exec

module.exports =
class CommandsView
   constructor: (serializeState) ->
      # Create root element
      @element = document.createElement 'div'
      @element.classList.add 'commands'

      atom.config.get 'commands.list'
         .forEach (command) =>
            @addButton command

   addButton: (command) ->
      block = document.createElement 'div'
      block.classList.add 'block'

      button = document.createElement 'button'
      button.classList.add 'btn'
      button.textContent = command.title
      atom.tooltips.add button, title: command.command
      button.onclick = ->
         exec command.command, (error, stdout, stderr) ->
            console.log 'stdout: ' + stdout
            console.log 'stderr: ' + stderr
            if error != null
               console.log 'exec error: ' + error

      block.appendChild button
      @element.appendChild block

   # Returns an object that can be retrieved when package is activated
   serialize: ->

   # Tear down any state and detach
   destroy: ->
      @element.remove()

   getElement: ->
      @element
