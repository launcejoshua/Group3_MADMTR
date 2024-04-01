import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:midterm1/games/dodge_game.dart';
import 'package:midterm1/scrrens/gameover.dart';

final DodgeGame _game = DodgeGame();

class GamePlay extends StatelessWidget {
  const GamePlay({super.key});

  @override
  Widget build(BuildContext context) {
    return GameWidget(
      game: _game,
      overlayBuilderMap: {
        GameOverMenu.ID: (BuildContext, DodgeGame gameRef) {
          return GameOverMenu(gameRef: gameRef);
        }
      },
    );
  }
}
