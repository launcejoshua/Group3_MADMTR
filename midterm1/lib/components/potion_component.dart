import 'dart:math';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:midterm1/components/mainchar_component.dart';
import 'package:midterm1/constants/global.dart';
import 'package:midterm1/games/dodge_game.dart';

class PotionComponent extends SpriteComponent with HasGameRef<DodgeGame>, CollisionCallbacks {

  final double _spriteHeight = 60;

  final Random _random = Random();

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    sprite = await gameRef.loadSprite(Globals.potionSprite);
    height = width = _spriteHeight;
    position = _getRandomPosition();
   

    add(CircleHitbox());
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other){
    super.onCollision(intersectionPoints, other);

    if(other is CharacterComponent){
      FlameAudio.play(Globals.potionDrink);

      removeFromParent();

      gameRef.score += 1;

     gameRef.add(PotionComponent());
    }
  }

  Vector2 _getRandomPosition(){
    double x = _random.nextInt(gameRef.size.x.toInt()).toDouble();
    double y = _random.nextInt(gameRef.size.y.toInt()).toDouble();

    return Vector2(x, y);
  }
}
