#Programmer friends, do you think you could implement a basic game of blackjack (no bets, no splits, ace is low, draw until you stay or bust) in 45 minutes?


def deck_of_cards
  deck = []
  [:hearts, :clubs, :diamonds, :spades].each do |suit|
    ( (1..10).to_a + [:jack, :queen, :king] ).each do |rank|
      deck.push([rank, suit])
    end
  end
  return deck
end

def score_for_card(card)
  rank, suit = card
  return 10 if [:jack, :queen, :king].include? rank
  return rank
end

p deck_of_cards.shuffle
p deck_of_cards.map{|c| score_for_card(c) }


