import 'package:flame/game.dart';
import 'package:flutter/material.dart';

import '../../vision_detector_views/face_detector_view_flappy.dart';
import '../components/gameovermenu_component.dart';
import '../components/startmenu_component.dart';
import 'flappy_bird.dart';

class FlappyFaceDetect extends StatelessWidget {
  const FlappyFaceDetect({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.65,
          child: GameWidget(
            game: FlappyBird(),
            overlayBuilderMap: {
              'StartMenu': (BuildContext context, FlappyBird flappyBird) {
                return StartMenu(
                  gameRef: flappyBird,
                );
              },
              'GameOverMenu': (BuildContext context, FlappyBird flappyBird) {
                return GameOverMenu(
                  gameRef: flappyBird,
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
