import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jre_app/routes/app_route.dart';
import 'package:jre_app/routes/app_route_name.dart';
import 'package:jre_app/theme/bloc/theme_bloc/theme_bloc.dart';
import 'package:jre_app/translation/translation.dart';
import 'package:jre_app/ui/language/bloc/language_bloc.dart';
export 'package:flutter_screenutil/flutter_screenutil.dart';

class MyApp extends StatelessWidget {
  final AppRouter _appRouter = AppRouter();

  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ThemeBloc>(create: (context) => ThemeBloc()),
        BlocProvider<LanguageBloc>(create: (context) => LanguageBloc()), // Add Language BLoC

        //   BlocProvider<AuthBloc>(create: (context) => AuthBloc()),
        // Add other global BLoCs here
      ],
      child: MultiBlocBuilder<ThemeBloc, LanguageBloc,ThemeState,LanguageState>(
        builder: (context, themeState, languageState) {
          return ScreenUtilInit(
            designSize: const Size(375, 800),
            minTextAdapt: true,
            splitScreenMode: true,
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              themeMode: themeState.themeMode,
              theme: ThemeData.light(useMaterial3: false).copyWith(
                primaryColor: const Color(0xff3D5BF6),
                splashColor: Colors.grey[50],
                hoverColor: Colors.transparent,
                highlightColor: Colors.transparent,
                dividerColor: Colors.transparent,
                     //     fontFamily: "Gilroy",
              ),
              onGenerateRoute: _appRouter.onGenerateRoute,
              initialRoute: AppRoutes.CHANGE_LANGUAGE,

              supportedLocales: const [
                Locale('en', 'US'),
                Locale('ar', 'SA'),
              ],
              localizationsDelegates:  [
                AppLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              locale: Locale(languageState.selectedLanguage?.code ?? 'en'),
            ),
          );
        },
      ),
    );

  }
}
class MultiBlocBuilder<B1 extends StateStreamable<S1>, B2 extends StateStreamable<S2>, S1, S2> extends StatelessWidget {
  final Widget Function(BuildContext context, S1 state1, S2 state2) builder;

  const MultiBlocBuilder({
    Key? key,
    required this.builder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<B1, S1>(
      builder: (context, state1) {
        return BlocBuilder<B2, S2>(
          builder: (context, state2) {
            return builder(context, state1, state2);
          },
        );
      },
    );
  }
}
