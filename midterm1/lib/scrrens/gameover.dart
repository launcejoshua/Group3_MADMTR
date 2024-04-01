import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:midterm1/games/dodge_game.dart';

class GameOverMenu extends StatelessWidget {
  static const String ID = 'GameOverMenu';
  final DodgeGame gameRef;

  const GameOverMenu({Key? key, required this.gameRef}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.7), // Black background with 70% opacity
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Game Over',
                style: Theme.of(context).textTheme.displayLarge!.copyWith(
                  color: Colors.red
                )
              ),
              SizedBox(height: 20),
              Text(
                'Your Score: ${gameRef.score}',
                style: Theme.of(context).textTheme.displaySmall!.copyWith(
                  color: Colors.white70
                )
              ),
              SizedBox(height: 40),
              ElevatedButton(
                onPressed: () {
                  gameRef.overlays.remove(GameOverMenu.ID);
                  gameRef.reset();
                  gameRef.resumeEngine();
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.blue,
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  'Play Again?',
                  style: Theme.of(context).textTheme.displaySmall!.copyWith(
                  color: Colors.white70
                )
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
