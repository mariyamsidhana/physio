import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_auth_page/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_auth_page/pages/signup.dart';
import 'package:flutter_auth_page/constants.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';


// import '../reusable_widgets/reusable.dart';
//import 'drawerscreen.dart';

class MyHeaderDrawer extends StatefulWidget {
  const MyHeaderDrawer({super.key});

  @override
  State<MyHeaderDrawer> createState() => _MyHeaderDrawerState();
}

class _MyHeaderDrawerState extends State<MyHeaderDrawer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
             stops: [0.3, 1],
            colors: [
            Colors.white,
            Colors.cyan
            // hexStringToColor(Colors.cyan),
            // hexStringToColor('20797C'),
            // hexStringToColor('209E5A')
          ])),
      width: double.infinity,
      height: 200,
      padding: const EdgeInsets.only(top: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 10),
            height: 70,
            decoration: const BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: AssetImage('assets/images/profile.png'),
                )),
          ),
          const Text(
            "User",
            style: TextStyle(
                color: Colors.black, fontSize: 30, fontStyle: FontStyle.normal),
          ),
        ],
      ),
    );
  }
}
