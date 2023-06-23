import 'package:flutter/foundation.dart';
import 'package:flutter_auth_page/dino/vision_detector_views/face_detector_view.dart';
import 'package:hive/hive.dart';
import 'package:flame/flame.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

import 'dino_game_oldmain.dart';
import 'models/settings.dart';
import 'models/player_data.dart';

import 'package:camera/camera.dart';

final Changer changer = Changer();



class DinoRunFace extends StatelessWidget {
  // BuildContext rootContext;
  const DinoRunFace({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        SizedBox(
          width: 384,
          height: 500,
          child: DinoRunApp(),
        ),
        SizedBox(
          width: 384,
          height: 300,
          child: FaceDetectorView(),
        ),
      ],
    ));
  }
}

// This function will initilize hive with apps documents directory.
// Additionally it will also register all the hive adapters.
Future<void> initHive() async {
  // For web hive does not need to be initialized.
  if (!kIsWeb) {
    final dir = await getApplicationDocumentsDirectory();
    Hive.init(dir.path);
  }

  Hive.registerAdapter<PlayerData>(PlayerDataAdapter());
  Hive.registerAdapter<Settings>(SettingsAdapter());
}

// The main widget for this game.

class Changer extends ChangeNotifier {

  // Dino
bool firstFrameDino = true;
late int DinoNosePoint;
bool isDinoHeadUp = false; 
  void notify() {
    notifyListeners();
  }
}

