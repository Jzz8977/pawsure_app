import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app_env.dart';

final appEnvProvider = Provider<AppEnv>((ref) {
  return AppEnv.fromFlavor(AppFlavor.dev);
});
