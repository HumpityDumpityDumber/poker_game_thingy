import 'package:poker_game/poker_game.dart' as poker_game;
import 'dart:math';
import 'dart:io';

void main() {
  // create hands
  List<poker_game.Hand> hands = [
    poker_game.Hand("Gary", [], poker_game.Color.pink),
    poker_game.Hand("Sarah", [], poker_game.Color.red),
    poker_game.Hand("Billy", [], poker_game.Color.blue),
    poker_game.Hand("Brenden", [], poker_game.Color.green)
  ];

  List<poker_game.Card> deck = poker_game.createDeck();

  print("deck contains: ${deck.join(" ")}\n");

  // deal cards into each hand
  for (var i = 0; i < 4; i++) {
    for (final h in hands) {
      poker_game.dealCardToHand(deck, h.cards);
    }
  }

  Map<int, int> handTotals = {};

  // calculate the hand totals
  for (final (i, h) in hands.indexed) {
    int total = 0;
    for (final c in h.cards) {
      total += c.rank;
    }
    handTotals[i] = total;
  }

  // find best hand
  int bestHandValue = handTotals.values.reduce(max);
  List<int> winningHands = handTotals.entries
      .where((entry) => entry.value == bestHandValue)
      .map((entry) => entry.key)
      .toList();

  poker_game.printHands(hands);

  print("\ndeck contains: ${deck.join(" ")}\n");
  
  // check if there was a tie
  if (winningHands.length > 1) {
    print(
      "game ended in tie of $bestHandValue\nwinners:\n${winningHands.map((i) => hands[i]).join("\n")}",
    );
  } else {
    print("${hands[winningHands[0]]}\x1b[0m and won with a total of $bestHandValue!");
  }

  // unhide the cursor
  stdout.write("\x1b[?25h");
}
