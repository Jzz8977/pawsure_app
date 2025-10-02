import 'package:flutter/foundation.dart';

enum AppFlavor { dev, stg, prod }

class AppEnv {
  const AppEnv({
    required this.flavor,
    required this.baseUrl,
    this.enableNetworkLogs = false,
    this.enableCrashReporting = false,
  });

  final AppFlavor flavor;
  final String baseUrl;
  final bool enableNetworkLogs;
  final bool enableCrashReporting;

  String get name => flavor.name;

  static AppEnv fromFlavor(AppFlavor flavor) {
    switch (flavor) {
      case AppFlavor.dev:
        return AppEnv(
          flavor: flavor,
          baseUrl: 'https://dev-api.pawsure.local',
          enableNetworkLogs: kDebugMode,
        );
      case AppFlavor.stg:
        return AppEnv(
          flavor: flavor,
          baseUrl: 'https://stg-api.pawsure.local',
          enableNetworkLogs: true,
          enableCrashReporting: true,
        );
      case AppFlavor.prod:
        return AppEnv(
          flavor: flavor,
          baseUrl: 'https://api.pawsure.com',
          enableCrashReporting: true,
        );
    }
  }

  static AppEnv fromName(String value) {
    final normalized = value.toLowerCase().trim();
    switch (normalized) {
      case 'stg':
      case 'stage':
      case 'staging':
        return fromFlavor(AppFlavor.stg);
      case 'prod':
      case 'production':
        return fromFlavor(AppFlavor.prod);
      case 'dev':
      default:
        return fromFlavor(AppFlavor.dev);
    }
  }

  AppEnv copyWith({
    AppFlavor? flavor,
    String? baseUrl,
    bool? enableNetworkLogs,
    bool? enableCrashReporting,
  }) {
    return AppEnv(
      flavor: flavor ?? this.flavor,
      baseUrl: baseUrl ?? this.baseUrl,
      enableNetworkLogs: enableNetworkLogs ?? this.enableNetworkLogs,
      enableCrashReporting: enableCrashReporting ?? this.enableCrashReporting,
    );
  }
}
