import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_auth_page/constants.dart';

class Social extends StatelessWidget {
  const Social({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.all(15),
          margin: const EdgeInsets.only(right: 20),
          decoration: BoxDecoration(
            border: Border.all(
              width: 2,
              color: kPrimaryLightColor,
            ),
            shape: BoxShape.circle,
          ),
          child: SvgPicture.asset(
            'assets/icons/facebook.svg',
            width: 20,
            height: 20,
            colorFilter: const ColorFilter.mode(kPrimaryColor, BlendMode.srcIn),
          ),
        ),
        Container(
          padding: const EdgeInsets.all(15),
          margin: const EdgeInsets.only(right: 20),
          decoration: BoxDecoration(
            border: Border.all(
              width: 2,
              color: kPrimaryLightColor,
            ),
            shape: BoxShape.circle,
          ),
          child: SvgPicture.asset(
            'assets/icons/twitter.svg',
            width: 20,
            height: 20,
            colorFilter: const ColorFilter.mode(kPrimaryColor, BlendMode.srcIn),
          ),
        ),
        Container(
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            border: Border.all(
              width: 2,
              color: kPrimaryLightColor,
            ),
            shape: BoxShape.circle,
          ),
          child: SvgPicture.asset(
            'assets/icons/google-plus.svg',
            width: 20,
            height: 20,
            colorFilter: const ColorFilter.mode(kPrimaryColor, BlendMode.srcIn),
          ),
        ),
      ],
    );
  }
}
