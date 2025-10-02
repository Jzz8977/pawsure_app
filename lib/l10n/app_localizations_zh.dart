// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class AppLocalizationsZh extends AppLocalizations {
  AppLocalizationsZh([String locale = 'zh']) : super(locale);

  @override
  String appTitle(String environment) {
    return 'Pawsure（$environment）';
  }

  @override
  String get homeTitle => '总览';

  @override
  String homeWelcomeTitle(String environment) {
    return '欢迎使用 Pawsure（$environment）';
  }

  @override
  String get homeWelcomeDescription => '在这里查看不同环境下的保障与业务状态。';

  @override
  String get currentBaseUrlLabel => '当前 API 基础地址';

  @override
  String get permissionDeniedTitle => '无访问权限';

  @override
  String get permissionDeniedDescription => '你没有访问该页面的权限。';

  @override
  String get genericErrorTitle => '发生错误';

  @override
  String get genericErrorDescription => '稍后再试或联系支持团队。';
}
