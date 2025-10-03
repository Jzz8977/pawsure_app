import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_zh.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('zh'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'Pawsure ({environment})'**
  String appTitle(String environment);

  /// No description provided for @homeTitle.
  ///
  /// In en, this message translates to:
  /// **'Overview'**
  String get homeTitle;

  /// No description provided for @homeWelcomeTitle.
  ///
  /// In en, this message translates to:
  /// **'Welcome to Pawsure ({environment})'**
  String homeWelcomeTitle(String environment);

  /// No description provided for @homeWelcomeDescription.
  ///
  /// In en, this message translates to:
  /// **'Keep track of your coverage and activity across environments.'**
  String get homeWelcomeDescription;

  /// No description provided for @currentBaseUrlLabel.
  ///
  /// In en, this message translates to:
  /// **'Current API base URL'**
  String get currentBaseUrlLabel;

  /// No description provided for @permissionDeniedTitle.
  ///
  /// In en, this message translates to:
  /// **'Access restricted'**
  String get permissionDeniedTitle;

  /// No description provided for @permissionDeniedDescription.
  ///
  /// In en, this message translates to:
  /// **'You do not have permission to view this section.'**
  String get permissionDeniedDescription;

  /// No description provided for @genericErrorTitle.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong'**
  String get genericErrorTitle;

  /// No description provided for @genericErrorDescription.
  ///
  /// In en, this message translates to:
  /// **'Please try again later or contact support.'**
  String get genericErrorDescription;

  /// No description provided for @navHome.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get navHome;

  /// No description provided for @navPet.
  ///
  /// In en, this message translates to:
  /// **'Pet'**
  String get navPet;

  /// No description provided for @navMy.
  ///
  /// In en, this message translates to:
  /// **'My'**
  String get navMy;

  /// No description provided for @navProviderHome.
  ///
  /// In en, this message translates to:
  /// **'Provider Home'**
  String get navProviderHome;

  /// No description provided for @navOrder.
  ///
  /// In en, this message translates to:
  /// **'Order'**
  String get navOrder;

  /// No description provided for @petTitle.
  ///
  /// In en, this message translates to:
  /// **'Pet'**
  String get petTitle;

  /// No description provided for @petWelcome.
  ///
  /// In en, this message translates to:
  /// **'Pet Page'**
  String get petWelcome;

  /// No description provided for @myTitle.
  ///
  /// In en, this message translates to:
  /// **'My'**
  String get myTitle;

  /// No description provided for @myWelcome.
  ///
  /// In en, this message translates to:
  /// **'My Page'**
  String get myWelcome;

  /// No description provided for @currentRole.
  ///
  /// In en, this message translates to:
  /// **'Current Role: {role}'**
  String currentRole(String role);

  /// No description provided for @roleUser.
  ///
  /// In en, this message translates to:
  /// **'User'**
  String get roleUser;

  /// No description provided for @roleProvider.
  ///
  /// In en, this message translates to:
  /// **'Provider'**
  String get roleProvider;

  /// No description provided for @switchRole.
  ///
  /// In en, this message translates to:
  /// **'Switch Role'**
  String get switchRole;

  /// No description provided for @providerHomeTitle.
  ///
  /// In en, this message translates to:
  /// **'Provider Home'**
  String get providerHomeTitle;

  /// No description provided for @providerHomeWelcome.
  ///
  /// In en, this message translates to:
  /// **'Provider Home Page'**
  String get providerHomeWelcome;

  /// No description provided for @orderTitle.
  ///
  /// In en, this message translates to:
  /// **'Order'**
  String get orderTitle;

  /// No description provided for @orderWelcome.
  ///
  /// In en, this message translates to:
  /// **'Order Page'**
  String get orderWelcome;

  /// No description provided for @loginWelcome.
  ///
  /// In en, this message translates to:
  /// **'Hello, Welcome to Pawsure.'**
  String get loginWelcome;

  /// No description provided for @loginWechat.
  ///
  /// In en, this message translates to:
  /// **'WeChat Login'**
  String get loginWechat;

  /// No description provided for @loginLoading.
  ///
  /// In en, this message translates to:
  /// **'Logging in...'**
  String get loginLoading;

  /// No description provided for @loginPhoneLabel.
  ///
  /// In en, this message translates to:
  /// **'Phone Login'**
  String get loginPhoneLabel;

  /// No description provided for @loginAgreePrefix.
  ///
  /// In en, this message translates to:
  /// **'I have read and agree to'**
  String get loginAgreePrefix;

  /// No description provided for @loginTerms.
  ///
  /// In en, this message translates to:
  /// **'Terms of Service'**
  String get loginTerms;

  /// No description provided for @loginAnd.
  ///
  /// In en, this message translates to:
  /// **'and'**
  String get loginAnd;

  /// No description provided for @loginPrivacy.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get loginPrivacy;

  /// No description provided for @loginTitle.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get loginTitle;

  /// No description provided for @goToLogin.
  ///
  /// In en, this message translates to:
  /// **'Go to Login'**
  String get goToLogin;

  /// No description provided for @phoneLoginTitle.
  ///
  /// In en, this message translates to:
  /// **'Pawsure Platform'**
  String get phoneLoginTitle;

  /// No description provided for @phoneLoginSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Quick Login with Phone'**
  String get phoneLoginSubtitle;

  /// No description provided for @phoneInputHint.
  ///
  /// In en, this message translates to:
  /// **'Enter phone number'**
  String get phoneInputHint;

  /// No description provided for @phoneInputTip.
  ///
  /// In en, this message translates to:
  /// **'We will send verification code to this number'**
  String get phoneInputTip;

  /// No description provided for @getVerifyCode.
  ///
  /// In en, this message translates to:
  /// **'Get Code'**
  String get getVerifyCode;

  /// No description provided for @sendingCode.
  ///
  /// In en, this message translates to:
  /// **'Sending...'**
  String get sendingCode;

  /// No description provided for @loginAgreeLabel.
  ///
  /// In en, this message translates to:
  /// **'Login means you agree to'**
  String get loginAgreeLabel;

  /// No description provided for @userAgreement.
  ///
  /// In en, this message translates to:
  /// **'User Agreement'**
  String get userAgreement;

  /// No description provided for @and.
  ///
  /// In en, this message translates to:
  /// **'and'**
  String get and;

  /// No description provided for @privacyPolicy.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get privacyPolicy;

  /// No description provided for @enterVerifyCode.
  ///
  /// In en, this message translates to:
  /// **'Enter Verification Code'**
  String get enterVerifyCode;

  /// No description provided for @codeSentTo.
  ///
  /// In en, this message translates to:
  /// **'Code sent to {phone}'**
  String codeSentTo(String phone);

  /// No description provided for @resendCode.
  ///
  /// In en, this message translates to:
  /// **'Resend'**
  String get resendCode;

  /// No description provided for @resendAfter.
  ///
  /// In en, this message translates to:
  /// **'Resend after {seconds}s'**
  String resendAfter(String seconds);

  /// No description provided for @loginButton.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get loginButton;

  /// No description provided for @clickToLogin.
  ///
  /// In en, this message translates to:
  /// **'Click to Login'**
  String get clickToLogin;

  /// No description provided for @normalMember.
  ///
  /// In en, this message translates to:
  /// **'Normal Member'**
  String get normalMember;

  /// No description provided for @memberCenter.
  ///
  /// In en, this message translates to:
  /// **'Member Center'**
  String get memberCenter;

  /// No description provided for @coupon.
  ///
  /// In en, this message translates to:
  /// **'Coupon'**
  String get coupon;

  /// No description provided for @favorite.
  ///
  /// In en, this message translates to:
  /// **'Favorite'**
  String get favorite;

  /// No description provided for @address.
  ///
  /// In en, this message translates to:
  /// **'Address'**
  String get address;

  /// No description provided for @becomeCaregiver.
  ///
  /// In en, this message translates to:
  /// **'Become Caregiver'**
  String get becomeCaregiver;

  /// No description provided for @myOrder.
  ///
  /// In en, this message translates to:
  /// **'My Orders'**
  String get myOrder;

  /// No description provided for @toPay.
  ///
  /// In en, this message translates to:
  /// **'To Pay'**
  String get toPay;

  /// No description provided for @toStart.
  ///
  /// In en, this message translates to:
  /// **'To Start'**
  String get toStart;

  /// No description provided for @checkIn.
  ///
  /// In en, this message translates to:
  /// **'Check In'**
  String get checkIn;

  /// No description provided for @toEvaluate.
  ///
  /// In en, this message translates to:
  /// **'To Evaluate'**
  String get toEvaluate;

  /// No description provided for @refund.
  ///
  /// In en, this message translates to:
  /// **'Refund'**
  String get refund;

  /// No description provided for @wallet.
  ///
  /// In en, this message translates to:
  /// **'Wallet'**
  String get wallet;

  /// No description provided for @account.
  ///
  /// In en, this message translates to:
  /// **'Account'**
  String get account;

  /// No description provided for @ticket.
  ///
  /// In en, this message translates to:
  /// **'Ticket'**
  String get ticket;

  /// No description provided for @insurance.
  ///
  /// In en, this message translates to:
  /// **'Insurance'**
  String get insurance;

  /// No description provided for @term.
  ///
  /// In en, this message translates to:
  /// **'Term'**
  String get term;

  /// No description provided for @rules.
  ///
  /// In en, this message translates to:
  /// **'Rules'**
  String get rules;

  /// No description provided for @agreement.
  ///
  /// In en, this message translates to:
  /// **'Agreement'**
  String get agreement;

  /// No description provided for @about.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get about;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logout;

  /// No description provided for @version.
  ///
  /// In en, this message translates to:
  /// **'Version {version}'**
  String version(String version);

  /// No description provided for @all.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get all;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'zh'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'zh':
      return AppLocalizationsZh();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
