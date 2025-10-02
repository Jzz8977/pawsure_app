import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/env/app_env_provider.dart';

class HomeState {
  const HomeState({
    required this.environmentName,
    required this.baseUrl,
  });

  final String environmentName;
  final String baseUrl;
}

class HomeController extends AutoDisposeAsyncNotifier<HomeState> {
  @override
  Future<HomeState> build() async {
    final env = ref.watch(appEnvProvider);
    return HomeState(
      environmentName: env.name,
      baseUrl: env.baseUrl,
    );
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    final env = ref.read(appEnvProvider);
    state = AsyncValue.data(
      HomeState(
        environmentName: env.name,
        baseUrl: env.baseUrl,
      ),
    );
  }
}

final homeControllerProvider = AutoDisposeAsyncNotifierProvider<HomeController, HomeState>(HomeController.new);
