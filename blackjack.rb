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

def score_for_hand(hand)
  hand.inject(0){|sc, card| sc + score_for_card(card)}
end

deck = deck_of_cards.shuffle
player_hand = []
dealer_hand = []

2.times do
  player_hand.push deck.pop
  dealer_hand.push deck.pop
end

loop do
  print "dealer's cards: "
  p dealer_hand
  print "score: "
  p score_for_hand(dealer_hand)

  print "your cards: "
  p player_hand
  print "score: "
  player_score = score_for_hand(player_hand)
  p player_score

  if player_score > 21
    puts "BUST!"
    break
  end

  puts
  puts "[h]it or [s]tay?"
  action = STDIN.gets

  if action.match /\Ah/i
    player_hand.push deck.pop
  elsif action.match /\As/i
    break
  else
    puts "I didn't understand you. Try again?"
  end
end
