class window.Hand extends Backbone.Collection
  model: Card

  initialize: (array, @deck, @isDealer) ->

  hit: ->
    @add(@deck.pop())
    @trigger 'hit', @

  hasAce: -> @reduce (memo, card) ->
    memo or card.get('value') is 1
  , 0

  minScore: -> @reduce (score, card) ->
    score + if card.get 'revealed' then card.get 'value' else 0
  , 0

  hasBlackjack: ->
    if @hasAce() and @minScore() == 11
      true
    else
      false

  scores: ->
    # The scores are an array of potential scores.
    # Usually, that array contains one element. That is the only score.
    # when there is an ace, it offers you two scores - the original score, and score + 10.
    [@minScore(), @minScore() + 10 * @hasAce()]

  hasBust: ->
    if @minScore() > 21
      true
    else
      false

  stand: ->
    @trigger 'stand', @

  hasSplit: ->
    false

  split: ->
    # Split will separate the hand into two new hands, each with one new card.
    if @models[0].attributes.rankName == @models[1].attributes.rankName
      console.log('splitting')