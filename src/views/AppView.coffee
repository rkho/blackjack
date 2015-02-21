class window.AppView extends Backbone.View
  template: _.template '
    <button class="new-game" value="REFRESH">New Game</button> <button class="hit-button">Hit</button> <button class="stand-button">Stand</button> <button class="split">Split</button> <button class="double">Double</button>
    <div class="player-hand-container"></div>
    <div class="dealer-hand-container"></div>
  '

  events:
    'click .hit-button': -> @model.get('playerHand').hit()
    'click .stand-button': -> @model.get('playerHand').stand()
    'click .new-game': -> @model.newGame()
    'click .split': -> @model.split()
    'click .double': -> @model.double()

  initialize: ->
    @render()

  render: ->
    @$el.children().detach()
    @$el.html @template()
    @$('.player-hand-container').html new HandView(collection: @model.get 'playerHand').el
    @$('.dealer-hand-container').html new HandView(collection: @model.get 'dealerHand').el