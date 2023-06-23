import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/src/gestures/events.dart';

import '../game/flappy_bird.dart';
import 'bird_component.dart';

class BackgroundComponent extends SpriteComponent
    with HasGameRef<FlappyBird>, Tappable {
  @override
  FutureOr<void> onLoad() async {
    await super.onLoad();

    sprite = await gameRef.loadSprite('backgroundFlappy.png');
    size = gameRef.size;
  }

  // @override
  // bool onTapDown(TapDownInfo info) {
  //   try {
  //     if (!gameRef.isGamePaused) {
  //       bird.y -= 70;
  //     }
  //     return super.onTapDown(info);
  //   } catch (e) {
  //     return false;
  //   }
  // }
}
