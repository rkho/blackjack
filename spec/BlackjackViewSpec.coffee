assert = chai.assert

describe 'deck', ->
  deck = null
  hand = null

  beforeEach ->
    deck = new Deck()
    hand = deck.dealPlayer()

    describe 'hit', ->
      it 'should also add a card to the player\'s hand', ->
        assert.strictEqual hand.models.length, 3