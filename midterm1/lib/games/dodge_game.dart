import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:midterm1/components/bg_component.dart';
import 'package:midterm1/components/enemy_component.dart';
import 'package:midterm1/components/mainchar_component.dart';
import 'package:midterm1/components/potion_component.dart';
import 'package:midterm1/constants/global.dart';
import 'package:midterm1/input/joystick.dart';
import 'package:midterm1/scrrens/gameover.dart';


class DodgeGame extends FlameGame with HasCollisionDetection {
  int score = 0;
  late Timer timer;
  int remainingTime = 30;

  late TextComponent scoreText;
  late TextComponent timeText;

  final List<String> enemySprites = [
    Globals.aswangSprite,
    Globals.balbalSprite,
    Globals.tiyanakSprite,
    Globals.kapreSprite,
    Globals.tikbalangSprite,
    Globals.whiteLadySprite
  ];

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    add(BackgroundComponent());
    add(CharacterComponent(joystick: joystick));
    add(PotionComponent());
    add(joystick);

    FlameAudio.audioCache.loadAll([Globals.potionDrink, Globals.attackSound]);

    final Random random = Random();
    for (int i = 0; i < 2; i++) {
      final double x = random.nextDouble() * (size.x - 200) + 100;
      final double y = random.nextDouble() * (size.y - 200) + 100;
      final String sprite = enemySprites[random.nextInt(enemySprites.length)];
      add(EnemyComponent(startPosition: Vector2(x, y), sprite: sprite));
    }

    add(ScreenHitbox());

    scoreText = TextComponent(
      text: 'Score: ${score}',
      position: Vector2(40, 40),
      anchor: Anchor.topLeft,
    );
    add(scoreText);

    timeText = TextComponent(
      text: 'Time: $remainingTime seconds',
      position: Vector2(size.x / 2, 40),
      anchor: Anchor.topLeft,
    );
    add(timeText);

    timer = Timer(1, repeat: true, onTick: () {
      if (remainingTime == 0) {
        pauseEngine();
        overlays.add(GameOverMenu.ID);
      } else {
        remainingTime -= 1;
      }
    });

    timer.start();
  }

  @override
  void update(double dt) {
    super.update(dt);
    timer.update(dt);
    scoreText.text = 'Score: $score';
    timeText.text = 'Time: $remainingTime secs';
  }

  void reset() {
    score = 0;
    remainingTime = 30;
  }
}
