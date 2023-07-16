import 'package:cathnow/utils/settings.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyText extends StatelessWidget {
  final String text;
  final Settings settings = Settings();

  MyText({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<Settings>(
      builder: (context, settings, _) {
        return Text(
          text,
          style: TextStyle(fontSize: settings.textSize),
        );
      },
    );
  }
}
