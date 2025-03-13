// import 'package:flutter/services.dart';
// import 'package:nstar/util/bloc_imports.dart';
// import 'package:nstar/util/main_import.dart';
//
// class AppTextField extends StatelessWidget with UiUtil {
//   final String? title;
//   final Color? titleColor;
//   final Color? fillColor;
//   final TextEditingController controller;
//   final String hint;
//   final bool? isCenter;
//   final bool? isFormRegistration;
//   final bool? enableShimmer;
//   final double? widthShimmer;
//   final double? heightShimmer;
//   final bool? isPassword;
//   final bool? isBorderEnable;
//   final InputBorder? borderStyle, errorBorderStyle;
//   final Color? enabledBorderColor;
//   final Color? customehintColor;
//   final FormFieldValidator<String>? validator;
//   final FocusNode? currentFocusNode;
//   final TextInputAction? textInputAction;
//   final TextInputType? inputType;
//   final GestureTapCallback? onTap;
//   final ValueChanged<String>? onChange;
//   final ValueChanged<String>? onSubmit;
//   final FormFieldSetter<String>? onSaved;
//   final VoidCallback? onEditingComplete;
//   final int? maxLines;
//   final bool? hasShadow;
//   final Widget? prefixWidget;
//   final Widget? suffixWidget;
//   final bool? enabled;
//   final GestureTapCallback? onPrefixTapped;
//   final EdgeInsetsGeometry? customContentPadding;
//   final String? errorMsg;
//   final bool? isReadOnly;
//   final int? maxLength;
//   final String? prefixText;
//   final bool? isMobileNumber;
//   final TextDirection? textDirection;
//   final bool? closeOnTapOutside;
//   final TextStyle? titleStyle;
//
//   AppTextField({
//     this.title,
//     this.customehintColor,
//     this.borderStyle,
//     this.titleColor,
//     this.errorBorderStyle,
//     this.currentFocusNode,
//     required this.controller,
//     required this.hint,
//     this.isCenter,
//     this.enableShimmer,
//     this.isFormRegistration = false,
//     this.fillColor,
//     this.isBorderEnable = false,
//     this.enabledBorderColor,
//     this.widthShimmer,
//     this.heightShimmer,
//     this.isPassword,
//     this.validator,
//     this.textInputAction,
//     this.inputType = TextInputType.text,
//     this.onTap,
//     this.onChange,
//     this.onSubmit,
//     this.onSaved,
//     this.onEditingComplete,
//     this.maxLines,
//     this.hasShadow,
//     this.prefixWidget,
//     this.suffixWidget,
//     this.enabled,
//     this.onPrefixTapped,
//     this.customContentPadding,
//     this.errorMsg,
//     this.isReadOnly,
//     this.maxLength,
//     this.prefixText,
//     this.isMobileNumber,
//     this.textDirection,
//     this.closeOnTapOutside,
//     this.titleStyle,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     final _digitsOnly = FilteringTextInputFormatter.allow(RegExp(r'[0-9٠-٩]'));
//
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       mainAxisAlignment: MainAxisAlignment.start,
//       children: [
//         if (title?.isNotEmpty ?? false)
//           Text(title ?? '',
//                   style: titleStyle ??
//                       Theme.of(context).textTheme.labelMedium?.copyWith(
//                             color: primaryColor,
//                           ))
//               .applyShimmer(
//                   enable: enableShimmer ?? false,
//                   height: heightShimmer,
//                   width: widthShimmer),
//         if (title?.isNotEmpty ?? false) 8.verticalSpace,
//         Material(
//           color: Colors.transparent,
//           elevation: (hasShadow ?? false) ? 20 : 0,
//           shadowColor: const Color(0xFFB5B5B5).withOpacity(0.2),
//           borderRadius: border,
//           child: TextFormField(
//             autovalidateMode: AutovalidateMode.onUserInteraction,
//             controller: controller,
//             // onTapOutside: (v) {
//             //   if (closeOnTapOutside ?? false) {
//             //     FocusManager.instance.primaryFocus?.unfocus();
//             //   }
//             // },
//             textDirection: textDirection,
//             focusNode: currentFocusNode,
//             readOnly: isReadOnly ?? false,
//             keyboardType: inputType,
//             textInputAction: textInputAction ?? TextInputAction.next,
//             obscureText: isPassword ?? false,
//             inputFormatters: (isMobileNumber ?? false)
//                 ? [_digitsOnly, LengthLimitingTextInputFormatter(200)]
//                 : null,
//             validator: validator,
//             onTap: onTap,
//             onChanged: onChange,
//             onFieldSubmitted: onSubmit,
//             onEditingComplete: onEditingComplete,
//             onSaved: onSaved,
//             maxLines: maxLines ?? 1,
//             maxLength: (isMobileNumber ?? false) ? 10 : (maxLength ?? 35),
//             enabled: enabled ?? true,
//             textAlign: isCenter ?? true ? TextAlign.start : TextAlign.end,
//             style: isFormRegistration == true
//                 ? Theme.of(context).textTheme.headlineMedium?.copyWith(
//                       color: primaryColorLight,
//                       fontWeight: FontWeight.w500,
//                     )
//                 : Theme.of(context).textTheme.labelMedium?.copyWith(
//                       color: primaryColor,
//                     ),
//             decoration: InputDecoration(
//               filled: true,
//               fillColor: fillColor ?? Colors.grey.shade100,
//               hintText: hint,
//               errorBorder: errorBorderStyle ??
//                   OutlineInputBorder(
//                     borderSide: const BorderSide(
//                         color: Colors.transparent,
//                         width: 2,
//                         style: BorderStyle.none),
//                     borderRadius: isBorderEnable == true
//                         ? BorderRadius.circular(25)
//                         : border,
//                   ),
//               focusedErrorBorder: errorBorderStyle ??
//                   OutlineInputBorder(
//                     borderSide:
//                         const BorderSide(width: 2.0, color: Colors.transparent),
//                     borderRadius: isBorderEnable == true
//                         ? BorderRadius.circular(25)
//                         : border,
//                   ),
//               errorText: errorMsg,
//               prefixText: textDirection == null ? prefixText : null,
//               suffixText:
//                   textDirection == TextDirection.ltr ? prefixText : null,
//               prefixStyle: Theme.of(context).textTheme.bodyMedium,
//               suffixStyle: Theme.of(context).textTheme.bodyMedium,
//               counterText: '',
//               counter: const SizedBox(
//                 width: 0,
//                 height: 0,
//               ),
//               hintStyle: isFormRegistration == true
//                   ? Theme.of(context).textTheme.headlineMedium?.copyWith(
//                       color: hintColor,
//                       fontWeight: FontWeight.w500,
//                       fontSize: isTablet(context) ? 15.sp : 18.sp)
//                   : Theme.of(context).textTheme.labelMedium?.copyWith(
//                       color: customehintColor ?? hintColor,
//                       fontSize: isTablet(context) ? 15.sp : 18.sp,
//                       fontWeight: FontWeight.w500),
//               errorStyle: Theme.of(context)
//                   .textTheme
//                   .bodyMedium
//                   ?.copyWith(color: Colors.red),
//               errorMaxLines: 2,
//               contentPadding:
//                   ((customContentPadding != null) && controller.text.isNotEmpty)
//                       ? customContentPadding
//                       : EdgeInsets.symmetric(
//                           horizontal: 16.w,
//                           vertical: 8.h,
//                         ),
//               focusedBorder: borderStyle ??
//                   OutlineInputBorder(
//                     borderSide: BorderSide(
//                       width: 1,
//                       color: isBorderEnable == true
//                           ? (enabledBorderColor ?? accentColorLight)
//                           : Colors.transparent,
//                     ),
//                     borderRadius: isBorderEnable == true
//                         ? BorderRadius.circular(20)
//                         : border,
//                   ),
//               border: borderStyle ??
//                   OutlineInputBorder(
//                     borderRadius: isBorderEnable == true
//                         ? BorderRadius.circular(20)
//                         : border,
//                     borderSide: BorderSide(
//                       width: 1,
//                       color: isBorderEnable == true
//                           ? (enabledBorderColor ?? accentColorLight)
//                           : Colors.transparent,
//                     ),
//                   ),
//               enabledBorder: borderStyle ??
//                   OutlineInputBorder(
//                     borderRadius: isBorderEnable == true
//                         ? BorderRadius.circular(20)
//                         : border,
//                     borderSide: BorderSide(
//                       width: 1,
//                       color: isBorderEnable == true
//                           ? (enabledBorderColor ?? accentColorLight)
//                           : Colors.transparent,
//                     ),
//                   ),
//               suffixIcon: context
//                       .read<BaseBloc>()
//                       .appLang
//                       .languageCode
//                       .contains('ar')
//                   ? suffixWidget
//                   : context.read<BaseBloc>().appLang.languageCode.contains('en')
//                       ? isCenter == true
//                           ? prefixWidget
//                           : suffixWidget
//                       : suffixWidget,
//               prefixIcon: prefixWidget != null ||
//                       isCenter == true &&
//                           context
//                               .read<BaseBloc>()
//                               .appLang
//                               .languageCode
//                               .contains('en')
//                   ? context.read<BaseBloc>().appLang.languageCode.contains('ar')
//                       ? prefixWidget
//                       : context
//                               .read<BaseBloc>()
//                               .appLang
//                               .languageCode
//                               .contains('en')
//                           ? suffixWidget
//                           : prefixWidget
//                   : prefixWidget,
//             ),
//           ).applyShimmer(enable: enableShimmer ?? false, borderRadius: border),
//         ),
//       ],
//     );
//   }
// }
