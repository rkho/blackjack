# TODO: Refactor this model to use an internal Game Model instead
# of containing the game logic directly.
class window.App extends Backbone.Model
  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()
    # Listener for a 'hit' or 'stand'
      # If either event occurs, trigger the Dealer's logic
    @get('playerHand').on 'hit', =>
      playerScore = @get('playerHand').minScore()
      if playerScore > 21
        @gameOver('You Busted!')
    @get('playerHand').on 'stand', =>
      @dealerLogic()

  gameOver: (str) ->
    alert('Game Over! ' + str)

  dealerLogic: ->
    @get('dealerHand').models[0].flip();
    @get('dealerHand').hit() while @get('dealerHand').minScore() < 17
    dealerScore = @get('dealerHand').minScore()
    playerScore = @get('playerHand').minScore()
    @gameOver("It's a tie!") if dealerScore == playerScore
    if dealerScore > 21 || playerScore > dealerScore
     @gameOver('You beat the Dealer!')
    else if dealerScore > playerScore
     @gameOver('The Dealer beat you!')