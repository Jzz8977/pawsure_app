// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String appTitle(String environment) {
    return 'Pawsure ($environment)';
  }

  @override
  String get homeTitle => 'Overview';

  @override
  String homeWelcomeTitle(String environment) {
    return 'Welcome to Pawsure ($environment)';
  }

  @override
  String get homeWelcomeDescription =>
      'Keep track of your coverage and activity across environments.';

  @override
  String get currentBaseUrlLabel => 'Current API base URL';

  @override
  String get permissionDeniedTitle => 'Access restricted';

  @override
  String get permissionDeniedDescription =>
      'You do not have permission to view this section.';

  @override
  String get genericErrorTitle => 'Something went wrong';

  @override
  String get genericErrorDescription =>
      'Please try again later or contact support.';

  @override
  String get navHome => 'Home';

  @override
  String get navPet => 'Pet';

  @override
  String get navMy => 'My';

  @override
  String get navProviderHome => 'Provider Home';

  @override
  String get navOrder => 'Order';

  @override
  String get petTitle => 'Pet';

  @override
  String get petWelcome => 'Pet Page';

  @override
  String get myTitle => 'My';

  @override
  String get myWelcome => 'My Page';

  @override
  String currentRole(String role) {
    return 'Current Role: $role';
  }

  @override
  String get roleUser => 'User';

  @override
  String get roleProvider => 'Provider';

  @override
  String get switchRole => 'Switch Role';

  @override
  String get providerHomeTitle => 'Provider Home';

  @override
  String get providerHomeWelcome => 'Provider Home Page';

  @override
  String get orderTitle => 'Order';

  @override
  String get orderWelcome => 'Order Page';
}
