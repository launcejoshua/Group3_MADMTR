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
  int remainingTime = 60;
  int lives = 3;

  late TextComponent scoreText;
  late TextComponent timeText;
  late TextComponent livesText;

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
    FlameAudio.bgm.play(Globals.playingbg);

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
      position: Vector2(40, 80),
      anchor: Anchor.topLeft,
    );
    add(scoreText);

    timeText = TextComponent(
      text: 'Time: $remainingTime seconds',
      position: Vector2(40, 40),
      anchor: Anchor.topLeft,
    );
    add(timeText);

    livesText = TextComponent(
      text: 'Lives: $lives',
      position: Vector2(size.x * 0.90, 40),
      anchor: Anchor.topRight,
    );
    add(livesText);

    // timer = Timer(1, repeat: true, onTick: () {
    //   if (remainingTime == 0) {
    //     pauseEngine();
    //     overlays.add(GameOverMenu.ID);
    //   } else {
    //     remainingTime -= 1;
    //   }
    // });
    timer = Timer(1, repeat: true, onTick: () {
      if (remainingTime == 0 || lives == 0) {
        
        pauseEngine();
        overlays.add(GameOverMenu.ID);
      } else {
        remainingTime -= 1;
      }
    });

    timer.start();
  }

  // @override
  // void update(double dt) {
  //   super.update(dt);
  //   timer.update(dt);
  //   scoreText.text = 'Score: $score';
  //   timeText.text = 'Time: $remainingTime secs';
  // }

  //   @override
  // void onCollision(Set<Vector2> intersectionPoints, Collidable other) {
  //   super.onCollision(intersectionPoints, other);

  //   if (other is EnemyComponent) {
  //     lives--;

  //     if (lives == 0) {
  //       pauseEngine();
  //       overlays.add(GameOverMenu.ID);
  //     }
  //   }
  // }

  @override
  void update(double dt) {
    super.update(dt);
    timer.update(dt);
    scoreText.text = 'Score: $score';
    timeText.text = 'Time: $remainingTime secs';
    livesText.text = 'Lives: $lives';

    if(remainingTime == 0 || lives == 0){
      gameOver();
    }
  }

  void reset() {
    score = 0;
    remainingTime = 60;
    lives = 3;
  }

  void onDetached(){
    super.onDetach();
  }

  void gameOver(){
    pauseEngine();
        FlameAudio.bgm.stop();
        FlameAudio.play(Globals.gameOver);
        pauseEngine();
        overlays.add(GameOverMenu.ID);
  }
}
