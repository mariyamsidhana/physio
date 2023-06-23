import 'package:camera/camera.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flame/flame.dart';
import 'package:flutter/material.dart';

import 'package:flutter_auth_page/pages/login.dart';
import 'package:flutter_auth_page/pages/signup.dart';
import 'package:flutter_auth_page/pages/welcome.dart';

import 'dino/dino_game_main.dart';
import 'firebase_options.dart';

List<CameraDescription> cameras = [];
final Changer changer = Changer();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initHive();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Flame.device.fullScreen();
  Flame.device.setPortrait();
  cameras = await availableCameras();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        // '/drawer': (context) => const
        '/': (context) => const Welcome(),
        '/login': (context) => const Login(),
        '/signup': (context) => const Signup(),
      },
    );
  }
}

class Changer extends ChangeNotifier {
  int currentBar = 0; // for choosing gap
  late int flappyNosePoint;
  bool firstFrame = true;


  bool isFlappyHeadUp = false; // used in flappy

  // FLAPPY ENDS



  void notify() {
    notifyListeners();
  }
}
