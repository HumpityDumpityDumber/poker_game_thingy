import 'dart:math';
import 'dart:io';

List<Suit> suits = [
  Suit("heart", "♥", Color.red),
  Suit("diamond", "♦", Color.red),
  Suit("spade", "♠", Color.black),
  Suit("club", "♣", Color.black),
];

class Suit {
  String name;
  String symbol;
  Color color;

  Suit(this.name, this.symbol, this.color);

  @override
  String toString() => symbol;
}

class Card {
  Suit suit;
  int rank;

  Card(this.suit, this.rank);

  @override
  String toString() => "${colors[suit.color]}\x1b[47m$rank$suit\x1b[0m";
}

class Hand {
  String name;
  List<Card> cards;
  Color color;

  Hand(this.name, this.cards, this.color);

  @override
  String toString() => "${colors[color]}$name\x1b[0m with ${cards.join(" ")}";
}

List<Card> createDeck() {
  List<Card> deck = [];
  for (final suit in suits) {
    for (int rank = 1; rank <= 13; rank++) {
      deck.add(Card(suit, rank));
    }
  }
  return deck;
}

void dealCardToHand(List<Card> deck, List<Card> hand) {
  if (deck.isNotEmpty) {
    var random = Random.secure();
    hand.add(deck.removeAt(random.nextInt(deck.length - 1)));
  }
}

// prints out the hands in a fancy way
void printHands(List<Hand> hands) {
  stdout.write(hands.map((h) => "${colors[h.color]}${h.name}\x1b[0m").join("\n"));
  stdout.write("\x1b[?25l\x1b[s\x1b[3A");
  for (final h in hands) {
    sleep(Duration(seconds: 1));
    stdout.write("\x1b[E\x1b[${h.name.length + 1}G");
    for (final c in h.cards) {
      sleep(Duration(milliseconds: 300));
      stdout.write(" $c");
    }
  }
}

// defines all the ansi colors
const Map<Color, String> colors = {
  Color.red: "\x1b[31m",
  Color.blue: "\x1b[34m",
  Color.green: "\x1b[32m",
  Color.pink: "\x1b[35m",
  Color.black: "\x1b[30m"
};

enum Color { red, blue, green, pink, black }