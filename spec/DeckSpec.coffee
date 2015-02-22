assert = chai.assert

describe 'deck', ->
  deck = null
  hand = null

  beforeEach ->
    deck = new Deck()
    hand = deck.dealPlayer()

  describe 'hit', ->
    xit 'should give the last card from the deck', ->
      assert.strictEqual deck.length, 50
      assert.strictEqual deck.last(), hand.hit()
      assert.strictEqual deck.length, 49

  describe 'hit 2', ->
    it 'should also add a card to the player\'s hand', ->
        hand.hit()
        assert.strictEqual hand.models.length, 3

  describe 'bust', ->
    it 'should notice when a player is bust', ->
      hand.hit()
      hand.hit()
      hand.hit()
      hand.hit()
      hand.hit()
      assert.strictEqual hand.hasBust(), true