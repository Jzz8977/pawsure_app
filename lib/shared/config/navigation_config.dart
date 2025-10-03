import '../../core/auth/user_role.dart';
import '../models/navigation_item.dart';

class NavigationConfig {
  const NavigationConfig._();

  static const String _iconBasePath = 'assets/icons';

  static const Map<UserRole, List<NavigationItem>> navigationItems = {
    UserRole.user: [
      NavigationItem(
        labelKey: 'navHome',
        iconPath: '$_iconBasePath/home.svg',
        activeIconPath: '$_iconBasePath/home_active.svg',
        route: '/home',
      ),
      NavigationItem(
        labelKey: 'navPet',
        iconPath: '$_iconBasePath/pet.svg',
        activeIconPath: '$_iconBasePath/pet_active.svg',
        route: '/pet',
      ),
      NavigationItem(
        labelKey: 'navMy',
        iconPath: '$_iconBasePath/my.svg',
        activeIconPath: '$_iconBasePath/my_active.svg',
        route: '/my',
      ),
    ],
    UserRole.provider: [
      NavigationItem(
        labelKey: 'navProviderHome',
        iconPath: '$_iconBasePath/home.svg',
        activeIconPath: '$_iconBasePath/home_active.svg',
        route: '/provider/home',
      ),
      NavigationItem(
        labelKey: 'navOrder',
        iconPath: '$_iconBasePath/pet.svg',
        activeIconPath: '$_iconBasePath/pet_active.svg',
        route: '/provider/order',
      ),
      NavigationItem(
        labelKey: 'navMy',
        iconPath: '$_iconBasePath/my.svg',
        activeIconPath: '$_iconBasePath/my_active.svg',
        route: '/provider/my',
      ),
    ],
  };

  static List<NavigationItem> getItemsForRole(UserRole role) {
    return navigationItems[role] ?? navigationItems[UserRole.user]!;
  }
}
