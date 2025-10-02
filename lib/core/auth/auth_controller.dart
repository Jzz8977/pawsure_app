import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../storage/app_storage.dart';
import '../../shared/services/permission_service.dart';
import 'auth_state.dart';

class AuthController extends AsyncNotifier<AuthState> {
  static const _tokenKey = 'auth.token';
  static const _abilitiesKey = 'auth.abilities';

  @override
  Future<AuthState> build() async {
    final storage = ref.read(appStorageProvider);
    final token = await storage.readSecure(_tokenKey);
    final abilities = storage.readJson<Set<String>>(
          _abilitiesKey,
          (data) {
            if (data is List) {
              return data.map((dynamic ability) => ability.toString()).toSet();
            }
            return <String>{};
          },
        ) ??
        const <String>{};

    if (token == null || token.isEmpty) {
      ref.read(permissionServiceProvider).clear();
      return const AuthState.unauthenticated();
    }

    ref.read(permissionServiceProvider).replaceAbilities(abilities);
    return AuthState(accessToken: token, abilities: abilities);
  }

  Future<void> signIn({
    required String accessToken,
    Set<String> abilities = const <String>{},
  }) async {
    final storage = ref.read(appStorageProvider);
    await storage.writeSecure(_tokenKey, accessToken);
    await storage.writeJson(_abilitiesKey, abilities.toList());
    ref.read(permissionServiceProvider).replaceAbilities(abilities);
    state = AsyncValue.data(AuthState(accessToken: accessToken, abilities: abilities));
  }

  Future<void> updateAbilities(Set<String> abilities) async {
    final storage = ref.read(appStorageProvider);
    await storage.writeJson(_abilitiesKey, abilities.toList());
    final current = state.maybeWhen(
      data: (data) => data,
      orElse: () => const AuthState.unauthenticated(),
    );
    final updated = current.copyWith(abilities: abilities);
    ref.read(permissionServiceProvider).replaceAbilities(abilities);
    state = AsyncValue.data(updated);
  }

  Future<void> signOut() async {
    final storage = ref.read(appStorageProvider);
    await storage.deleteSecure(_tokenKey);
    await storage.delete(_abilitiesKey);
    ref.read(permissionServiceProvider).clear();
    state = const AsyncValue.data(AuthState.unauthenticated());
  }
}

final authControllerProvider = AsyncNotifierProvider<AuthController, AuthState>(AuthController.new);
