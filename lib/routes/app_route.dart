import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jre_app/not_fond_screen.dart' show NotFoundScreen;

import '../ui/home/bloc/home_bloc.dart';
import '../ui/home/bottombar_screen.dart';
import '../ui/home/ui/home_page.dart';
import '../ui/language/ui/language_page.dart';
import '../ui/splash/ui/splash_screen.dart';
import 'app_route_name.dart';

class AppRouter {
  Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.SPLASH:
        return MaterialPageRoute(builder: (_) => SplashScreen());

      case AppRoutes.CHANGE_LANGUAGE:
        return MaterialPageRoute(builder: (_) => LanguageScreen());

      case AppRoutes.BottoBarScreen:
        return MaterialPageRoute(
          builder:
              (_) => BlocProvider<HomeBloc>(
                create: (context) => HomeBloc(),
                child: const BottoBarScreen(),
              ),
        );
      case AppRoutes.HOME:
        return MaterialPageRoute(
          builder:
              (_) => BlocProvider<HomeBloc>(
                create: (context) => HomeBloc(),
                child: const HomeScreen(),
              ),
        );
      //
      // case AppRoutes.LOGIN:
      //   return MaterialPageRoute(
      //     builder: (_) => const LoginScreen(),
      //   );

      default:
        // Handle unknown routes
        return MaterialPageRoute(
          builder: (_) => NotFoundScreen(routeName: settings.name),
        );
    }
  }
}

// Arguments classes for routes that need parameters

// Example of how to navigate with parameters:
/*
  Navigator.of(context).pushNamed(
    AppRoutes.CHAT,
    arguments: ChatScreenArguments(
      chatId: 'chat_123',
      recipientName: 'John Doe',
    ),
  );
*/
