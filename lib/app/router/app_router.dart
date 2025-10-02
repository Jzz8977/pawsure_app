import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/home/presentation/home_page.dart';
import '../../shared/services/permission_service.dart';
import '../../shared/widgets/forbidden_page.dart';
import 'router_notifier.dart';

class AppRoutePath {
  const AppRoutePath._();

  static const String home = '/';
  static const String forbidden = '/forbidden';
}

class AppRouteName {
  const AppRouteName._();

  static const String home = 'home';
  static const String forbidden = 'forbidden';
}

final _rootNavigatorKey = GlobalKey<NavigatorState>();

final _routeAbilities = <String, String>{};

final routerNotifierProvider = Provider<RouterNotifier>((ref) {
  return RouterNotifier(ref);
});

final appRouterProvider = Provider<GoRouter>((ref) {
  final permissionService = ref.watch(permissionServiceProvider);
  final routerNotifier = ref.watch(routerNotifierProvider);

  return GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: AppRoutePath.home,
    refreshListenable: routerNotifier,
    routes: <RouteBase>[
      GoRoute(
        path: AppRoutePath.home,
        name: AppRouteName.home,
        builder: (context, state) => const HomePage(),
      ),
      GoRoute(
        path: AppRoutePath.forbidden,
        name: AppRouteName.forbidden,
        builder: (context, state) => const ForbiddenPage(),
      ),
    ],
    redirect: (context, state) {
      final requiredAbility = _routeAbilities[state.matchedLocation];
      if (requiredAbility == null) {
        return null;
      }
      final canAccess = permissionService.can(requiredAbility);
      if (!canAccess && state.matchedLocation != AppRoutePath.forbidden) {
        return AppRoutePath.forbidden;
      }
      if (canAccess && state.matchedLocation == AppRoutePath.forbidden) {
        return AppRoutePath.home;
      }
      return null;
    },
  );
});
