import 'package:flutter/material.dart';
import 'package:cathnow/widgets/my_text.dart';

class DescriptionWidget extends StatelessWidget {
  final String text;
  final double borderRadius;

  const DescriptionWidget({
    Key? key,
    required this.text,
    this.borderRadius = 10.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          //color: Colors.black,
          width: 3.0,
        ),
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      padding: const EdgeInsets.all(16.0),
      child: MyText(
        text: text,
      ),
    );
  }
}
