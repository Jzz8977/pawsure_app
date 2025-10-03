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

  @override
  String get loginWelcome => 'Hello, Welcome to Pawsure.';

  @override
  String get loginWechat => 'WeChat Login';

  @override
  String get loginLoading => 'Logging in...';

  @override
  String get loginPhoneLabel => 'Phone Login';

  @override
  String get loginAgreePrefix => 'I have read and agree to';

  @override
  String get loginTerms => 'Terms of Service';

  @override
  String get loginAnd => 'and';

  @override
  String get loginPrivacy => 'Privacy Policy';

  @override
  String get loginTitle => 'Login';

  @override
  String get goToLogin => 'Go to Login';

  @override
  String get phoneLoginTitle => 'Pawsure Platform';

  @override
  String get phoneLoginSubtitle => 'Quick Login with Phone';

  @override
  String get phoneInputHint => 'Enter phone number';

  @override
  String get phoneInputTip => 'We will send verification code to this number';

  @override
  String get getVerifyCode => 'Get Code';

  @override
  String get sendingCode => 'Sending...';

  @override
  String get loginAgreeLabel => 'Login means you agree to';

  @override
  String get userAgreement => 'User Agreement';

  @override
  String get and => 'and';

  @override
  String get privacyPolicy => 'Privacy Policy';

  @override
  String get enterVerifyCode => 'Enter Verification Code';

  @override
  String codeSentTo(String phone) {
    return 'Code sent to $phone';
  }

  @override
  String get resendCode => 'Resend';

  @override
  String resendAfter(String seconds) {
    return 'Resend after ${seconds}s';
  }

  @override
  String get loginButton => 'Login';

  @override
  String get clickToLogin => 'Click to Login';

  @override
  String get normalMember => 'Normal Member';

  @override
  String get memberCenter => 'Member Center';

  @override
  String get coupon => 'Coupon';

  @override
  String get favorite => 'Favorite';

  @override
  String get address => 'Address';

  @override
  String get becomeCaregiver => 'Become Caregiver';

  @override
  String get myOrder => 'My Orders';

  @override
  String get toPay => 'To Pay';

  @override
  String get toStart => 'To Start';

  @override
  String get checkIn => 'Check In';

  @override
  String get toEvaluate => 'To Evaluate';

  @override
  String get refund => 'Refund';

  @override
  String get wallet => 'Wallet';

  @override
  String get account => 'Account';

  @override
  String get ticket => 'Ticket';

  @override
  String get insurance => 'Insurance';

  @override
  String get term => 'Term';

  @override
  String get rules => 'Rules';

  @override
  String get agreement => 'Agreement';

  @override
  String get about => 'About';

  @override
  String get logout => 'Logout';

  @override
  String version(String version) {
    return 'Version $version';
  }

  @override
  String get all => 'All';
}
