import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pawsure_app/l10n/app_localizations.dart';

import 'env/app_env_provider.dart';
import 'l10n/l10n.dart';
import 'router/app_router.dart';
import 'theme/app_theme.dart';

class PawsureApp extends ConsumerWidget {
  const PawsureApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final env = ref.watch(appEnvProvider);
    final router = ref.watch(appRouterProvider);

    return MaterialApp.router(
      routerConfig: router,
      debugShowCheckedModeBanner: false,
      onGenerateTitle: (context) => context.l10n.appTitle(env.name),
      theme: AppTheme.light(env),
      localeResolutionCallback: L10n.localeResolution,
      supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
    );
  }
}
