import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app.dart';
import 'env/app_env.dart';
import 'env/app_env_provider.dart';
import '../core/storage/app_storage.dart';
import '../shared/providers/provider_logger.dart';

Future<void> bootstrap({required AppEnv env}) async {
  WidgetsFlutterBinding.ensureInitialized();
  final storage = await AppStorage.initialize();

  runApp(
    ProviderScope(
      overrides: [
        appEnvProvider.overrideWithValue(env),
        appStorageProvider.overrideWithValue(storage),
      ],
      observers: [ProviderLogger()],
      child: const PawsureApp(),
    ),
  );
}
