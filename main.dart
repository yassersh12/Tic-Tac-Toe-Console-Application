import 'dart:io';
import 'game.dart';

void main() {
  print("Welcome");
  bool playAgain = true;
  Game game = Game();//this will init the game object once, and plyers info
  while (playAgain) {
    game.initialize(); // for bord initlizeation
    game.start(); // starts game logic
    print("Do you want to play again? (y/n): "); 
    String? response = stdin.readLineSync();
    playAgain = response != null && response.toLowerCase() == 'y';
  }

  print("Thanks for playing");
}
