
import 'package:auto_size_text/auto_size_text.dart';
import 'package:jre_app/utils/ui_util.dart';

import '../../theme/bloc/theme_bloc/theme_bloc.dart';


class AppCustomText extends StatelessWidget with UiUtil {
  AppCustomText({
    super.key,
    required this.titleText,
    this.textColor,
    this.fontWeight,
    this.maxLines,
    this.lines,
    this.textStyle,
    this.textCenter,
    this.enableShimmer = false,
    this.widthShimmer,
    this.heightShimmer,
  });

  final String titleText;
  final Color? textColor;
  final double? widthShimmer;
  final double? heightShimmer;
  final bool? textCenter;
  final bool enableShimmer;
  final TextStyle? textStyle;
  final FontWeight? fontWeight;
  final int? maxLines;
  final int? lines;

  @override
  Widget build(BuildContext context) {
    return AutoSizeText(
      titleText,
      maxLines: maxLines ?? 2,
      overflow: TextOverflow.ellipsis,
      style: textStyle ??
          Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: textColor ?? Colors.black,
                fontWeight: fontWeight ?? FontWeight.w500,
              ),
      textAlign: textCenter == true ? TextAlign.center : TextAlign.start,
    );
  }
}
