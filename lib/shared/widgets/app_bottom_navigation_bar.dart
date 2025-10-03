import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../app/theme/app_theme.dart';
import '../../core/auth/user_role_controller.dart';
import '../config/navigation_config.dart';
import '../models/navigation_item.dart';
import 'app_svg_icon.dart';

class AppBottomNavigationBar extends ConsumerWidget {
  const AppBottomNavigationBar({
    super.key,
    required this.currentRoute,
  });

  final String currentRoute;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userRole = ref.watch(userRoleControllerProvider);
    final items = NavigationConfig.getItemsForRole(userRole);
    final currentIndex = _getCurrentIndex(items, currentRoute);
    final theme = Theme.of(context);
    final colors = theme.colors;
    final spacing = theme.spacing;
    final radii = theme.radii;

    return Positioned(
      left: 0,
      right: 0,
      bottom: spacing.md,
      child: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 240),
          height: 64,
          margin: EdgeInsets.symmetric(horizontal: spacing.lg),
          padding: EdgeInsets.all(spacing.xs),
          decoration: BoxDecoration(
            color: colors.onBackground.withValues(alpha: 0.28),
            borderRadius: BorderRadius.circular(radii.lg * 2),
            boxShadow: [
              BoxShadow(
                color: colors.onBackground.withValues(alpha: 0.15),
                blurRadius: 16,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(radii.lg * 2),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(
                  items.length,
                  (index) => _NavigationBarItem(
                    item: items[index],
                    isActive: currentIndex == index,
                    onTap: () => _onItemTapped(context, items[index].route),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  int _getCurrentIndex(List<NavigationItem> items, String route) {
    for (var i = 0; i < items.length; i++) {
      if (route.startsWith(items[i].route)) {
        return i;
      }
    }
    return 0;
  }

  void _onItemTapped(BuildContext context, String route) {
    if (context.canPop()) {
      context.go(route);
    } else {
      context.go(route);
    }
  }
}

class _NavigationBarItem extends StatelessWidget {
  const _NavigationBarItem({
    required this.item,
    required this.isActive,
    required this.onTap,
  });

  final NavigationItem item;
  final bool isActive;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colors;

    final iconPath = isActive ? item.activeIconPath : item.iconPath;

    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: 52,
          height: 52,
          decoration: BoxDecoration(
            color: isActive ? colors.background : Colors.transparent,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: AppSvgIcon(
              assetPath: iconPath,
              width: 28,
              height: 28,
              color: isActive ? colors.primary : colors.background,
            ),
          ),
        ),
      ),
    );
  }
}
