class AuthState {
  const AuthState({
    required this.accessToken,
    required this.abilities,
  });

  const AuthState.unauthenticated()
      : accessToken = null,
        abilities = const <String>{};

  final String? accessToken;
  final Set<String> abilities;

  bool get isAuthenticated => accessToken != null && accessToken!.isNotEmpty;

  AuthState copyWith({
    String? accessToken,
    Set<String>? abilities,
  }) {
    return AuthState(
      accessToken: accessToken ?? this.accessToken,
      abilities: abilities ?? this.abilities,
    );
  }
}
