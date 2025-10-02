import 'package:flutter/widgets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class L10n {
  const L10n._();

  static Locale? localeResolution(Locale? locale, Iterable<Locale> supportedLocales) {
    if (locale == null) {
      return supportedLocales.first;
    }
    for (final supported in supportedLocales) {
      if (supported.languageCode == locale.languageCode) {
        return supported;
      }
    }
    return supportedLocales.first;
  }
}

extension L10nBuildContext on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this)!;
}
