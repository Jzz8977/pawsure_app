import 'app/bootstrap.dart';
import 'app/env/app_env.dart';

Future<void> main() async {
  const flavorName = String.fromEnvironment('APP_FLAVOR', defaultValue: 'dev');
  final env = AppEnv.fromName(flavorName);
  await bootstrap(env: env);
}
