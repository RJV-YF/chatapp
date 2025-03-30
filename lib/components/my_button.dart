import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  const MyButton({super.key, required this.buttonText, this.onTap});

  final String buttonText;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Theme.of(context).colorScheme.onPrimary,
          ),
          alignment: Alignment(0, 0),
          padding: EdgeInsets.all(12),
          margin: EdgeInsets.symmetric(
            horizontal: 22,
          ),
          width: double.infinity,
          child: Text(
            buttonText,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 22,
            ),
          ),
        ));
  }
}
