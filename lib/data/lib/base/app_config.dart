class AppConfig {
  Future<String> get baseUrl async => 'https://jre.blueboxjo.net/';

  Future<String> get imageUrl async {
    final base = await baseUrl;
    return '$base/upload/';
  }
}