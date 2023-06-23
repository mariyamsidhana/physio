import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/flame.dart';

import '../game/fruitcollection.dart';

class PauseButton extends SpriteComponent
    with HasGameRef<FruitCollection>, Tappable {
  @override
  FutureOr<void> onLoad() async {
    await super.onLoad();
    sprite = await gameRef.loadSprite('pause.png');
    size = gameRef.size * 0.09;
    position = Vector2(gameRef.size[0] * 0.8, gameRef.size[1] * 0.1);
  }

  @override
  bool onTapDown(TapDownInfo info) {
    try {
      if (!gameRef.isGamePaused) {
        gameRef.isGamePaused = true;
        gameRef.overlays.add('PauseMenu');
      }
      return super.onTapDown(info);
    } catch (e) {
      print(e);
      return false;
    }
  }
}
