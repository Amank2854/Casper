import 'package:casper/components/customised_text.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class DataNotFound extends StatelessWidget {
  String message;

  DataNotFound({
    super.key,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 600,
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              color: Colors.grey[300],
              size: 50,
            ),
            const SizedBox(
              width: 10,
            ),
            CustomisedText(
              text: message,
              color: Colors.grey[300],
              fontSize: 30,
            ),
          ],
        ),
      ),
    );
  }
}
