require 'test/unit'
require './blackjack'

class BlackjackTest < Test::Unit::TestCase

  def test_new_blackjack
    b = Blackjack.new
    assert_kind_of Array, b.players
  end

  def test_number_of_players_is_two
    b = Blackjack.new
    b.create_players
    assert_equal 2, b.players.count
  end

  def test_create_face_values
    deck = Blackjack::Deck.new
    face_values = deck.face_values
    assert_equal Hash["face" => "A", "value" => 11], face_values[0]
    assert_equal Hash["face" => "K", "value" => 10], face_values[1]
    assert_equal Hash["face" => "Q", "value" => 10], face_values[2]
    assert_equal Hash["face" => "J", "value" => 10], face_values[3]
  end

  def test_new_deck
    deck = Blackjack::Deck.new
    assert_kind_of Array, deck.cards
  end

  def test_empty_hand_size
    p = Blackjack::Player.new
    assert_equal 0, p.hand.count
  end

  def test_empty_hand_total
    p = Blackjack::Player.new
    assert_equal 0, p.total
  end

  def test_play_hand_size
    b = Blackjack.new
    b.play
#    b.players.each do |player|
#      player.hand.each do |card|
#        puts "card: " + card.suit.to_s + "|" + card.face.to_s + "|" + card.value.to_s
#      end
#      puts "total: " + player.total.to_s
#    end
  end

end
