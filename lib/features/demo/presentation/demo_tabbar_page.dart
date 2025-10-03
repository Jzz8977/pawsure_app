import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/l10n/l10n.dart';
import '../../../app/theme/app_theme.dart';
import '../../../core/auth/user_role.dart';
import '../../../core/auth/user_role_controller.dart';

class DemoTabBarPage extends ConsumerWidget {
  const DemoTabBarPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final spacing = theme.spacing;
    final colors = theme.colors;
    final currentRole = ref.watch(userRoleControllerProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('TabBar 演示'),
        backgroundColor: colors.primary,
        foregroundColor: colors.onPrimary,
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(spacing.xl),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.pets,
                size: 80,
                color: colors.primary,
              ),
              SizedBox(height: spacing.xl),
              Text(
                '欢迎使用 Pawsure',
                style: theme.textTheme.headlineMedium?.copyWith(
                  color: colors.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: spacing.lg),
              Text(
                '当前角色：${currentRole == UserRole.user ? "用户" : "服务者"}',
                style: theme.textTheme.titleLarge,
              ),
              SizedBox(height: spacing.xl),
              Card(
                child: Padding(
                  padding: EdgeInsets.all(spacing.lg),
                  child: Column(
                    children: [
                      Text(
                        '底部导航栏已激活！',
                        style: theme.textTheme.titleMedium,
                      ),
                      SizedBox(height: spacing.md),
                      Text(
                        '点击底部的导航图标可以切换不同页面',
                        style: theme.textTheme.bodyMedium,
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: spacing.md),
                      Text(
                        '在"我的"页面可以切换角色',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: colors.primary,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: spacing.xl),
              ElevatedButton.icon(
                onPressed: () {
                  ref.read(userRoleControllerProvider.notifier).switchRole(
                        currentRole == UserRole.user
                            ? UserRole.provider
                            : UserRole.user,
                      );
                },
                icon: const Icon(Icons.swap_horiz),
                label: Text(context.l10n.switchRole),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(
                    horizontal: spacing.xl,
                    vertical: spacing.md,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
