import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'user_role.dart';

class UserRoleController extends StateNotifier<UserRole> {
  UserRoleController() : super(UserRole.user);

  void switchRole(UserRole role) {
    state = role;
  }

  void switchToUser() {
    state = UserRole.user;
  }

  void switchToProvider() {
    state = UserRole.provider;
  }
}

final userRoleControllerProvider =
    StateNotifierProvider<UserRoleController, UserRole>((ref) {
  return UserRoleController();
});
