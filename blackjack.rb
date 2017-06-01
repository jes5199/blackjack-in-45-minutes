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

first_round = true

print_dealer_cards = lambda do
  print "dealer's cards: "
  p dealer_hand
  print "score: "
  p score_for_hand(dealer_hand)
end

print_player_cards = lambda do
  print "your cards: "
  p player_hand
  print "score: "
  p score_for_hand(player_hand)
end

print_cards = lambda do
  print_dealer_cards.call
  print_player_cards.call
end

loop do
  print_cards.call

  player_score = score_for_hand(player_hand)

  if player_score > 21
    puts "BUST!"
    break
  end

  if player_score == 21
    if first_round
      puts "Blackjack! You win this round!"
      break
    end
    puts "Twenty-one!"
    break
  end

  first_round = false

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


while score_for_hand(player_hand) <= 21 && score_for_hand(dealer_hand) < 17
  puts "The dealer draws."
  dealer_hand.push deck.pop
  print "dealer's cards: "
  p dealer_hand
  print "score: "
  dealer_score = score_for_hand(dealer_hand)
  p dealer_score
  if dealer_score > 21
    puts "BUST!"
    break
  end
  puts
end

print_cards.call

dealer_score = score_for_hand(dealer_hand)
player_score = score_for_hand(player_hand)
if score_for_hand(player_hand) > 21
  puts "You busted. Better luck next time!"
elsif score_for_hand(dealer_hand) > 21
  puts "Dealer busted! You win this round."
elsif score_for_hand(dealer_hand) > score_for_hand(player_hand)
  puts "Dealer beat you."
elsif score_for_hand(dealer_hand) == score_for_hand(player_hand)
  puts "Tied score."
else
  puts "You win this round!"
end
