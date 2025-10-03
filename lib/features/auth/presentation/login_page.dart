import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../app/l10n/l10n.dart';
import '../../../app/router/app_router.dart';
import '../../../app/theme/app_theme.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  bool hasAgreed = false;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colors;
    final spacing = theme.spacing;
    final radii = theme.radii;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: spacing.lg * 1.5),
          child: Column(
            children: [
              // 顶部区域（Logo + 欢迎语）
              Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 85,
                      height: 85,
                      decoration: BoxDecoration(
                        color: colors.primary,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.pets,
                        size: 48,
                        color: colors.onPrimary,
                      ),
                    ),
                    SizedBox(height: spacing.lg),
                    Text(
                      'Pawsure',
                      style: theme.textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: colors.primary,
                      ),
                    ),
                    SizedBox(height: spacing.md),
                    Text(
                      context.l10n.loginWelcome,
                      style: theme.textTheme.bodyLarge?.copyWith(
                        color: colors.onBackground.withValues(alpha: 0.7),
                      ),
                    ),
                  ],
                ),
              ),

              // 主内容区域（按钮）
              Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // 主登录按钮
                    SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: ElevatedButton(
                        onPressed: hasAgreed && !isLoading
                            ? () {
                                // TODO: 实现微信登录
                              }
                            : null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: colors.primary,
                          foregroundColor: colors.onPrimary,
                          disabledBackgroundColor:
                              colors.primary.withValues(alpha: 0.3),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(radii.lg * 2),
                          ),
                          elevation: 8,
                          shadowColor: colors.primary.withValues(alpha: 0.35),
                        ),
                        child: Text(
                          isLoading
                              ? context.l10n.loginLoading
                              : context.l10n.loginWechat,
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: colors.onPrimary,
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: spacing.lg),

                    // 分割线
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: 1,
                            color: colors.onBackground.withValues(alpha: 0.1),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: spacing.md),
                          child: Text(
                            context.l10n.loginPhoneLabel,
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: colors.onBackground.withValues(alpha: 0.45),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            height: 1,
                            color: colors.onBackground.withValues(alpha: 0.1),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: spacing.lg),

                    // 手机号登录圆形按钮
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.blue.withValues(alpha: 0.25),
                            blurRadius: 20,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: IconButton(
                        onPressed: hasAgreed && !isLoading
                            ? () {
                                context.push(AppRoutePath.phoneLogin);
                              }
                            : null,
                        icon: const Icon(
                          Icons.phone,
                          color: Colors.white,
                          size: 28,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // 底部协议区域
              Column(
                children: [
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
                              context.l10n.loginAgreePrefix,
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: colors.onBackground.withValues(alpha: 0.6),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                // TODO: 显示服务条款
                              },
                              child: Text(
                                context.l10n.loginTerms,
                                style: theme.textTheme.bodySmall?.copyWith(
                                  color: Colors.blue,
                                ),
                              ),
                            ),
                            Text(
                              context.l10n.loginAnd,
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: colors.onBackground.withValues(alpha: 0.6),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                // TODO: 显示隐私协议
                              },
                              child: Text(
                                context.l10n.loginPrivacy,
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
