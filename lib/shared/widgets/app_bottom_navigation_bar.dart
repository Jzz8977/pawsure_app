import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../app/l10n/l10n.dart';
import '../../app/theme/app_theme.dart';
import '../../core/auth/user_role_controller.dart';
import '../../l10n/app_localizations.dart';
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

    return Container(
      decoration: BoxDecoration(
        color: colors.background,
        boxShadow: [
          BoxShadow(
            color: colors.onBackground.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: SizedBox(
          height: 56,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
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
    final spacing = theme.spacing;
    final l10n = context.l10n;

    final label = _getLabel(l10n, item.labelKey);
    final iconPath = isActive ? item.activeIconPath : item.iconPath;
    final color = isActive ? colors.primary : colors.onBackground.withValues(alpha: 0.6);

    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AppSvgIcon(
              assetPath: iconPath,
              width: 24,
              height: 24,
              color: color,
            ),
            SizedBox(height: spacing.xs),
            Text(
              label,
              style: theme.textTheme.labelSmall?.copyWith(
                color: color,
                fontSize: 12,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  String _getLabel(AppLocalizations l10n, String key) {
    switch (key) {
      case 'navHome':
        return l10n.navHome;
      case 'navPet':
        return l10n.navPet;
      case 'navMy':
        return l10n.navMy;
      case 'navProviderHome':
        return l10n.navProviderHome;
      case 'navOrder':
        return l10n.navOrder;
      default:
        return key;
    }
  }
}
