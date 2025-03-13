import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import 'dart:ui';

import '../theme/bloc/theme_bloc/theme_bloc.dart' show BorderRadius, BoxDecoration, BuildContext, ScaffoldMessenger, SnackBar;

mixin UiUtil {
  final grayColor = const Color(0xFFFBFBFB);
  final gryColorLight = const Color(0xFFF2F2F2);
  final primaryColor = const Color(0xFF0478A7);
  final secondColor = const Color(0xFF014965);
  final statusNewColor = const Color(0xFFE3F6F6);
  final statusRejectedColor = const Color(0xFFFEF0EE);
  final statusRegisteredColor = const Color(0xFFDCF6EC);

  final primaryColorMid = const Color(0xFF025373);
  final primaryColorDark = const Color(0xFF014965);
  final primaryColorLight = const Color(0xFF0478A7);
  final primaryColorLightGradient = const Color(0xFF022F41);
  final primaryColorLightest = const Color(0x1F0478A7);
  final blueLiteColor = const Color(0xFFEBF3FA);

  final accentColor = const Color(0xFFBE6D29);
  final accentColorMid = const Color(0xFFD78F28);

  final accentColorLight = const Color(0xE0FFC163);
  final accentColorLightForm = const Color(0xFFF7E8CC);
  final orange = const Color(0xFFFFC163);
  final orangeLight = const Color(0xFFFFF9EF);
  final accentColorLightest = const Color(0x40FFC163);

  final accentColorLight2 = const Color(0xFFFFC063);
  final borderColor = const Color(0xFFD2D6DC);
  final whiteColor = const Color(0xFFFFFFFF);
  final borderColorGrey = const Color(0xFFF8F9FB);
  final textColorGrey = const Color(0xFFABABBB);
  final textColorGreyRate = const Color(0xFFAEAEB0);
  final indicatorColor = const Color(0xFFEBECF5);
  final textColorGreyBorder = const Color(0xFFF2F2F2);
  final dividerBorder = const Color(0xFFE2E2E2);
  final fillTextField = const Color(0xFFA5ABB4);
  final fillTextFieldServices = const Color(0xFF79878D);
  final hintColor = const Color(0xFFA5ABB4);
  final dividerColor = const Color(0xFFE2E2E2);
  final colorTextGrey = const Color(0xFFAEB1B7);
  final colorButtonGrey = const Color(0xFF9BA4A1);
  final colorButtonGreyFavourite = const Color(0xFFEEEFF0);
  final colorButtonGreyFavouriteNew = const Color(0xFFF4F7F8);
  final colorButtonCall = const Color(0xFFE7E7E7);

  final shadowColor = const Color(0xFF055E5D1A);
  final redColor = const Color(0xFFE66767);
  final redColorLightest = const Color(0x1FFF7474);
  final greenColor = const Color(0xFF59B58D);
  final greenColorMid = const Color(0xFF2E9A5C);
  final switchColor = const Color(0xFFCBCED1);
  final inActiveToggleColor = const Color(0X1ABDC0C2);
  final inactiveNavBarColor = const Color(0XFFB4B8BF);
  final passwordValidationColor = const Color(0XFFA5AAB2);
  final padding_16 = EdgeInsets.symmetric(
    horizontal: 16.w,
    vertical: 30.h,
  );
  final bottomSheetDecoration = const BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.only(
      topLeft: Radius.circular(20),
      topRight: Radius.circular(20),
    ),
  );
  final BorderRadius border = const BorderRadius.only(
      topRight: Radius.circular(15),
      topLeft: Radius.circular(15),
      bottomRight: Radius.circular(15),
      bottomLeft: Radius.circular(15));

  void viewToast({
    required BuildContext context,
    required String msg,
    bool? isError,
    int? maxLines,
    bool? needPop,
  }) async {
    ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          backgroundColor: isError ?? false ? Colors.red : Colors.green,
          behavior: SnackBarBehavior.floating,
          showCloseIcon: false,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          margin:
          EdgeInsetsDirectional.only(bottom: .80.sh, start: 8.w, end: 8.w),
          padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
          dismissDirection: DismissDirection.horizontal,
          // closeIconColor: Colors.white,
          content: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                isError ?? false ? Icons.error : Icons.check_circle,
                color: Colors.white,
              ),
              5.horizontalSpace,
              Expanded(
                child: AutoSizeText(
                  msg,
                  maxLines: maxLines ?? 1,
                  overflow: TextOverflow.visible,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      height: 2),
                ),
              ),
            ],
          ),
          duration: const Duration(seconds: 2),
        ),
      );
  }

  // /// show toast if apiRequest success or failed
  // void showToast(
  //     {required BuildContext context,
  //       required String msg,
  //       bool? isError,
  //       bool? needPop,
  //       int? maxLines}) {
  //   if (msg == 'NO_INTERNET_CONNECTION') {
  //     final String _lang = context.read<BaseBloc>().appLang.languageCode;
  //     viewToast(
  //         maxLines: maxLines,
  //         context: context,
  //         msg: _lang.contains('ar')
  //             ? 'تفقد اتصالك بالانترنت ثم حاول مجددا'
  //             : _lang.contains('en')
  //             ? 'Please check your internet connection and try again'
  //             : 'براہ کرم اپنا انٹرنیٹ کنکشن '
  //             'چیک کریں اور دوبارہ کوشش کریں۔',
  //         isError: isError,
  //         needPop: needPop);
  //   } else {
  //     viewToast(
  //       context: context,
  //       msg: msg,
  //       isError: isError,
  //       needPop: needPop,
  //       maxLines: maxLines,
  //     );
  //   }
  // }

  /**
   * Convert all arabic number in [input] to english.
   */
  String convertArabicNumberToEnglish(String input) {
    const english = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];
    const arabic = ['٠', '١', '٢', '٣', '٤', '٥', '٦', '٧', '٨', '٩'];
    for (int i = 0; i < english.length; i++) {
      input = input.replaceAll(arabic[i], english[i]);
    }
    return input;
  }

  /**
   * Show [widget] in Bottom Sheet Modal in the same [context]
   */
  void showNstarBottomSheet({
    required BuildContext context,
    Widget? widget,
    BlocProvider? bloc,
    bool? isFillPage,
    bool? isDismissible,
    bool? enableDrag,
  }) {
    if (Navigator.of(context).mounted) {
      showModalBottomSheet(
          context: context,
          useRootNavigator: true,
          enableDrag: enableDrag ?? true,
          isDismissible: isDismissible ?? true,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(35.0),
                  topRight: Radius.circular(35.0))),
          isScrollControlled: isFillPage ?? true,
          backgroundColor: Colors.white,
          builder: (BuildContext context) {
            return widget ?? bloc ?? Container();
          });
    } else {
      debugPrint('Navigator context is not mounted');
    }
  }

  bool isTablet(BuildContext context) {
    final smallestDimension = ScreenUtil().screenWidth;
    return smallestDimension > 600;
  }

  double getTextSize(double sysVar, double size) {
    final calc = size / 10;
    return sysVar * calc;
  }

  final bool searchVisibility = false;
  final TextEditingController searchController = TextEditingController();

  /**
      /// This function will return custom AppBar
      /// function parameters:
      /// [title] : The AppBAr title
      /// [hintSearch] : The hint search
      /// [titleSearch] : The title search
      /// [hasBackIcon] : Check if the AppBar has a back button
      /// [hasSearch] : Check if the AppBar has a Search button
      /// [backgroundAppBarColor] : Change background AppBar Color
      /// [appBarTitleColor] : Change AppBar Title Color
      /// [titleSearchColor] : Change  AppBar Title Search Color
      /// [withData] : if title has Extra Data from Fleet Configuration
      /// [isTablet] : Check if platform is tablet
      /// [onSearchPressed] : if There is any function Search some thing
      /// when press button
      /// [onBackPressed] : if There is any function do some thing
      /// when press button to back page
      /// all of the parameters Nullable because we have more than one design
      /// for the AppBar, so some parameters will have null value in each case
      /// (except the context because we need the context in every case)
   */



  /**
   * this function will show Image from URL with place holder on error
   * and shimmer on loading
   * [url] of Image from Network
   * [width] and [height] size of your Image
   */
  // Widget getImage({
  //   required String url,
  //   required double width,
  //   required double height,
  //   BoxFit? fit,
  //   bool? isLoading,
  // }) {
  //   try {
  //     if (url.contains('svg')) {
  //       return SvgPicture.network(
  //         url,
  //         width: width,
  //         height: height,
  //         fit: fit ?? BoxFit.contain,
  //       );
  //     } else {
  //       return CachedNetworkImage(
  //         imageUrl: url,
  //         width: width,
  //         height: height,
  //         fit: fit ?? BoxFit.contain,
  //         placeholder: (context, url) => Theme(
  //             data: Theme.of(context).copyWith(
  //                 colorScheme: ColorScheme.fromSwatch()
  //                     .copyWith(secondary: Colors.grey)),
  //             child: Shimmer.fromColors(
  //               baseColor: Colors.grey[300]!,
  //               highlightColor: Colors.grey[100]!,
  //               period: const Duration(milliseconds: 800),
  //               child: Image(
  //                 width: width,
  //                 height: height,
  //                 fit: fit ?? BoxFit.cover,
  //                 image: const AssetImage('assets/images/n_star_logo.png'),
  //               ),
  //             )),
  //         errorWidget: (context, url, error) {
  //           print('Error loading image from $url: $error');
  //           if (url.contains('svg')) {
  //             return SvgPicture.asset(
  //               'assets/icons/dot_icon.svg',
  //               width: width,
  //               height: height,
  //               fit: fit ?? BoxFit.contain,
  //             );
  //           } else {
  //             return Image(
  //               width: width,
  //               height: height,
  //               color: accentColor,
  //               fit: fit ?? BoxFit.cover,
  //               image: const AssetImage('assets/images/n_star_logo.png'),
  //             );
  //           }
  //         },
  //       ).applyShimmer(
  //         enable: isLoading ?? false,
  //         width: width,
  //         height: height,
  //       );
  //     }
  //   } catch (e) {
  //     return Image(
  //       width: width,
  //       height: height,
  //       fit: fit ?? BoxFit.cover,
  //       image: const AssetImage('assets/images/n_star_logo.png'),
  //     );
  //   }
  // }

  int getImageSize({required String imagePath}) {
    int size = 0;
    final File image = File(imagePath);
    size = image.readAsBytesSync().lengthInBytes;
    size = size ~/ 1024;
    print('selected image size is :' + size.toString());
    return size;
  }



  // void navigate({
  //   required BuildContext context,
  //   required Widget page,
  //   bool? isReplacement,
  //   bool? clearPagesStack,
  //   bool? isFade,
  //   bool? isFromBottom,
  //   Duration? duration,
  // }) {
  //   if (isReplacement ?? false) {
  //     Navigator.pushReplacement(
  //       context,
  //       PageTransition(
  //         duration: duration ?? const Duration(milliseconds: 400),
  //         type: getTransitionType(
  //             context: context, isFade: isFade, isFromBottom: isFromBottom),
  //         child: page,
  //       ),
  //     );
  //   } else if (clearPagesStack ?? false) {
  //     Navigator.pushAndRemoveUntil(
  //       context,
  //       PageTransition(
  //         duration: duration ?? const Duration(milliseconds: 400),
  //         type: getTransitionType(
  //             context: context, isFade: isFade, isFromBottom: isFromBottom),
  //         child: page,
  //       ),
  //       (route) => false,
  //     );
  //   } else {
  //     Navigator.push(
  //       context,
  //       PageTransition(
  //         curve: Curves.elasticIn,
  //         duration: duration ?? const Duration(milliseconds: 400),
  //         type: getTransitionType(
  //             context: context, isFade: isFade, isFromBottom: isFromBottom),
  //         child: page,
  //       ),
  //     );
  //   }
  // }

  // PageTransitionType getTransitionType(
  //     {required BuildContext context, bool? isFade, bool? isFromBottom}) {
  //   return (isFade ?? false)
  //       ? PageTransitionType.fade
  //       : (isFromBottom ?? false)
  //           ? PageTransitionType.bottomToTop
  //           : context.read<BaseBloc>().appLang.languageCode.contains('ar')
  //               ? PageTransitionType.leftToRight
  //               : PageTransitionType.rightToLeft;
  // }

  bool isKeyboardOpen(BuildContext context) {
    return MediaQuery.of(context).viewInsets.bottom != 0;
  }

  // Future<bool> hasGalleryPermissions() async {
  //   if (Platform.isAndroid) {
  //     // Check storage permission for android
  //     final AndroidDeviceInfo androidInfo =
  //     await DeviceInfoPlugin().androidInfo;
  //     final sdk = androidInfo.version.sdkInt;
  //     final PermissionStatus cameraPermission = sdk <= 32
  //         ? await Permission.storage.status
  //         : await Permission.photos.status;
  //
  //     if (cameraPermission.isGranted) {
  //       return true;
  //     } else {
  //       // If permissions are denied or restricted, request them
  //       final PermissionStatus statuses = sdk <= 32
  //           ? await Permission.storage.request()
  //           : await Permission.photos.request();
  //
  //       // Check if both permissions are granted after requesting
  //       if (statuses.isGranted) {
  //         return true;
  //       } else if (statuses.isPermanentlyDenied) {
  //         await openAppSettings();
  //         return false;
  //       } else {
  //         return false;
  //       }
  //     }
  //   } else {
  //     // Check photos permission for IOS
  //     final PermissionStatus cameraPermission = await Permission.photos.status;
  //
  //     if (cameraPermission.isGranted) {
  //       return true;
  //     } else {
  //       // If permissions are denied or restricted, request them
  //       final PermissionStatus statuses = await Permission.photos.request();
  //
  //       // Check if both permissions are granted after requesting
  //       if (statuses.isGranted) {
  //         return true;
  //       } else if (statuses.isPermanentlyDenied) {
  //         await openAppSettings();
  //         return false;
  //       } else {
  //         return false;
  //       }
  //     }
  //   }
  // }
  //
  // Future<bool> hasCameraPermissions() async {
  //   if (Platform.isAndroid) {
  //     // Check storage permission for android
  //     final PermissionStatus cameraPermission = await Permission.camera.status;
  //
  //     if (cameraPermission.isGranted) {
  //       return true;
  //     } else {
  //       // If permissions are denied or restricted, request them
  //       final PermissionStatus statuses = await Permission.camera.request();
  //
  //       // Check if both permissions are granted after requesting
  //       if (statuses.isGranted) {
  //         return true;
  //       } else if (statuses.isPermanentlyDenied) {
  //         await openAppSettings();
  //         return false;
  //       } else {
  //         return false;
  //       }
  //     }
  //   } else {
  //     // Check photos permission for IOS
  //     final PermissionStatus cameraPermission = await Permission.camera.status;
  //
  //     if (cameraPermission.isGranted) {
  //       return true;
  //     } else {
  //       // If permissions are denied or restricted, request them
  //       final PermissionStatus statuses = await Permission.camera.request();
  //
  //       // Check if both permissions are granted after requesting
  //       if (statuses.isGranted) {
  //         return true;
  //       } else if (statuses.isPermanentlyDenied) {
  //         await openAppSettings();
  //         return false;
  //       } else {
  //         return false;
  //       }
  //     }
  //   }
  // }
}
