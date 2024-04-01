import 'package:flame/components.dart';
import 'package:flame/collisions.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';
import 'package:midterm1/components/enemy_component.dart';
import 'package:midterm1/constants/global.dart';
import 'package:midterm1/games/dodge_game.dart';
import 'package:flutter/widgets.dart';
import 'package:midterm1/scrrens/gameover.dart';

enum MovementState {
  idle,
  slideLeft,
  slideRight,
  wekean,
}

class CharacterComponent extends SpriteGroupComponent<MovementState>
    with HasGameRef<DodgeGame>, CollisionCallbacks {
  final double _spriteHeight = 80;
  final double _speed = 400;

  final JoystickComponent joystick;

  late double _rightBound;
  late double _leftBound;
  late double _upBound;
  late double _downBound;

  bool weaken = false;
  final Timer _timer = Timer(3);

  CharacterComponent({required this.joystick});

  @override
  Future<void> onLoad() async {
    final Sprite charIdle = await gameRef.loadSprite(Globals.character);
    final Sprite charSlideLeft =
        await gameRef.loadSprite(Globals.characterleft);
    final Sprite charSlideRight =
        await gameRef.loadSprite(Globals.characterright);
    final Sprite charWeaken = await gameRef.loadSprite(Globals.weakenSprite);

    position = gameRef.size / 2;
    height = _spriteHeight;
    width = _spriteHeight * 1.42;

    sprites = {
      MovementState.idle: charIdle,
      MovementState.slideLeft: charSlideRight,
      MovementState.slideRight: charSlideLeft,
      MovementState.wekean: charWeaken
    };

    _rightBound = gameRef.size.x - 45;
    _leftBound = 0;
    _upBound = 0;
    _downBound = gameRef.size.y - 85;

    current = MovementState.idle;

    add(CircleHitbox());
  }

  @override
  void update(dt) {
    super.update(dt);

    if (!weaken) {
      if (joystick.direction == JoystickDirection.idle) {
        current = MovementState.idle;
        return;
      }

      if (x >= _rightBound) {
        x = _rightBound - 1;
      }

      if (x <= _leftBound) {
        x = _leftBound + 1;
      }

      if (y >= _downBound) {
        y = _downBound - 1;
      }

      if (y <= _upBound) {
        y = _upBound + 1;
      }

      bool movingLeft = joystick.relativeDelta[0] < 0;

      if (movingLeft) {
        current = MovementState.slideLeft;
      } else {
        current = MovementState.slideRight;
      }

      position.add(joystick.relativeDelta * _speed * dt);
    } else {
      _timer.update(dt);
      if (_timer.finished) {
        _unWeakenChar();
      }
    }
  }

  // @override
  // void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
  //   super.onCollision(intersectionPoints, other);

  //   if (other is EnemyComponent) {
  //     _weakenChar();
  //   }
  // }
  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);

    if (other is EnemyComponent) {
      _weakenChar();
      if (gameRef.lives == 0) {
        gameRef.pauseEngine();
        gameRef.overlays.add(GameOverMenu.ID);
      }
    }
  }

  void _unWeakenChar() {
    weaken = false;
    current = MovementState.idle;
  }

  void _weakenChar() {
    if (!weaken) {
      FlameAudio.play(Globals.attackSound);

      gameRef.lives--; // Decrement lives when colliding with an enemy

      weaken = true;

      current = MovementState.wekean;

      _timer.start();
    }
  }
}
