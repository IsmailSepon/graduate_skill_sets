import 'package:flutter/material.dart';
import 'list_tile_border_radius.dart';

class AnimatedListTile extends StatelessWidget {
  const AnimatedListTile({
    Key? key,
    this.title,
    this.subtitle,
    this.leading,
    this.trailing,
    this.isDisabled = false,
    this.onTap,
    this.borderRadius,
    this.contentPadding,
    this.hide = false,
  }) : super(key: key);
  final bool isDisabled;
  final Widget? title;
  final Widget? subtitle;
  final Widget? leading;
  final Widget? trailing;
  final BorderRadius? borderRadius;
  final EdgeInsetsGeometry? contentPadding;
  final void Function()? onTap;
  final bool hide;

  final Color? disabledColor = const Color(0xff616161);

  @override
  Widget build(BuildContext context) {
    final Color? disabledBackgroundColor = isDisabled
        ? Theme.of(context).colorScheme.background.withOpacity(0.8)
        : null;
    final Duration defaultDuration = Duration(milliseconds: 300);
    final borderRadiusCache = borderRadius ?? ListTileBorderRadius.full;
    final Color? disabledColorCache = isDisabled ? disabledColor : null;
    final Color? textColor = disabledColorCache;
    final Color? iconColor = disabledColorCache;

    return IgnorePointer(
      ignoring: isDisabled,
      child: AnimatedContainer(
        duration: defaultDuration,
        decoration: BoxDecoration(
          borderRadius: borderRadiusCache,
          color: disabledBackgroundColor,
        ),
        child: Ink(
          decoration: BoxDecoration(
            borderRadius: borderRadiusCache,
            color: hide ? null : Theme.of(context).colorScheme.background,
          ),
          child: InkWell(
            borderRadius: borderRadiusCache,
            onTap: onTap,
            child: ListTile(
              tileColor: Colors.white60,
              contentPadding: contentPadding,
              textColor: textColor,
              iconColor: iconColor,
              title: title,
              subtitle: subtitle,
              leading: leading,
              trailing: trailing,
            ),
          ),
        ),
      ),
    );
  }
}
