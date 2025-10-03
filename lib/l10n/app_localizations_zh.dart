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

  @override
  String get navHome => '首页';

  @override
  String get navPet => '宠物';

  @override
  String get navMy => '我的';

  @override
  String get navProviderHome => '服务者首页';

  @override
  String get navOrder => '订单';

  @override
  String get petTitle => '宠物';

  @override
  String get petWelcome => '宠物页面';

  @override
  String get myTitle => '我的';

  @override
  String get myWelcome => '我的页面';

  @override
  String currentRole(String role) {
    return '当前角色：$role';
  }

  @override
  String get roleUser => '用户';

  @override
  String get roleProvider => '服务者';

  @override
  String get switchRole => '切换角色';

  @override
  String get providerHomeTitle => '服务者首页';

  @override
  String get providerHomeWelcome => '服务者首页';

  @override
  String get orderTitle => '订单';

  @override
  String get orderWelcome => '订单页面';

  @override
  String get loginWelcome => 'Hello，欢迎来到宠信。';

  @override
  String get loginWechat => '微信一键登录';

  @override
  String get loginLoading => '登录中...';

  @override
  String get loginPhoneLabel => '手机号登录';

  @override
  String get loginAgreePrefix => '我已阅读并同意';

  @override
  String get loginTerms => '《服务条款》';

  @override
  String get loginAnd => '与';

  @override
  String get loginPrivacy => '《隐私协议》';

  @override
  String get loginTitle => '登录';

  @override
  String get goToLogin => '前往登录';

  @override
  String get phoneLoginTitle => '宠信平台';

  @override
  String get phoneLoginSubtitle => '手机号快捷登录';

  @override
  String get phoneInputHint => '请输入手机号';

  @override
  String get phoneInputTip => '我们将发送验证码至此手机号';

  @override
  String get getVerifyCode => '获取验证码';

  @override
  String get sendingCode => '发送中...';

  @override
  String get loginAgreeLabel => '登录即表示同意';

  @override
  String get userAgreement => '《用户协议》';

  @override
  String get and => '和';

  @override
  String get privacyPolicy => '《隐私政策》';

  @override
  String get enterVerifyCode => '请输入验证码';

  @override
  String codeSentTo(String phone) {
    return '验证码已发送至 $phone';
  }

  @override
  String get resendCode => '重新发送';

  @override
  String resendAfter(String seconds) {
    return '${seconds}s后重发';
  }

  @override
  String get loginButton => '登录';

  @override
  String get clickToLogin => '点击登录';

  @override
  String get normalMember => '普通会员';

  @override
  String get memberCenter => '会员中心';

  @override
  String get coupon => '优惠券';

  @override
  String get favorite => '收藏';

  @override
  String get address => '地址';

  @override
  String get becomeCaregiver => '成为服务者';

  @override
  String get myOrder => '我的订单';

  @override
  String get toPay => '待付款';

  @override
  String get toStart => '待开始';

  @override
  String get checkIn => '待签到';

  @override
  String get toEvaluate => '待评价';

  @override
  String get refund => '退款';

  @override
  String get wallet => '钱包';

  @override
  String get account => '账户';

  @override
  String get ticket => '券包';

  @override
  String get insurance => '保险';

  @override
  String get term => '期限';

  @override
  String get rules => '平台规则';

  @override
  String get agreement => '协议';

  @override
  String get about => '关于';

  @override
  String get logout => '退出登录';

  @override
  String version(String version) {
    return '版本 $version';
  }

  @override
  String get all => '全部';
}
