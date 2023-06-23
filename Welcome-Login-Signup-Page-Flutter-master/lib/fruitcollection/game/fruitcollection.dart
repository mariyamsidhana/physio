import 'dart:async';
import 'dart:math';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame_texturepacker/flame_texturepacker.dart';
import 'package:flutter/material.dart';

import '../components/background_component.dart';
import '../components/boy_component.dart';
import '../components/fruit_component.dart';
import '../components/pausebutton_component.dart';

late BoyComponent boy;

late String positionReachingAfterRun;
late bool boyRemoved;
late bool runLeft;
late bool runRight;
late bool busy;
late double distanceRun;

late String currentPosition;
late String head;

late PauseButton pauseButton;

class FruitCollection extends FlameGame
    with HasTappables, HasCollisionDetection {
  late TextComponent scoreComponent;
  late TextComponent remainingLifeComponent;
  late SpriteAnimationComponent boyWalking;
  late int fruitCollected;
  late int fruitMissed;
  bool isGamePaused = true;

  @override
  FutureOr<void> onLoad() async {
    await super.onLoad();

    // Initialiszation
    positionReachingAfterRun = "";
    boyRemoved = false;
    runLeft = false;
    runRight = false;
    busy = false;
    distanceRun = 0;

    currentPosition = "CENTER"; // LEFT OR CENTER OR RIGHT

    head = "RIGHT"; // LEFT OR RIGHT

    fruitCollected = 0;
    fruitMissed = 0;
    // Background
    add(BackgroundComponent());

    // Fruit every 2 seconds
    add(TimerComponent(
        period: 5,
        repeat: true,
        onTick: () async {
          if (!isGamePaused) {
            // random number
            var random = Random();
            var positionIndex = random.nextInt(3);
            add(FruitComponent(positionIndex));
          }
        }));

    // Boy
    boy = BoyComponent();
    add(boy);
    // Text Component for score
    TextPaint scoreText = TextPaint(
      style: const TextStyle(
          color: Color.fromARGB(255, 72, 33, 243),
          fontSize: 20,
          fontWeight: FontWeight.bold),
    );

    scoreComponent = TextComponent(
        text: "SCORE :$fruitCollected",
        position: Vector2(size[0] * .03, size[1] * .1),
        textRenderer: scoreText);

    add(scoreComponent);

    // Text Compoenent for remaining life

    TextPaint remainingLifeText = TextPaint(
      style: const TextStyle(
          color: Color.fromARGB(255, 243, 33, 33),
          fontSize: 30,
          fontWeight: FontWeight.bold),
    );
    remainingLifeComponent = TextComponent(
        text: "LIFE :${5 - fruitMissed}",
        position: Vector2(size[0] * .35, size[1] * .2),
        textRenderer: remainingLifeText);

    add(remainingLifeComponent);

    // Animation

    final spritesheet =
        await fromJSONAtlas('boy_sprite.png', 'boy_sprite.json');

    SpriteAnimation walk =
        SpriteAnimation.spriteList(spritesheet, stepTime: 0.1);
    boyWalking = SpriteAnimationComponent()
      ..animation = walk
      ..x = size[0] * 0.4
      ..y = size[1] / 1.28
      ..size = Vector2(size[1] / 5, size[1] / 5.5);

    // Pause Button
    add(PauseButton());
    // overlay
    overlays.add('StartMenu');
  }

  @override
  void update(double dt) {
    super.update(dt);

    // End Game
    if (isGamePaused) return;

    // update score
    final newScore = "SCORE :${fruitCollected}";
    scoreComponent.text = newScore;

    // update remaining life

    final newLife = "LIFE :${5 - fruitMissed}";
    remainingLifeComponent.text = newLife;

    // To remove boy character

    if (boyRemoved) {
      if (runLeft) {
        if (head == "RIGHT") {
          head = "LEFT";
          boy.flipHorizontally();
          boyWalking.flipHorizontally();
          //flip problem

          boy.x += size[0] / 10;
          boyWalking.x += size[0] / 10;
        }
      } else {
        // runRight
        if (head == "LEFT") {
          head = "RIGHT";
          boy.flipHorizontally();
          boyWalking.flipHorizontally();

          boy.x -= size[0] / 10;
          boyWalking.x -= size[0] / 10;
        }
      }
      remove(boy);
      add(boyWalking);
      boyRemoved = false;
    }

    // Left Movements

    if (runLeft &&
        distanceRun < ((size[0] * .7 - size[0] * .4)) &&
        contains(boyWalking)) {
      distanceRun += 5;
      boyWalking.x -= 5;
    }

    if (runLeft && distanceRun >= (size[0] * .7 - size[0] * .4)) {
      boy.x = boyWalking.x;
      print("boyWalking.x (LEFT)");
      print(boyWalking.x);
      print("boy.x(LEFT)");
      print(boy.x);
      busy = false; // Boy reached at the place
      remove(boyWalking);
      add(boy);
      distanceRun = 0;
      runLeft = false;

      currentPosition = positionReachingAfterRun;
    }

    // Right Movements

    if (runRight &&
        distanceRun < (size[0] * .7 - size[0] * .4) &&
        contains(boyWalking)) {
      distanceRun += 5;
      boyWalking.x += 5;
    }

    if (runRight && distanceRun >= (size[0] * .7 - size[0] * .4)) {
      boy.x = boyWalking.x;
      print("boyWalking.x (RIGHT)");
      print(boyWalking.x);
      print("boy.x(RIGHT)");
      print(boy.x);
      busy = false; // Boy reached at the place

      remove(boyWalking);
      add(boy);
      distanceRun = 0;
      runRight = false;

      currentPosition = positionReachingAfterRun;
    }
  }

  void reset() {
    fruitCollected = 0;
    fruitMissed = 0;
    // Remove all components
    children.forEach((child) {
      if (child is FruitComponent) remove(child);
    });

    // Add the inital tubes
  }

  void removeAllExit() {
    children.forEach((child) {
      remove(child);
    });
  }
}

void leftControl() {
  print("inisde leftcontrol");
  print(currentPosition);
  print(busy);
  if ((currentPosition == "CENTER" || currentPosition == "RIGHT") && !busy) {
    distanceRun = 0;
    boyRemoved = true;
    runLeft = true;
    busy = true;

    // New position
    currentPosition == "CENTER"
        ? positionReachingAfterRun = "LEFT"
        : positionReachingAfterRun = "CENTER";

    currentPosition = "";
    print(positionReachingAfterRun);
  }
}

void rightControl() {
  print("inside right");
  print(currentPosition);
  print(busy);
  if ((currentPosition == "CENTER" || currentPosition == "LEFT") && !busy) {
    distanceRun = 0;
    boyRemoved = true;
    runRight = true;
    busy = true;

    // New position
    currentPosition == "CENTER"
        ? positionReachingAfterRun = "RIGHT"
        : positionReachingAfterRun = "CENTER";

    currentPosition = "";
    print(positionReachingAfterRun);
  }
}
