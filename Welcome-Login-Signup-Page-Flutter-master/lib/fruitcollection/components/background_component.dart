import 'dart:async';

import 'package:flame/components.dart';

import '../game/fruitcollection.dart';

class BackgroundComponent extends SpriteComponent
    with HasGameRef<FruitCollection> {
  @override
  FutureOr<void> onLoad() async {
    await super.onLoad();

    sprite = await gameRef.loadSprite('backgroundFruit.png');
    size = gameRef.size;
  }
}
