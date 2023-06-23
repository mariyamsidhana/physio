import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../components/gameovermenu_component.dart';
import '../components/pausemenu_component.dart';
import '../components/startmenu_component.dart';
import '../vision_detector_views/face_detector_view.dart';
import 'fruitcollection.dart';

class FruitCollectionFace extends StatelessWidget {
  const FruitCollectionFace({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.65,
          child: GameWidget(
            game: FruitCollection(),
            overlayBuilderMap: {
        'StartMenu': (BuildContext context,FruitCollection fruitCollection  ) {
          return StartMenu(
            gameRef:fruitCollection,
          );
        },
        'GameOverMenu': (BuildContext context,FruitCollection fruitCollection) {
          return GameOverMenu(
            gameRef: fruitCollection,
          );
        },
         'PauseMenu': (BuildContext context,FruitCollection fruitCollection) {
          return PauseMenu(
            gameRef: fruitCollection,
          );
        }
      },
          ),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.35,
          child: FaceDetectorView(),
        ),
      ],
    ));
  }
}
