import 'package:flame/components.dart';
import 'package:midterm1/constants/global.dart';
import 'package:midterm1/games/dodge_game.dart';

class BackgroundComponent extends SpriteComponent with HasGameRef<DodgeGame> {

  @override
  Future<void> onLoad() async{
    await super.onLoad();

    sprite =  await gameRef.loadSprite(Globals.bgSprite);
    size = gameRef.size;
  }
}