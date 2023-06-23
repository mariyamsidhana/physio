import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/experimental.dart';

import '../game/fruitcollection.dart';

class FruitComponent extends SpriteComponent with HasGameRef<FruitCollection> {
  late int positionIndex;
  FruitComponent(this.positionIndex);
  @override
  FutureOr<void> onLoad() async {
    await super.onLoad();

    // Different x position
    var positions = [
      gameRef.size[0] * 0.1,
      gameRef.size[0] * 0.4,
      gameRef.size[0] * 0.7
    ];

    sprite = await gameRef.loadSprite('orange.png');
    size = gameRef.size * 0.06;
    position = Vector2(positions[positionIndex], gameRef.size[1] * 0.3);

    add(CircleHitbox());
  }

  @override
  void update(double dt) {
    super.update(dt);

    if (position.y > gameRef.size[1] - (gameRef.size[1] * .1)) {
      removeFromParent();
      gameRef.fruitMissed += 1;

      if (gameRef.fruitMissed >= 5) {
        gameRef.isGamePaused = true;
        gameRef.overlays.add("GameOverMenu");
      }
    } else {
      position.y += 1;
    }
  }
}
