import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../app/l10n/l10n.dart';
import '../../../app/router/app_router.dart';
import '../../../app/theme/app_theme.dart';
import '../../../core/auth/user_role.dart';
import '../../../core/auth/user_role_controller.dart';

class MyPage extends ConsumerWidget {
  const MyPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final spacing = theme.spacing;
    final colors = theme.colors;
    final radii = theme.radii;
    final currentRole = ref.watch(userRoleControllerProvider);

    return Scaffold(
      backgroundColor: const Color(0xFFEFF1F4),
      body: CustomScrollView(
        slivers: [
          // 顶部渐变头部
          SliverAppBar(
            expandedHeight: 200,
            pinned: true,
            backgroundColor: const Color(0xFFFFB78A),
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color(0xFFFFD8B0),
                      Color(0xFFFFB78A),
                      Color(0xFFF5A37A),
                    ],
                  ),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(24),
                    bottomRight: Radius.circular(24),
                  ),
                ),
                child: SafeArea(
                  child: Padding(
                    padding: EdgeInsets.all(spacing.lg),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Row(
                          children: [
                            // 头像
                            Container(
                              width: 55,
                              height: 55,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Colors.white.withValues(alpha: 0.6),
                                  width: 2,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withValues(alpha: 0.08),
                                    blurRadius: 9,
                                    offset: const Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: const CircleAvatar(
                                radius: 55,
                                backgroundImage: AssetImage('assets/images/my/home.png'),
                              ),
                            ),
                            SizedBox(width: spacing.md),
                            // 用户信息
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        context.l10n.clickToLogin,
                                        style: const TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xFF2b2b2b),
                                        ),
                                      ),
                                      SizedBox(width: spacing.xs),
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 6,
                                          vertical: 2,
                                        ),
                                        decoration: BoxDecoration(
                                          color: const Color(0xFFFFF7E6),
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        child: const Text(
                                          '^',
                                          style: TextStyle(
                                            fontSize: 10,
                                            color: Color(0xFF946200),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: spacing.xs / 2),
                                  Row(
                                    children: [
                                      Image.asset(
                                        'assets/images/my/vip.png',
                                        width: 26,
                                        height: 24,
                                      ),
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 8,
                                          vertical: 2,
                                        ),
                                        decoration: BoxDecoration(
                                          color: Colors.white.withValues(alpha: 0.7),
                                          borderRadius: BorderRadius.circular(9),
                                          border: Border.all(
                                            color: Colors.white.withValues(alpha: 0.9),
                                          ),
                                        ),
                                        child: const Text(
                                          '普通',
                                          style: TextStyle(
                                            fontSize: 11,
                                            color: Color(0xFFD48713),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            // 更多按钮
                            Container(
                              width: 36,
                              height: 36,
                              decoration: BoxDecoration(
                                color: Colors.white.withValues(alpha: 0.9),
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withValues(alpha: 0.08),
                                    blurRadius: 9,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: const Icon(
                                Icons.more_horiz,
                                size: 20,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),

          // 会员条
          SliverToBoxAdapter(
            child: Container(
              margin: EdgeInsets.symmetric(
                horizontal: spacing.lg,
                vertical: spacing.sm,
              ),
              padding: EdgeInsets.all(spacing.md),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color.fromRGBO(255, 255, 255, 0.41),
                    Color.fromRGBO(255, 255, 255, 0),
                  ],
                ),
                borderRadius: BorderRadius.circular(radii.md),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.06),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text(
                            context.l10n.normalMember,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFFCC9933),
                            ),
                          ),
                          SizedBox(width: spacing.sm),
                          const Row(
                            children: [
                              Text('★', style: TextStyle(fontSize: 12, color: Color(0xFFFF8C3D))),
                              Text('★', style: TextStyle(fontSize: 12, color: Color(0xFFd8d8d8))),
                              Text('★', style: TextStyle(fontSize: 12, color: Color(0xFFd8d8d8))),
                              Text('★', style: TextStyle(fontSize: 12, color: Color(0xFFd8d8d8))),
                              Text('★', style: TextStyle(fontSize: 12, color: Color(0xFFd8d8d8))),
                            ],
                          ),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 9,
                          vertical: 1,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFCDEA2),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          children: [
                            Text(
                              context.l10n.memberCenter,
                              style: const TextStyle(
                                fontSize: 12,
                                color: Color(0xFF333333),
                              ),
                            ),
                            const Text(
                              '›',
                              style: TextStyle(
                                fontSize: 16,
                                color: Color(0xFFc6c6c6),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spacing.md),
                  // 四宫格功能
                  Container(
                    padding: EdgeInsets.all(spacing.sm),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radii.md),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.06),
                          blurRadius: 12,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildQuickItem(context, 'assets/images/my/coupon.png', context.l10n.coupon),
                        _buildQuickItem(context, 'assets/images/my/collect.png', context.l10n.favorite),
                        _buildQuickItem(context, 'assets/images/my/address.png', context.l10n.address),
                        _buildQuickItem(context, 'assets/images/my/caregivers.png', context.l10n.becomeCaregiver),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // 我的订单
          SliverToBoxAdapter(
            child: _buildSectionCard(
              context,
              title: context.l10n.myOrder,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildOrderItem(context, 'assets/images/my/pre_payment.png', context.l10n.toPay, count: 0),
                    _buildOrderItem(context, 'assets/images/my/pre_start.png', context.l10n.toStart, count: 0),
                    _buildOrderItem(context, 'assets/images/my/check_in.png', context.l10n.checkIn, count: 0),
                    _buildOrderItem(context, 'assets/images/my/pre_evaluate.png', context.l10n.toEvaluate, count: 0),
                    _buildOrderItem(context, 'assets/images/my/refund.png', context.l10n.refund, count: 0),
                  ],
                ),
              ],
            ),
          ),

          // 钱包
          SliverToBoxAdapter(
            child: _buildSectionCard(
              context,
              title: context.l10n.wallet,
              showMore: false,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildOrderItem(context, 'assets/images/my/account.png', context.l10n.account, count: 0),
                    _buildOrderItem(context, 'assets/images/my/ticket.png', context.l10n.ticket, count: 0),
                    _buildOrderItem(context, 'assets/images/my/insurance.png', context.l10n.insurance, count: 0),
                    _buildOrderItem(context, 'assets/images/my/term.png', context.l10n.term, count: 0),
                    const SizedBox(width: 46),
                  ],
                ),
              ],
            ),
          ),

          // 平台规则 & 关于
          SliverToBoxAdapter(
            child: _buildSectionCard(
              context,
              showTitle: false,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildOrderItem(context, 'assets/images/my/rules.png', context.l10n.rules, count: 0),
                    _buildOrderItem(context, 'assets/images/my/agreement.png', context.l10n.agreement, count: 0),
                    _buildOrderItem(context, 'assets/images/my/about.png', context.l10n.about, count: 0),
                    const SizedBox(width: 46),
                    const SizedBox(width: 46),
                  ],
                ),
              ],
            ),
          ),

          // 退出登录
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: spacing.lg,
                vertical: spacing.sm,
              ),
              child: Container(
                height: 46,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Color(0xFFffffff), Color(0xFFfafafa)],
                  ),
                  border: Border.all(color: const Color(0xFFeeeeee)),
                  borderRadius: BorderRadius.circular(999),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.04),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {},
                    borderRadius: BorderRadius.circular(999),
                    child: Center(
                      child: Text(
                        context.l10n.logout,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFFff6a00),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),

          // 版本号
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: spacing.lg),
              child: Center(
                child: Text(
                  context.l10n.version('1.0.0'),
                  style: const TextStyle(
                    fontSize: 11,
                    color: Color(0xFF9aa0a6),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickItem(BuildContext context, String icon, String label) {
    return Column(
      children: [
        Container(
          width: 36,
          height: 36,
          decoration: const BoxDecoration(
            color: Color(0xFFF7F7F7),
          ),
          child: Image.asset(icon, fit: BoxFit.cover),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            color: Color(0xFF333333),
          ),
        ),
      ],
    );
  }

  Widget _buildSectionCard(
    BuildContext context, {
    String? title,
    bool showTitle = true,
    bool showMore = true,
    required List<Widget> children,
  }) {
    final spacing = Theme.of(context).spacing;
    final radii = Theme.of(context).radii;

    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: spacing.lg,
        vertical: spacing.sm,
      ),
      padding: EdgeInsets.all(spacing.md),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radii.lg),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          if (showTitle)
            Padding(
              padding: EdgeInsets.only(bottom: spacing.xs),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title ?? '',
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  if (showMore)
                    Row(
                      children: [
                        Text(
                          context.l10n.all,
                          style: const TextStyle(
                            fontSize: 11,
                            color: Color(0xFF999999),
                          ),
                        ),
                        const Text(
                          '›',
                          style: TextStyle(
                            fontSize: 16,
                            color: Color(0xFFc6c6c6),
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ...children,
        ],
      ),
    );
  }

  Widget _buildOrderItem(BuildContext context, String icon, String label, {int count = 0}) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Column(
            children: [
              SizedBox(
                width: 23,
                height: 23,
                child: Image.asset(icon, fit: BoxFit.cover),
              ),
              const SizedBox(height: 4),
              Text(
                label,
                style: const TextStyle(
                  fontSize: 12,
                  color: Color(0xFF333333),
                ),
              ),
            ],
          ),
        ),
        if (count > 0)
          Positioned(
            top: 4,
            right: 11,
            child: Container(
              minWidth: 16,
              height: 16,
              padding: const EdgeInsets.symmetric(horizontal: 4),
              decoration: BoxDecoration(
                color: const Color(0xFFff4d4f),
                borderRadius: BorderRadius.circular(999),
              ),
              child: Center(
                child: Text(
                  count > 99 ? '99+' : count.toString(),
                  style: const TextStyle(
                    fontSize: 10,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
