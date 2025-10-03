import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/l10n/l10n.dart';
import '../../../app/theme/app_theme.dart';
import '../../../shared/widgets/app_async_value.dart';
import '../providers/home_controller.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homeState = ref.watch(homeControllerProvider);
    final theme = Theme.of(context);
    final spacing = theme.spacing;
    final colors = theme.colors;

    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.homeTitle),
      ),
      body: RefreshIndicator(
        onRefresh: () => ref.read(homeControllerProvider.notifier).refresh(),
        child: ListView(
          padding: EdgeInsets.all(spacing.lg),
          children: [
            AppAsyncValueWidget<HomeState>(
              value: homeState,
              dataBuilder: (data) {
                return Card(
                  child: Padding(
                    padding: EdgeInsets.all(spacing.lg),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          context.l10n.homeWelcomeTitle(data.environmentName),
                          style: theme.textTheme.headlineSmall,
                        ),
                        SizedBox(height: spacing.sm),
                        Text(
                          context.l10n.homeWelcomeDescription,
                          style: theme.textTheme.bodyMedium,
                        ),
                        SizedBox(height: spacing.md),
                        Container(
                          padding: EdgeInsets.all(spacing.md),
                          decoration: BoxDecoration(
                            color: colors.primary.withValues(alpha: 0.08),
                            borderRadius: BorderRadius.circular(theme.radii.md),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                context.l10n.currentBaseUrlLabel,
                                style: theme.textTheme.titleSmall,
                              ),
                              SizedBox(height: spacing.xs),
                              Text(
                                data.baseUrl,
                                style: theme.textTheme.bodyMedium,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
