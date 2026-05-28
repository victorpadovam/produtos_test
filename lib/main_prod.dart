import 'package:flutter/material.dart';

import 'app/app.dart';
import 'app/di/injection.dart';
import 'app/flavors/flavor_config.dart';
import 'core/storage/hive_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  FlavorConfig(
    flavor: Flavor.dev,
    baseUrl: 'https://fakestoreapi.com',
  );

  await configureDependencies();

  await getIt<HiveService>().init();

  runApp(const App());
}
