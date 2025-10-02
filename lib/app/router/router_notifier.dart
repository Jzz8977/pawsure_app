import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/auth/auth_controller.dart';
import '../../core/auth/auth_state.dart';
import '../../shared/services/permission_service.dart';

class RouterNotifier extends ChangeNotifier {
  RouterNotifier(this._ref) {
    _ref.listen<AsyncValue<AuthState>>(authControllerProvider, (previous, next) {
      notifyListeners();
    });
    _ref.listen<PermissionState>(permissionStateProvider, (previous, next) {
      notifyListeners();
    });
  }

  final Ref _ref;
}
