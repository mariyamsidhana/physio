import 'package:flutter/material.dart';
import 'package:flutter_auth_page/constants.dart';

class OrDivider extends StatelessWidget {
  const OrDivider({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      width: size.width * 0.7,
      margin: EdgeInsets.symmetric(vertical: (size.height * 0.02)),
      child: Row(
        children: [
          buildDivider(),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: (size.height * 0.01)),
            child: Text(
              "or".toUpperCase(),
              style: const TextStyle(
                color: kPrimaryColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          buildDivider(),
        ],
      ),
    );
  }
}

Expanded buildDivider() {
  return const Expanded(
    child: Divider(
      color: kPrimaryColor,
      height: 1.5,
    ),
  );
}