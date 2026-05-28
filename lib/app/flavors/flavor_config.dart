enum Flavor {
  dev,
  prod,
}

class FlavorConfig {
  final Flavor flavor;
  final String baseUrl;

  static late FlavorConfig instance;

  FlavorConfig({
    required this.flavor,
    required this.baseUrl,
  }) {
    instance = this;
  }

  static bool get isDev {
    return instance.flavor == Flavor.dev;
  }

  static bool get isProd {
    return instance.flavor == Flavor.prod;
  }
}
