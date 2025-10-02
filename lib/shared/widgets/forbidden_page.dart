import 'package:flutter/material.dart';

import '../../app/l10n/l10n.dart';
import '../../app/theme/app_theme.dart';

class ForbiddenPage extends StatelessWidget {
  const ForbiddenPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final spacing = theme.spacing;
    final colors = theme.colors;

    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(spacing.xl),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.lock_outline,
                color: colors.primary,
                size: spacing.xl * 2,
              ),
              SizedBox(height: spacing.lg),
              Text(
                context.l10n.permissionDeniedTitle,
                style: theme.textTheme.headlineSmall,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: spacing.sm),
              Text(
                context.l10n.permissionDeniedDescription,
                style: theme.textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
