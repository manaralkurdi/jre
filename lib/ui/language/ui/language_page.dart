// lib/language/screens/language_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jre_app/utils/Colors.dart';

import '../../../base/component/app_custom_text.dart';
import '../../../base/component/button_custome.dart';
import '../../../routes/app_route_name.dart';
import '../../../translation/translation.dart';
import '../bloc/language_bloc.dart';

class LanguageScreen extends StatelessWidget {
  const LanguageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context);

    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: BlocBuilder<LanguageBloc, LanguageState>(
        builder: (context, state) {
          if (state.status == LanguageStatus.initial) {
            return const Center(child: CircularProgressIndicator());
          }

          final languages = state.languages ?? [];
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 26.0, horizontal: 12),
            child: Column(
              children: [
                30.verticalSpace,
                AppCustomText(
                  titleText: 'CHOOSE_LANG',
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                12.verticalSpace,
                AppCustomText(
                  titleText: 'DESC_LANG',
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                30.verticalSpace,
                Image.asset("assets/images/lang.png", height: 300,fit: BoxFit.contain,),
                30.verticalSpace,
                Expanded(
                  // Added Expanded widget to give ListView a defined height
                  child: ListView.builder(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 8.h,
                    ),
                    itemCount: languages.length,
                    itemBuilder: (context, index) {
                      final language = languages[index];
                      final isSelected =
                          language.code == state.selectedLanguage?.code;

                      // Get translated language name
                      String languageName =
                          language.code == 'en'
                              ? appLocalizations.translate('english')
                              : appLocalizations.translate('arabic');

                      return Container(
                        margin: EdgeInsets.only(bottom: 8.h),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12.r),
                          border:
                              isSelected
                                  ? Border.all(
                                    color: Colors.green[700]!,
                                    width: 2.w,
                                  )
                                  : null,
                        ),
                        child: ListTile(
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 16.w,
                            vertical: 8.h,
                          ),
                          leading: Container(
                            width: 36.w,
                            height: 36.h,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                image: AssetImage(language.flagImage),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          title: AppCustomText(
                            titleText: languageName,
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          onTap: () {
                            context.read<LanguageBloc>().add(
                              LanguageSelected(language.code),
                            );
                          },
                        ),
                      );
                    },
                  ),
                ),
                ElevatedButtonApp(
                  onPresses: () {
                    context.read<LanguageBloc>().add(
                      LanguageSelected(state.selectedLanguage?.code ?? ''),
                    );
                    Navigator.pushNamed(context, AppRoutes.BottoBarScreen);
                  },
                  textButton: 'SAVE',backgroundColor: primaryColor,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
