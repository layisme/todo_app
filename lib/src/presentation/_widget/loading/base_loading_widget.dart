import 'package:flutter/material.dart';
import 'package:todo_app/src/core/style/style.dart';

class BaseLoading extends StatelessWidget {
  const BaseLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // height: 100,
      // width: 100,
      child: CircularProgressIndicator(
        color: Style.primaryButton,
        strokeCap: StrokeCap.round,
      ),
    );
  }
}