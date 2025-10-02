import 'package:flutter_riverpod/flutter_riverpod.dart';

class PermissionState {
  const PermissionState({this.abilities = const <String>{}});

  final Set<String> abilities;

  bool can(String ability) => abilities.contains(ability);

  PermissionState copyWith({Set<String>? abilities}) {
    return PermissionState(
      abilities: abilities ?? this.abilities,
    );
  }
}

class PermissionController extends StateNotifier<PermissionState> {
  PermissionController() : super(const PermissionState());

  void replace(Set<String> abilities) {
    state = state.copyWith(abilities: {...abilities});
  }

  void clear() {
    state = const PermissionState();
  }
}

final permissionStateProvider = StateNotifierProvider<PermissionController, PermissionState>((ref) {
  return PermissionController();
});

class PermissionService {
  PermissionService(this._ref);

  final Ref _ref;

  bool can(String ability) {
    return _ref.read(permissionStateProvider).can(ability);
  }

  void replaceAbilities(Set<String> abilities) {
    _ref.read(permissionStateProvider.notifier).replace(abilities);
  }

  void clear() {
    _ref.read(permissionStateProvider.notifier).clear();
  }
}

final permissionServiceProvider = Provider<PermissionService>((ref) {
  return PermissionService(ref);
});
