class NavigationItem {
  const NavigationItem({
    required this.labelKey,
    required this.iconPath,
    required this.activeIconPath,
    required this.route,
  });

  final String labelKey;
  final String iconPath;
  final String activeIconPath;
  final String route;
}
