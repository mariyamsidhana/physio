import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth_page/pages/pickgame.dart';
import 'package:flutter_auth_page/pages/drawer.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_auth_page/constants.dart';
import 'package:flutter_auth_page/pages/drawerlist.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool _obscureText = true;

  Future signIn() async {
    if (emailController.text == "" || passwordController.text == "") {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              // Icon(icon, color: Colors.white),
              SizedBox(width: 8.0),
              Text("Please enter all fields"),
            ],
          ),
          backgroundColor: Colors.red,
        ),
      );
    } else {
      try {
        FocusScope.of(context).unfocus();
        UserCredential userCredential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(
                email: emailController.text.trim(),
                password: passwordController.text.trim());
        if (userCredential.user != null) {
          // ignore: use_build_context_synchronously
          FocusScope.of(context).unfocus();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Row(
                children: const [
                  // Icon(icon, color: Colors.white),
                  SizedBox(width: 8.0),
                  Text("Login Success"),
                ],
              ),
              backgroundColor: Colors.green,
            ),
          );
          // ignore: use_build_context_synchronously
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => HomeScreen(),
            ),
          );
          emailController.text = "";
          passwordController.text = "";
        }
      } on FirebaseAuthException catch (e) {
        print(e.code);

        String errorMessage;
        if (e.code == 'invalid-email') {
          errorMessage = 'Please enter a valid email address.';
        } else if (e.code == 'user-disabled') {
          errorMessage = 'Your account has been disabled.';
        } else if (e.code == 'user-not-found') {
          errorMessage = 'User not found.';
        } else if (e.code == 'wrong-password') {
          errorMessage = 'Incorrect password.';
        } else {
          errorMessage = 'An unknown error occurred. Please try again later.';
        }
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: [
                // Icon(icon, color: Colors.white),
                SizedBox(width: 8.0),
                Text(errorMessage),
              ],
            ),
            backgroundColor: Colors.red,
          ),
        );
        print(e.toString());
      }
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      resizeToAvoidBottomInset: false,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.popAndPushNamed(context, '/');
        },
        backgroundColor: kPrimaryColor,
        child: const Icon(Icons.home),
      ),
      body: SizedBox(
        // color: Colors.amber[100],
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          children: [
            Positioned(
              top: 0,
              left: 0,
              child: Image.asset(
                "assets/images/main_top.png",
                width: 150,
                height: 100,
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: Image.asset(
                "assets/images/login_bottom.png",
                width: 150,
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 40),
                  Text(
                    'Login'.toUpperCase(),
                    style: const TextStyle(
                      fontFamily: 'SourceSansPro',
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 40),
                  SvgPicture.asset(
                    'assets/icons/undraw_ninja_e-52-b.svg',
                    width: 260,
                  ),
                  const SizedBox(height: 40),
                  Container(
                    width: 300,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(66),
                      color: kPrimaryLightColor,
                    ),
                    child: TextField(
                      controller: emailController,
                      obscureText: false,
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.done,
                      decoration: const InputDecoration(
                        hintText: "Email :",
                        hintStyle: TextStyle(
                          fontFamily: 'SourceSansPro',
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                        // labelText: "Username",
                        labelStyle: TextStyle(
                          fontSize: 18,
                        ),
                        // border: OutlineInputBorder(),
                        border: InputBorder.none,
                        prefixIcon: Icon(
                          Icons.person,
                          color: kPrimaryColor,
                          size: 18,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    width: 300,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(66),
                      color: kPrimaryLightColor,
                    ),
                    child: TextField(
                      controller: passwordController,
                      obscureText: _obscureText,
                      enableSuggestions: false,
                      autocorrect: false,
                      keyboardType: TextInputType.visiblePassword,
                      textInputAction: TextInputAction.done,
                      decoration:  InputDecoration(
                          hintText: "Password :",
                          hintStyle: TextStyle(
                            fontFamily: 'SourceSansPro',
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                          // labelText: "Email :",
                          labelStyle: TextStyle(
                            fontSize: 20,
                          ),
                          // border: OutlineInputBorder(),
                          border: InputBorder.none,
                          prefixIcon: Icon(
                            Icons.lock,
                            color: kPrimaryColor,
                            size: 18,
                          ),
                          suffixIcon:  GestureDetector(
                            onTap: () {
                              setState(() {
                                 _obscureText = !_obscureText;
                              });
                             
                            },
                            child: Icon(_obscureText ? Icons.visibility : Icons.visibility_off),
                          )),
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: 300,
                    child: ElevatedButton(
                      onPressed: signIn,
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(kPrimaryColor),
                        padding:
                            MaterialStateProperty.all(const EdgeInsets.all(15)),
                        foregroundColor:
                            MaterialStateProperty.all(Colors.white60),
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(66),
                          ),
                        ),
                      ),
                      child: Text(
                        'Login'.toUpperCase(),
                        style: const TextStyle(
                          fontFamily: 'SourceSansPro',
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Dont't have an Account ? ",
                        style: TextStyle(
                          color: kPrimaryColor,
                          fontFamily: 'SourceSansPro',
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, '/signup');
                        },
                        child: const Text(
                          'Sign Up',
                          style: TextStyle(
                            color: kPrimaryColor,
                            fontFamily: 'SourceSansPro',
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
