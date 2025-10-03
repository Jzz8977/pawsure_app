import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/l10n/l10n.dart';
import '../../../app/theme/app_theme.dart';
import '../../../core/auth/user_role.dart';
import '../../../core/auth/user_role_controller.dart';

class ProviderMyPage extends ConsumerWidget {
  const ProviderMyPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final spacing = theme.spacing;
    final currentRole = ref.watch(userRoleControllerProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.myTitle),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(spacing.lg),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                context.l10n.myWelcome,
                style: theme.textTheme.headlineSmall,
              ),
              SizedBox(height: spacing.xl),
              Text(
                context.l10n.currentRole(
                  currentRole == UserRole.user
                      ? context.l10n.roleUser
                      : context.l10n.roleProvider,
                ),
                style: theme.textTheme.bodyLarge,
              ),
              SizedBox(height: spacing.xl),
              ElevatedButton(
                onPressed: () {
                  ref.read(userRoleControllerProvider.notifier).switchRole(
                        currentRole == UserRole.user
                            ? UserRole.provider
                            : UserRole.user,
                      );
                },
                child: Text(context.l10n.switchRole),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
