class window.AppView extends Backbone.View
  template: _.template '
    <button class="new-game">New Game</button> <button class="hit-button">Hit</button> <button class="stand-button">Stand</button> <button class="split-button">Split</button>
    <div class="player-hand-container"></div>
    <div class="dealer-hand-container"></div>
  '

  events:
    'click .hit-button': -> @model.get('playerHand').hit()
    'click .stand-button': -> @model.get('playerHand').stand()
    'click .new-game': -> @model.newGame()
    'click .split-button': -> @model.get('playerHand').split()

  initialize: ->
    @render()
    that = @
    @model.on 'anotherGame', ->
      that.render()

  render: ->
    @$el.children().detach()
    @$el.html @template()
    @$('.player-hand-container').html new HandView(collection: @model.get 'playerHand').el
    @$('.dealer-hand-container').html new HandView(collection: @model.get 'dealerHand').el