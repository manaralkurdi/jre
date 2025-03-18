// lib/routes/app_routes.dart

class AppRoutes {
  // Base routes
  static const String SPLASH = '/';
  static const String HOME = '/home';
  static const String CHANGE_LANGUAGE = '/language';
  static const String BottoBarScreen = '/BottoBarScreen';
  static const String SEARCH = '/SEARCH';
  static const String propertyFilter = '/property-filter';
  static const String categoryDetails = '/category-details';
  static const String categoryList = '/category-list';
  // Authentication routes
  static const String LOGIN = '/login';
  static const String REGISTER = '/register';
  static const String FORGOT_PASSWORD = '/forgot-password';
  static const String VERIFY_OTP = '/verify-otp';

  // User profile routes
  static const String PROFILE = '/profile';
  static const String EDIT_PROFILE = '/profile/edit';

  // Feature routes
  static const String CHAT = '/chat';
  static const String NOTIFICATIONS = '/notifications';
  static const String SETTINGS = '/settings';

  // Content routes
  static const String PROPERTY_DETAILS = '/property/details';
  static const String PROPERTY_LIST = '/property/list';
  static const String PROPERTY_SEARCH = '/property/search';
  static const String PROPERTY_ADD = '/property/add';

  // Settings related routes
  static const String LANGUAGE_SETTINGS = '/settings/language';
  static const String THEME_SETTINGS = '/settings/theme';
  static const String PRIVACY_SETTINGS = '/settings/privacy';

  // Miscellaneous routes
  static const String ABOUT = '/about';
  static const String HELP = '/help';
  static const String TERMS = '/terms';
  static const String PRIVACY_POLICY = '/privacy-policy';
}