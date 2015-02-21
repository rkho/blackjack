# TODO: Refactor this model to use an internal Game Model instead
# of containing the game logic directly.
class window.App extends Backbone.Model
  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()
    # Listener for a 'hit' or 'stand'
      # If either event occurs, trigger the Dealer's logic
    if @get('playerHand').hasBlackjack()
      @gameOver('You won with a Blackjack!', 'success')
    if @get('dealerHand').hasBlackjack()
      @gameOver('The Dealer has Blackjack!', 'error')
      @.get('dealerHand').models[0].flip()
    @get('playerHand').on 'hit', =>
      playerScore = @get('playerHand').minScore()
      if playerScore > 21
        @gameOver('You Busted!', 'error')
    @get('playerHand').on 'stand', =>
      @dealerLogic()

  gameOver: (str, result) ->
    swal("Game Over!", str, result)

  biggestScore: (obj) ->
    scoresArr = obj.scores()
    if scoresArr[1] <= 21
      return scoresArr[1]
    else
      return scoresArr[0]

  dealerLogic: ->
    @get('dealerHand').models[0].flip();
    @get('dealerHand').hit() while @get('dealerHand').minScore() < 17
    dealerScore = @biggestScore(@get('dealerHand'))
    playerScore = @biggestScore(@get('playerHand'))
    @gameOver("It's a tie!") if dealerScore == playerScore
    if dealerScore > 21 || playerScore > dealerScore
     @gameOver('You beat the Dealer!', 'success')
    else if dealerScore > playerScore
     @gameOver('The Dealer beat you!', 'error')

  newGame: ->
    console.log('new game')
