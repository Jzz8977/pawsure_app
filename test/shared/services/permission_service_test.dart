import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pawsure_app/shared/services/permission_service.dart';

void main() {
  test('PermissionService can update and clear abilities', () {
    final container = ProviderContainer();
    addTearDown(container.dispose);

    final service = container.read(permissionServiceProvider);

    expect(service.can('dashboard.view'), isFalse);

    service.replaceAbilities({'dashboard.view', 'admin.access'});

    expect(service.can('dashboard.view'), isTrue);
    expect(
      container.read(permissionStateProvider).abilities,
      containsAll(<String>['dashboard.view', 'admin.access']),
    );

    service.clear();

    expect(container.read(permissionStateProvider).abilities, isEmpty);
    expect(service.can('dashboard.view'), isFalse);
  });
}
