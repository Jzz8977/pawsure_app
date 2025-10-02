import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app/l10n/l10n.dart';
import '../../app/theme/app_theme.dart';

class AppAsyncValueWidget<T> extends StatelessWidget {
  const AppAsyncValueWidget({
    super.key,
    required this.value,
    required this.dataBuilder,
    this.loading,
    this.errorBuilder,
  });

  final AsyncValue<T> value;
  final Widget Function(T data) dataBuilder;
  final Widget? loading;
  final Widget Function(Object error, StackTrace stackTrace)? errorBuilder;

  @override
  Widget build(BuildContext context) {
    return value.when(
      data: dataBuilder,
      loading: () => loading ?? _DefaultLoading(spacing: Theme.of(context).spacing),
      error: (error, stackTrace) {
        if (errorBuilder != null) {
          return errorBuilder!(error, stackTrace);
        }
        return _DefaultError(error: error, stackTrace: stackTrace);
      },
    );
  }
}

class _DefaultLoading extends StatelessWidget {
  const _DefaultLoading({required this.spacing});

  final AppSpacingTokens spacing;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(spacing.lg),
      child: const Center(child: CircularProgressIndicator()),
    );
  }
}

class _DefaultError extends StatelessWidget {
  const _DefaultError({required Object error, required StackTrace stackTrace})
      : _error = error,
        _stackTrace = stackTrace;

  final Object _error;
  final StackTrace _stackTrace;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final spacing = theme.spacing;

    return Padding(
      padding: EdgeInsets.all(spacing.lg),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            context.l10n.genericErrorTitle,
            style: theme.textTheme.titleMedium,
          ),
          SizedBox(height: spacing.xs),
          Text(
            context.l10n.genericErrorDescription,
            style: theme.textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}
