import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/home/presentation/home_page.dart';
import '../../features/main/presentation/main_container_page.dart';
import '../../features/my/presentation/my_page.dart';
import '../../features/pet/presentation/pet_page.dart';
import '../../features/provider/presentation/order_page.dart';
import '../../features/provider/presentation/provider_home_page.dart';
import '../../features/provider/presentation/provider_my_page.dart';
import '../../shared/services/permission_service.dart';
import '../../shared/widgets/forbidden_page.dart';
import 'router_notifier.dart';

class AppRoutePath {
  const AppRoutePath._();

  static const String home = '/home';
  static const String pet = '/pet';
  static const String my = '/my';
  static const String providerHome = '/provider/home';
  static const String providerOrder = '/provider/order';
  static const String providerMy = '/provider/my';
  static const String forbidden = '/forbidden';
}

class AppRouteName {
  const AppRouteName._();

  static const String home = 'home';
  static const String pet = 'pet';
  static const String my = 'my';
  static const String providerHome = 'providerHome';
  static const String providerOrder = 'providerOrder';
  static const String providerMy = 'providerMy';
  static const String forbidden = 'forbidden';
}

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();

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
      ShellRoute(
        navigatorKey: _shellNavigatorKey,
        builder: (context, state, child) {
          return MainContainerPage(
            currentRoute: state.uri.path,
            child: child,
          );
        },
        routes: [
          GoRoute(
            path: AppRoutePath.home,
            name: AppRouteName.home,
            pageBuilder: (context, state) => NoTransitionPage(
              key: state.pageKey,
              child: const HomePage(),
            ),
          ),
          GoRoute(
            path: AppRoutePath.pet,
            name: AppRouteName.pet,
            pageBuilder: (context, state) => NoTransitionPage(
              key: state.pageKey,
              child: const PetPage(),
            ),
          ),
          GoRoute(
            path: AppRoutePath.my,
            name: AppRouteName.my,
            pageBuilder: (context, state) => NoTransitionPage(
              key: state.pageKey,
              child: const MyPage(),
            ),
          ),
          GoRoute(
            path: AppRoutePath.providerHome,
            name: AppRouteName.providerHome,
            pageBuilder: (context, state) => NoTransitionPage(
              key: state.pageKey,
              child: const ProviderHomePage(),
            ),
          ),
          GoRoute(
            path: AppRoutePath.providerOrder,
            name: AppRouteName.providerOrder,
            pageBuilder: (context, state) => NoTransitionPage(
              key: state.pageKey,
              child: const OrderPage(),
            ),
          ),
          GoRoute(
            path: AppRoutePath.providerMy,
            name: AppRouteName.providerMy,
            pageBuilder: (context, state) => NoTransitionPage(
              key: state.pageKey,
              child: const ProviderMyPage(),
            ),
          ),
        ],
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
