import 'package:flutter/material.dart';

class PlusButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback onPressed;

  const PlusButton({
    Key? key,
    required this.buttonText,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
        onPressed: onPressed,
        icon: const Icon(Icons.plus_one_rounded),
        label: Text(buttonText));
  }
}
