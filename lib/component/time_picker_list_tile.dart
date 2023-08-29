import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'animated_list_tile.dart';
import 'app_theme.dart';

class PsTimePickerListTile extends StatelessWidget {
  final Widget? title;
  final Widget? subtitle;
  final bool isDisabled;
  final DateTime value;
  final void Function(DateTime value) onDateTimeChanged;
  final BorderRadius? borderRadius;
  final bool use24hFormat;

  const PsTimePickerListTile(
      {Key? key,
      this.isDisabled = false,
      this.use24hFormat = false,
      required this.value,
      required this.onDateTimeChanged,
      this.title,
      this.subtitle,
      this.borderRadius})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    return IgnorePointer(
      ignoring: isDisabled,
      child: AnimatedListTile(
        title: title,
        isDisabled: isDisabled,
        borderRadius: borderRadius,
        subtitle: subtitle,
        trailing: TextButton(
          onPressed: () async {
            showCupertinoModalPopup(
              context: context,
              builder: (BuildContext modalContext) {
                return Container(
                  height: height * 0.4,
                  color: Theme.of(context).colorScheme.background,
                  child: CupertinoDatePicker(
                    mode: CupertinoDatePickerMode.time,
                    use24hFormat: use24hFormat,
                    initialDateTime: value,
                    backgroundColor:
                        CupertinoColors.systemBackground.resolveFrom(context),
                    onDateTimeChanged: (DateTime value) {
                      onDateTimeChanged(value);
                    },
                  ),
                );
              },
            );
          },
          child: Text(
            DateFormat('HH:mm').format(value),
            style: TextStyle(
              fontSize: AppThemes.h3FontSize,
              fontWeight: FontWeight.bold,
              color: AppThemes.mainColorGreen,
            ),
          ),
        ),
      ),
    );
  }
}
