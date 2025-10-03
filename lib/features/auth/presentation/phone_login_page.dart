import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/l10n/l10n.dart';
import '../../../app/theme/app_theme.dart';
import '../../../shared/widgets/otp_input.dart';

class PhoneLoginPage extends ConsumerStatefulWidget {
  const PhoneLoginPage({super.key});

  @override
  ConsumerState<PhoneLoginPage> createState() => _PhoneLoginPageState();
}

class _PhoneLoginPageState extends ConsumerState<PhoneLoginPage> {
  bool showCodeInput = false;
  bool hasAgreed = false;
  bool isLoading = false;
  String phone = '';
  String verifyCode = '';
  int countdown = 0;

  bool get canProceed => phone.length == 11 && hasAgreed;

  String get maskPhone {
    if (phone.length != 11) return phone;
    return '${phone.substring(0, 3)}****${phone.substring(7)}';
  }

  void _onGetCode() async {
    if (!canProceed) return;

    setState(() {
      isLoading = true;
    });

    // TODO: 调用发送验证码接口
    await Future.delayed(const Duration(seconds: 1));

    setState(() {
      isLoading = false;
      showCodeInput = true;
      countdown = 60;
    });

    _startCountdown();
  }

  void _startCountdown() {
    if (countdown > 0) {
      Future.delayed(const Duration(seconds: 1), () {
        if (mounted && countdown > 0) {
          setState(() {
            countdown--;
          });
          _startCountdown();
        }
      });
    }
  }

  void _onResendCode() async {
    setState(() {
      isLoading = true;
    });

    // TODO: 调用重发验证码接口
    await Future.delayed(const Duration(seconds: 1));

    setState(() {
      isLoading = false;
      countdown = 60;
    });

    _startCountdown();
  }

  void _onLogin() async {
    if (verifyCode.length != 6) return;

    setState(() {
      isLoading = true;
    });

    // TODO: 调用登录接口
    await Future.delayed(const Duration(seconds: 1));

    setState(() {
      isLoading = false;
    });

    // TODO: 登录成功后跳转
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colors;
    final spacing = theme.spacing;
    final radii = theme.radii;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: spacing.lg * 1.5),
          child: !showCodeInput
              ? _buildPhoneInput(theme, colors, spacing, radii)
              : _buildCodeInput(theme, colors, spacing, radii),
        ),
      ),
    );
  }

  // 手机号输入界面
  Widget _buildPhoneInput(
    ThemeData theme,
    AppColorTokens colors,
    AppSpacingTokens spacing,
    AppRadiusTokens radii,
  ) {
    return Column(
      children: [
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: spacing.xl),
              // Logo
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: const Color(0xFFB78300),
                  borderRadius: BorderRadius.circular(40),
                ),
                child: const Icon(
                  Icons.pets,
                  size: 48,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: spacing.md),
              Text(
                context.l10n.phoneLoginTitle,
                style: theme.textTheme.headlineMedium?.copyWith(
                  color: const Color(0xFFB78300),
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: spacing.sm),
              Text(
                context.l10n.phoneLoginSubtitle,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: colors.onBackground.withValues(alpha: 0.45),
                ),
              ),

              SizedBox(height: spacing.xl * 2),

              // 手机号输入框
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: spacing.lg,
                  vertical: spacing.md,
                ),
                decoration: BoxDecoration(
                  color: colors.background,
                  borderRadius: BorderRadius.circular(radii.md),
                  boxShadow: [
                    BoxShadow(
                      color: colors.onBackground.withValues(alpha: 0.06),
                      blurRadius: 12,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Text(
                      '+86',
                      style: theme.textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(width: spacing.md),
                    Expanded(
                      child: TextField(
                        keyboardType: TextInputType.phone,
                        maxLength: 11,
                        autofocus: true,
                        onChanged: (value) {
                          setState(() {
                            phone = value;
                          });
                        },
                        decoration: InputDecoration(
                          hintText: context.l10n.phoneInputHint,
                          border: InputBorder.none,
                          counterText: '',
                        ),
                        style: theme.textTheme.bodyLarge,
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: spacing.sm),

              Text(
                context.l10n.phoneInputTip,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: colors.onBackground.withValues(alpha: 0.45),
                ),
              ),

              SizedBox(height: spacing.xl),

              // 获取验证码按钮
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: canProceed && !isLoading ? _onGetCode : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFFA042),
                    foregroundColor: Colors.white,
                    disabledBackgroundColor:
                        const Color(0xFFFFA042).withValues(alpha: 0.3),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(28),
                    ),
                    elevation: 8,
                    shadowColor:
                        const Color(0xFFFFA042).withValues(alpha: 0.35),
                  ),
                  child: Text(
                    isLoading
                        ? context.l10n.sendingCode
                        : context.l10n.getVerifyCode,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),

        // 协议
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Checkbox(
              value: hasAgreed,
              onChanged: (value) {
                setState(() {
                  hasAgreed = value ?? false;
                });
              },
              shape: const CircleBorder(),
              activeColor: Colors.green,
            ),
            Flexible(
              child: Wrap(
                alignment: WrapAlignment.center,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  Text(
                    context.l10n.loginAgreeLabel,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: colors.onBackground.withValues(alpha: 0.6),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Text(
                      context.l10n.userAgreement,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: Colors.blue,
                      ),
                    ),
                  ),
                  Text(
                    context.l10n.and,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: colors.onBackground.withValues(alpha: 0.6),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Text(
                      context.l10n.privacyPolicy,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),

        SizedBox(height: spacing.lg),
      ],
    );
  }

  // 验证码输入界面
  Widget _buildCodeInput(
    ThemeData theme,
    AppColorTokens colors,
    AppSpacingTokens spacing,
    AppRadiusTokens radii,
  ) {
    return Column(
      children: [
        SizedBox(height: spacing.xl),
        Expanded(
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(radii.lg * 1.5),
            ),
            child: Padding(
              padding: EdgeInsets.all(spacing.xl),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    context.l10n.enterVerifyCode,
                    style: theme.textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: spacing.md),
                  Text(
                    context.l10n.codeSentTo(maskPhone),
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: colors.onBackground.withValues(alpha: 0.45),
                    ),
                  ),
                  SizedBox(height: spacing.xl * 2),

                  // 验证码输入框
                  OtpInput(
                    length: 6,
                    value: verifyCode,
                    onChanged: (value) {
                      setState(() {
                        verifyCode = value;
                      });
                    },
                  ),

                  SizedBox(height: spacing.xl),

                  // 重发按钮
                  TextButton(
                    onPressed: countdown > 0 || isLoading
                        ? null
                        : _onResendCode,
                    child: Text(
                      countdown > 0
                          ? context.l10n.resendAfter(countdown.toString())
                          : isLoading
                              ? context.l10n.sendingCode
                              : context.l10n.resendCode,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: countdown > 0
                            ? colors.onBackground.withValues(alpha: 0.45)
                            : Colors.blue,
                      ),
                    ),
                  ),

                  SizedBox(height: spacing.xl),

                  // 登录按钮
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      onPressed:
                          verifyCode.length == 6 && !isLoading
                              ? _onLogin
                              : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFFFA042),
                        foregroundColor: Colors.white,
                        disabledBackgroundColor:
                            const Color(0xFFFFA042).withValues(alpha: 0.3),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(28),
                        ),
                        elevation: 8,
                        shadowColor:
                            const Color(0xFFFFA042).withValues(alpha: 0.35),
                      ),
                      child: Text(
                        isLoading
                            ? context.l10n.loginLoading
                            : context.l10n.loginButton,
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(height: spacing.xl),
      ],
    );
  }
}
