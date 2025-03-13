import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../translation/translation.dart';

class ElevatedButtonApp extends StatelessWidget {
  final VoidCallback onPresses;
  final String textButton;
  Color? backgroundColor;
  Color? textColor;
  bool? hasIcon = false;
  final Widget? icon;

  ElevatedButtonApp({
    required this.onPresses,
    required this.textButton,
    this.backgroundColor,
    this.hasIcon,
    this.textColor,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context);

    return Padding(
      padding: EdgeInsetsDirectional.symmetric(
        horizontal: 30.w,
        vertical: 16.h,
      ),
      child: ElevatedButton(
        style: ButtonStyle(
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0)),
          ),
          backgroundColor: MaterialStateProperty.all(
            backgroundColor ?? Colors.blueGrey,
          ),
        ),
        onPressed: onPresses,
        child: Container(
          width: 1.sh,
          padding: EdgeInsets.symmetric(vertical: 17.h),
          child:
              hasIcon == true
                  ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        appLocalizations.translate(textButton),
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: textColor ?? Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      icon!,
                    ],
                  )
                  : Text(
                appLocalizations.translate(textButton),
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: textColor ?? Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
        ),
      ),
    );
  }
}
