CommandsView = require './commands-view'
{CompositeDisposable} = require 'atom'


module.exports = Commands =
  commandsView: null
  rightPanel: null
  subscriptions: null

  config:
    list:
      title: 'List of commands'
      type: 'array'
      default: []
      items:
         type: 'object'
         properties:
            title:
               type: 'string'
            command:
               type: 'string'


  activate: (state) ->
    @commandsView = new CommandsView(state.commandsViewState)
    @rightPanel = atom.workspace.addRightPanel(item: @commandsView.getElement(), visible: false)

    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'commands:toggle': => @toggle()

  deactivate: ->
    @rightPanel.destroy()
    @subscriptions.dispose()
    @commandsView.destroy()

  serialize: ->
    commandsViewState: @commandsView.serialize()

  toggle: ->
    console.log 'Commands was toggled!'

    if @rightPanel.isVisible()
      @rightPanel.hide()
    else
      @rightPanel.show()
