import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  const ButtonWidget(
      {super.key,
      this.onPressed,
      this.title,
      this.backgroundColor,
      this.borderColor,
      this.titleColor})
      : _type = ButtonType.none;

  const ButtonWidget.border(
      {super.key,
      this.onPressed,
      this.title,
      this.backgroundColor,
      this.borderColor, 
      this.titleColor})
      : _type = ButtonType.border;

  final ButtonType _type;
  final void Function()? onPressed;
  final String? title;
  final Color? backgroundColor;
  final Color? borderColor;
  final Color? titleColor;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: ButtonStyle(
          padding: const WidgetStatePropertyAll(EdgeInsets.all(18)),
          backgroundColor: WidgetStatePropertyAll(
              borderColor == null ? backgroundColor : null),
          shape: WidgetStatePropertyAll(RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: _type == ButtonType.border
                  ? BorderSide(color: borderColor ?? Colors.black)
                  : BorderSide.none))),
      child: Text(title ?? '', style: TextStyle(
        color: titleColor
      ),),
    );
  }
}

enum ButtonType { border, none }
