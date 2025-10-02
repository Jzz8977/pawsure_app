import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProviderLogger extends ProviderObserver {
  @override
  void didUpdateProvider(ProviderBase<Object?> provider, Object? previousValue, Object? newValue, ProviderContainer container) {
    if (!kDebugMode) {
      return;
    }
    debugPrint('Provider updated: ${provider.name ?? provider.runtimeType}');
  }
}
