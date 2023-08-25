import 'package:flutter/material.dart';

class RectangularButton extends ElevatedButton {
  final EdgeInsets padding;
  RectangularButton(
      {required VoidCallback? onPressed,
      required Widget? child,
      bool ripple = true,
      required color,
      this.padding = const EdgeInsets.symmetric(
        vertical: 15,
      )})
      : super(
          onPressed: onPressed,
          child: child,
          style: ButtonStyle(
            padding: MaterialStateProperty.all(
              padding,
            ),
            splashFactory: ripple ? null : NoSplash.splashFactory,
            backgroundColor:
                onPressed != null ? MaterialStateProperty.all(color) : null,
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
          ),
        );
}
