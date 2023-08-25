import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'app_theme.dart';
import 'rectangular_button.dart';

class LongButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final Widget? child;
  final Color? color;
  final Color? disabledColor;
  final bool? isLoading;
  final bool? isDisabled;
  final double maximumWidth;

  const LongButton(
      {Key? key,
      required this.onPressed,
      required this.child,
      this.color = AppThemes.mainColorGreen,
      this.isLoading,
      this.maximumWidth = 500,
      this.isDisabled,
      this.disabledColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double width = maximumWidth;

    return IgnorePointer(
      ignoring: isDisabled ?? false,
      child: Container(
        constraints: BoxConstraints(maxWidth: width),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: RectangularButton(
                ripple: !loading,
                onPressed: loading ? null : onPressed,
                color: getColor,
                child: loading
                    ? SpinKitCircle(
                        size: 20,
                        color: Colors.white,
                      )
                    : child,
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool get loading {
    return isLoading != null && isLoading!;
  }

  Color get getColor {
    if (isDisabled == null) return color ?? AppThemes.mainColorGreen;
    if (isDisabled!) {
      return disabledColor ?? AppThemes.mainColorGrey;
    }
    return color ?? AppThemes.mainColorGreen;
  }
}
