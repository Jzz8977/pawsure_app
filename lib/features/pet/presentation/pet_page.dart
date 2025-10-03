import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/l10n/l10n.dart';
import '../../../app/theme/app_theme.dart';

class PetPage extends ConsumerWidget {
  const PetPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final spacing = theme.spacing;

    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.petTitle),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(spacing.lg),
          child: Text(
            context.l10n.petWelcome,
            style: theme.textTheme.headlineSmall,
          ),
        ),
      ),
    );
  }
}
