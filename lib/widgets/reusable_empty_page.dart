import 'package:flutter/material.dart';

class EmptyPageView extends StatelessWidget {
  final String text;
  final String imgPath;

  const EmptyPageView(
      {super.key,
      required this.text,
      this.imgPath = "assets/image/empty_cart.png"});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Image.asset(imgPath),
        SizedBox(height: MediaQuery.of(context).size.height * 0.03),
        Text(
          text,
          style: TextStyle(
            fontSize: MediaQuery.of(context).size.height * 0.0175,
            color: Theme.of(context).disabledColor,
          ),
          textAlign: TextAlign.center,
        )
      ],
    );
  }
}
