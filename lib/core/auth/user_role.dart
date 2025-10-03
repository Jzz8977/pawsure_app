enum UserRole {
  user,
  provider;

  String get key {
    switch (this) {
      case UserRole.user:
        return 'user';
      case UserRole.provider:
        return 'provider';
    }
  }

  static UserRole fromString(String value) {
    switch (value.toLowerCase()) {
      case 'provider':
        return UserRole.provider;
      case 'user':
      default:
        return UserRole.user;
    }
  }
}
