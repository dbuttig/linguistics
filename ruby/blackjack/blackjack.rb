class Blackjack

  def initialize
    @players = []
  end

  def play
    @deck = Deck.new
    create_players
    @deck.cards = @deck.shuffle
    @deck.deal(@players)
    @players[0] = player_round(@players[0])
    if @players[0].total > 21
      puts "Player busts"
    else
      @players[1] = dealer_round(@players[1])
      if @players[1].total > 21
        puts "Dealer busts"
      else
        determine_winner
      end
    end
  end

  def create_players
    2.times do
      player = Player.new
      @players.push(player)
    end
  end

  def players
    @players
  end

  def determine_winner
    player_total = @players[0].total
    dealer_total = @players[1].total
    if player_total > dealer_total
      puts "Player Wins"
    elsif dealer_total > player_total
      puts "Dealer Wins"
    else
      puts "Push"
    end
  end

  def player_round(player)
    action = ""
    while action.upcase != "S" and player.total <= 21 do
      puts "Your hand:"
      player.hand.each do |card|
        puts card.face.to_s + " of " + card.suit.to_s + "; " + card.value.to_s
      end
      valid_response = 0
      display_options
      while valid_response == 0 do
        action = gets.chomp.to_s
        if action.upcase == "D"
          @deck.draw(player)
          valid_response = 1
        elsif action.upcase == "S"
          valid_response = 1
        else
          puts "Action not recognized."
          display_options
        end
      end
      @aces = find_aces(player)
      optimize_values(player)
    end
    player
  end

  def display_options
    puts "Would you like to (D)raw or (S)tand?"
  end

  def dealer_round(dealer)
    while dealer.total < 17 do
      @deck.draw(dealer)
      @aces = find_aces(dealer)
      optimize_values(dealer)
    end
    puts "Dealer hand:"
    dealer.hand.each do |card|
      puts card.face.to_s + " of " + card.suit.to_s + "; " + card.value.to_s
    end
    dealer
  end

  def find_aces(dealer)
    aces = []
    index = 0
    dealer.hand.each do |card|
      if card.face == "A"
        aces.push(index)
      end
      index = index + 1
    end
    aces
  end

  def optimize_values(dealer)
    @aces.each do |index|
      puts "found an ace"
      if dealer.total > 21
        #dealer.cards[index].value = 1
        dealer.hand[index] = dealer.hand[index].minimize_ace
        #dealer.total = dealer.total - 10
      end
    end
  end

  class Player

    def initialize
      @hand = []
    end

    def hand
      @hand
    end

    def total
      sum = 0
      @hand.each do |card|
        sum = sum + card.value
      end
      sum
    end

  end

  class Deck

    def initialize
      suits = ["H", "C", "D", "S"]
      @cards = []
      suits.each do |suit|
        (2..10).each do |value|
          card = Card.new
          card.suit = suit
          card.value = value
          card.face = value
          cards.push(card)
        end
        face_values.each do |face_value|
          card = Card.new
          card.suit = suit
          card.face = face_value["face"]
          card.value = face_value["value"]
          cards.push(card)
        end
      end
    end

    def face_values
      ace = Hash["face" => "A", "value" => 11]
      king = Hash["face" => "K", "value" => 10]
      queen = Hash["face" => "Q", "value" => 10]
      jack = Hash["face" => "J", "value" => 10]
      return [ace, king, queen, jack]
    end

    def cards
      @cards
    end

    def cards=(cards)
      @cards = cards
    end

    def shuffle
      self.cards.shuffle
    end

    def deal(players)
      players.each do |player|
        2.times do
          player.hand << self.cards.shift
        end
      end
    end

    def draw(player)
      player.hand << self.cards.shift
    end

  end

  class Card
    attr_accessor :suit
    attr_accessor :face
    attr_accessor :value

    def initialize

    end

    def minimize_ace
      self.value = 1
      self
    end

    def to_s

    end
  end
end
