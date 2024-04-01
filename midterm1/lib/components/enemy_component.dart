import 'dart:math';
import 'dart:ui';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:midterm1/constants/global.dart';
import 'package:midterm1/games/dodge_game.dart';

class EnemyComponent extends SpriteComponent with HasGameRef<DodgeGame>, CollisionCallbacks {

  late double _rightBound;
  late double _leftBound;
  late double _upBound;
  late double _downBound;

  double _spriteHeight = 100;

  // Define the three different sprites
  final String aswangSprite = Globals.aswangSprite;
  final String balbalSprite = Globals.balbalSprite;
  final String tiyanakSprite = Globals.tiyanakSprite;
  final String kapreSprite = Globals.kapreSprite;
  final String whiteLadySprite = Globals.whiteLadySprite;
  final String tikbalangSprite = Globals.tikbalangSprite;

  final Vector2 startPosition;

  late Vector2 _velocity;
  double speed = 300;

  double degree = pi / 100;

  EnemyComponent({required this.startPosition, required String sprite});

  @override
  Future<void> onLoad() async{
    await super.onLoad();

    // Load and set the sprite randomly among the three options
    final List<String> sprites = [aswangSprite, balbalSprite, tiyanakSprite, tikbalangSprite, whiteLadySprite, kapreSprite];
    final int randomIndex = Random().nextInt(sprites.length);
    sprite = await gameRef.loadSprite(sprites[randomIndex]);
   
    position = startPosition;
    height = _spriteHeight;
    width = _spriteHeight;
    anchor = Anchor.center;

    final double spawnAngle = _getSpawnAngle();
    final double vy = sin(spawnAngle * degree) * speed;
    final double vx = cos(spawnAngle * degree) * speed;

    _velocity = Vector2(vx, vy);

    _rightBound = gameRef.size.x - 45;
    _leftBound = 0;
    _upBound = 0 ;
    _downBound = gameRef.size.y - 45;

    add(CircleHitbox());
  }

  @override
  void update(double dt){
    super.update(dt);

    position += _velocity * dt;

    if (x >= _rightBound) {
      x = _rightBound;
      _velocity.x = -_velocity.x; // Reverse horizontal velocity
    }

    if (x <= _leftBound) {
      x = _leftBound;
      _velocity.x = -_velocity.x; // Reverse horizontal velocity
    }

    if (y >= _downBound) {
      y = _downBound;
      _velocity.y = -_velocity.y; // Reverse vertical velocity
    }

    if (y <= _upBound) {
      y = _upBound;
      _velocity.y = -_velocity.y; // Reverse vertical velocity
    }
  }

  double _getSpawnAngle(){
    final random = Random().nextDouble();
    final spawnAngle = lerpDouble(0, 360, random)!;

    return spawnAngle;
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);

    if (other is ScreenHitbox) {
      final Vector2 collisionPoint = intersectionPoints.first;

      if (collisionPoint.x == 0 || collisionPoint.x == gameRef.size.x) {
        _velocity.x = -_velocity.x; // Reverse horizontal velocity
      }

      if (collisionPoint.y == 0 || collisionPoint.y == gameRef.size.y) {
        _velocity.y = -_velocity.y; // Reverse vertical velocity
      }
    }
  }
}
