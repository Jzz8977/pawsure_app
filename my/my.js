// pages/my/my.js
const app = getApp();
const User = require('../../models/User');
const authService = require('../../services/auth');
const request = require('../../utils/request');
const { API_ENDPOINTS } = require('../../config/constants');
const { getFilePreviewUrl } = require('../../services/uploadManager');
const AuthUtils = require('../../utils/authUtils');
// Note: util imports may be needed for future error handling

Page({
  data: {
    // 系统信息
    statusBarHeight: 44,
    navBarHeight: 88,

    // 用户信息
    userInfo: {
      name: '',
      avatarUrl: '',
      phone: '',
      loginTime: '',
      token: ''
    },

    // 认证状态
    verificationStatus: {
      isVerified: false,
      level: 'none',
      statusText: '未认证'
    },

    // 会员状态
    memberStatus: {
      level: '普通会员',
      levelColor: '#999999',
      isVip: false,
      expireDate: '',
      benefits: '享受基础服务',
      memberType: 'normal' // normal, silver, gold, diamond
    },

    // 功能模块数据
    featureModules: [
      {
        id: 'coupons',
        icon: '/assets/my/coupon.png',
        title: '优惠券',
        count: 5,
        route: '/packageUser/pages/coupons/coupons'
      },
      {
        id: 'favorites',
        icon: '/assets/my/collect.png',
        title: '收藏',
        count: 3,
        route: '/packageUser/pages/favorites/favorites'
      },
      {
        id: 'address',
        icon: '/assets/my/address.png',
        title: '地址',
        count: 2,
        route: '/packageManage/pages/address-list/address-list'
      },
      {
        id: 'provider',
        icon: '/assets/my/caregivers.png',
        title: '成为看护师',
        count: 0,
        route: '/packageUser/pages/become-provider/become-provider'
      }
    ],

    //订单
    ticketModules:[{
      icon: '/assets/my/pre_payment.png',
      title: '全部',
      status: 'all',
      count: 5,
      route: '/packageUser/pages/coupons/coupons'
    },{
      icon: '/assets/my/pre_start.png',
      title: '待开始',
      status: 'pending_start',
      count: 5,
      route: '/packageUser/pages/coupons/coupons'
    },{
      icon: '/assets/my/pre_evaluate.png',
      title: '待评价',
      status: 'pending_review',
      count: 5,
      route: '/packageUser/pages/coupons/coupons'
    },{
      icon: '/assets/my/refund.png',
      title: '退款/售后',
      status: 'refund',
      count: 5,
      route: '/packageUser/pages/coupons/coupons'
    },{
      icon: '/assets/my/check_in.png',
      title: '打卡',
      status: 'check',
      count: 5,
      route: '/packageUser/pages/coupons/coupons'
    }],

    walletModules:[{
      icon: '/assets/my/account.png',
      title: '账户',
      status: 'account',
      count: 0,
      route: '/packageUser/pages/coupons/coupons'
    },{
      icon: '/assets/my/insurance.png',
      title: '保险',
      status: 'insurance',
      count: 0,
      route: '/packageUser/pages/coupons/coupons'
    },{
      icon: '/assets/my/agreement.png',
      title: '协议',
      status: 'agreement',
      count: 0,
      route: '/packageUser/pages/coupons/coupons'
    }],
    aboutModules:[{
      icon: '/assets/my/rules.png',
      title: '平台规则',
      status: 'rules',
      count: 0,
      route: '/packageUser/pages/coupons/coupons'
    },{
      icon: '/assets/my/about.png',
      title: '关于宠信',
      status: 'about',
      count: 0,
      route: '/packageUser/pages/coupons/coupons'
    }],
    // 订单状态统计
    orderStats: {
      total: 0,
      pendingPayment: 0,
      pendingStart: 0,
      pendingReview: 0,
      refundAfterSale: 0
    },

    // 钱包信息
    walletInfo: {
      balance: 0,
      hasInsurance: false,
      insuranceType: ''
    },

    // 当前角色信息
    currentRoleInfo: {
      icon: '/assets/tabbar/home.png',
      title: '客户模式',
      desc: '预订宠物服务'
    },

    appVersion: '1.0.0'
  },

  onLoad() {
    console.log('[My] 我的页面加载');
    this.getSystemInfo();
    this.getCustomerInfo();
    this.loadUserInfo();
    this.updateMemberStatus();
    this.loadOrderStats();
    this.loadWalletInfo();
    this.updateCurrentRoleInfo();
  },

  // 获取系统信息
  getSystemInfo() {
    const app = getApp();
    const { statusBarHeight = 20, navBarHeight = 64 } = app.globalData.systemInfo || {};
    this.setData({
      statusBarHeight,
      navBarHeight
    });
  },

  onShow() {
    console.log('[My] 我的页面显示');

    // 更新tabBar选中状态
    if (typeof this.getTabBar === 'function' && this.getTabBar()) {
      this.getTabBar().updateSelected();
    }

    // 获取客户信息并更新全局状态
    this.getCustomerInfo();

    // 刷新用户信息和会员状态
    this.loadUserInfo();
    this.updateMemberStatus();
    this.updateCurrentRoleInfo();
  },

  onReady() {
    console.log('[My] 我的页面渲染完成');
    // 页面渲染完成后初始化滚动监听
    this.initScrollObserver();
  },

  onUnload() {
    // 页面销毁时清理观察器
    if (this.scrollObserver) {
      this.scrollObserver.disconnect();
      this.scrollObserver = null;
    }
  },

  // 构建头像显示URL
  getAvatarUrl(fileId) {
    if (!fileId) return '';
    if (/^https?:\/\//i.test(fileId)) {
      return fileId;
    }
    return getFilePreviewUrl(fileId);
  },

  // 获取客户信息
  async getCustomerInfo() {
    try {
      const token = AuthUtils.getToken();

      // 检查是否已登录
      if (!token) {
        console.log('[My] 用户未登录，跳过获取客户信息');
        return;
      }

      console.log('[My] 开始获取客户信息');
      const result = await request.post(API_ENDPOINTS.CUSTOMER.GET_INFO, {}, { loading: false });
      if (result && result.content) {
        const customerData = result.content;
        console.log('[My] 获取客户信息成功:', customerData);

        // 更新全局用户信息
        if (app && app.globalData && app.globalData.userInfo) {
          const avatarId = customerData.avatar || '';
          const avatarDisplay = avatarId ? this.getAvatarUrl(avatarId) : ( app.globalData.userInfo.avatarUrl || '');

          // 更新会员信息展示
          const levelArr = ['普通会员', '银卡会员', '金卡会员', '钻石会员'];
          const memberInfo = customerData.memberInfo || app.globalData.userInfo.memberInfo || {};

          this.setData({
            memberStatus: {
              level: levelArr[customerData.level] || '普通会员',
              levelColor: memberInfo.levelColor || '#999999',
              isVip: memberInfo.isVip !== undefined ? !!memberInfo.isVip : true,
              expireDate: memberInfo.expireDate || '',
              benefits: memberInfo.benefits || '享受基础服务',
              memberType: memberInfo.memberType || 'normal'
            }
          });

          const updatedUser = new User({
            ...app.globalData.userInfo,
            avatar: avatarId,
            avatarUrl: avatarDisplay,
            name: customerData.name,
            memberInfo: memberInfo
          });

          updatedUser.save();

          console.log('[My] 全局用户信息已更新');
        }
      }
    } catch (error) {
      console.error('[My] 获取客户信息失败:', error);
    }
  },

  // 从全局状态加载用户信息
  loadUserInfo() {
    try {
      console.log('[My] 从全局状态加载用户信息');

      const app = getApp();
      const globalUserInfo = app?.globalData?.userInfo;
      const token = AuthUtils.getToken() || '';

      // 如果没有全局用户信息或token，显示未登录状态
      if (!globalUserInfo || !token || !globalUserInfo.phone) {
        console.log('[My] 用户未登录 - 缺少全局用户信息');
        this.setData({
          userInfo: {
            name: '',
            avatarUrl: '',
            phone: '',
            loginTime: '',
            token: ''
          }
        });
        return;
      }

      // 格式化登录时间
      let formattedLoginTime = '';
      if (globalUserInfo.loginTime) {
        const loginDate = new Date(globalUserInfo.loginTime);
        formattedLoginTime = `${loginDate.getFullYear()}-${(loginDate.getMonth() + 1).toString().padStart(2, '0')}-${loginDate.getDate().toString().padStart(2, '0')} ${loginDate.getHours().toString().padStart(2, '0')}:${loginDate.getMinutes().toString().padStart(2, '0')}`;
      }
      const pageUserInfo = {
        name: globalUserInfo.name || '',
        avatarUrl: globalUserInfo.avatarUrl,
        phone: globalUserInfo.phone || '',
        displayPhone: globalUserInfo.displayPhone || '',
        loginTime: formattedLoginTime,
        token: token
      };

      // 构建头像显示URL
      const avatarDisplayUrl = globalUserInfo.avatarUrl;

      this.setData({
        userInfo: pageUserInfo,
        avatarDisplayUrl: avatarDisplayUrl
      });
      console.log('[My] 页面数据设置完成（来自全局状态）:', pageUserInfo);

      // 加载认证状态
      this.loadVerificationStatus(globalUserInfo.phone);

    } catch (error) {
      console.error('[My] 加载用户信息失败:', error);
    }
  },

  // 更新会员状态
  updateMemberStatus() {
    const app = getApp();
    const userInfo = app?.globalData?.userInfo;
    let memberStatus = {
      level: '普通会员',
      levelColor: '#999999',
      isVip: false,
      expireDate: '',
      benefits: '享受基础服务',
      memberType: 'normal'
    };

    if (userInfo && userInfo.phone) {
      // 根据用户数据模拟会员状态
      const random = Math.random();
      if (random > 0.8) {
        memberStatus = {
          level: '钻石会员',
          levelColor: '#E6E6FA',
          isVip: true,
          expireDate: '2024-12-31',
          benefits: '5%折扣 + 专属客服',
          memberType: 'diamond'
        };
      } else if (random > 0.6) {
        memberStatus = {
          level: '金卡会员',
          levelColor: '#FFD700',
          isVip: true,
          expireDate: '2024-12-31',
          benefits: '2%折扣 + 优先客服',
          memberType: 'gold'
        };
      } else if (random > 0.3) {
        memberStatus = {
          level: '银卡会员',
          levelColor: '#C0C0C0',
          isVip: true,
          expireDate: '2024-08-31',
          benefits: '专享优惠券',
          memberType: 'silver'
        };
      }
    }

    this.setData({ memberStatus });
  },

  // 加载认证状态
  loadVerificationStatus(phone) {
    if (!phone) {
      this.setData({
        verificationStatus: {
          isVerified: false,
          level: 'none',
          statusText: '未认证'
        }
      });
      return;
    }

    try {
      // 由于没有身份认证功能，直接设置默认状态
      let verificationStatus = {
        isVerified: false,
        level: 'none',
        statusText: '未认证'
      };

      this.setData({ verificationStatus });
      console.log('[My] 认证状态设置为默认:', verificationStatus);

    } catch (error) {
      console.error('[My] 加载认证状态失败:', error);
    }
  },

  // 加载订单统计
  loadOrderStats() {
    // 模拟订单数据
    this.setData({
      orderStats: {
        total: 12,
        pendingPayment: 1,
        pendingStart: 2,
        pendingReview: 3,
        refundAfterSale: 0
      }
    });
  },

  // 加载钱包信息
  loadWalletInfo() {
    // 模拟钱包数据
    this.setData({
      walletInfo: {
        balance: 156.80,
        hasInsurance: true,
        insuranceType: '宠物安心保障'
      }
    });
  },

  // 设置按钮点击
  onSettingTap() {
    wx.showActionSheet({
      itemList: ['编辑资料', '账户设置', '隐私设置', '通知设置', '帮助中心'],
      success: (res) => {
        const options = ['编辑资料', '账户设置', '隐私设置', '通知设置', '帮助中心'];
        const selectedOption = options[res.tapIndex];

        switch (selectedOption) {
          case '编辑资料':
            wx.navigateTo({
              url: '/packageUser/pages/user-profile/user-profile'
            }).catch(() => {
              wx.showToast({
                title: '编辑资料页面开发中',
                icon: 'none'
              });
            });
            break;
          case '账户设置':
            this.showAccountInfo();
            break;
          case '隐私设置':
            this.onPrivacySetting();
            break;
          case '通知设置':
            wx.showToast({
              title: '通知设置页面开发中',
              icon: 'none'
            });
            break;
          case '帮助中心':
            this.onHelp();
            break;
        }
      }
    });
  },

  // 会员信息点击
  onMemberTap() {
    const app = getApp();
    const userInfo = app?.globalData?.userInfo;
    if (!userInfo || !userInfo.phone) {
      this.showLoginPrompt();
      return;
    }

    this.showMemberInfo();
  },

  // 功能模块点击事件
  onFeatureModuleTap(e) {
    const { route } = e.currentTarget.dataset;
    const app = getApp();
    const userInfo = app?.globalData?.userInfo;

    // 检查是否需要登录
    if (!userInfo || !userInfo.phone) {
      this.showLoginPrompt();
      return;
    }

    if (route) {
      wx.navigateTo({
        url: route
      }).catch(() => {
        wx.showToast({
          title: '页面开发中',
          icon: 'none'
        });
      });
    } else {
      wx.showToast({
        title: '功能开发中',
        icon: 'none'
      });
    }
  },

  // 订单状态点击
  onOrderStatusTap(e) {
    const { status } = e.currentTarget.dataset;
    const app = getApp();
    const userInfo = app?.globalData?.userInfo;

    if (!userInfo || !userInfo.phone) {
      this.showLoginPrompt();
      return;
    }

    let url = '/packageUser/pages/orders/orders';
    if (status && status !== 'all') {
      url += `?status=${status}`;
    }

    wx.navigateTo({ url }).catch(() => {
      wx.showToast({
        title: '订单页面开发中',
        icon: 'none'
      });
    });
  },

  // 钱包相关点击
  onWalletTap(e) {
    console.log('[My] 钱包点击事件触发', e.currentTarget.dataset);
    const { type } = e.currentTarget.dataset;
    const app = getApp();
    const userInfo = app?.globalData?.userInfo;

    if (!userInfo || !userInfo.phone) {
      this.showLoginPrompt();
      return;
    }

    switch (type) {
      case 'balance':
        wx.navigateTo({
          url: '/packageUser/pages/wallet/wallet'
        }).catch(() => {
          wx.showToast({
            title: '钱包功能开发中',
            icon: 'none'
          });
        });
        break;
      case 'insurance':
        this.showInsuranceInfo();
        break;
      default:
        wx.showToast({
          title: '功能开发中',
          icon: 'none'
        });
    }
  },

  // 平台规则点击
  onPlatformRulesTap() {
    wx.navigateTo({
      url: '/packageUser/pages/platform-rules/platform-rules'
    }).catch(() => {
      wx.showToast({
        title: '页面开发中',
        icon: 'none'
      });
    });
  },

  // 跳转到登录页面
  onGoLogin() {
    wx.navigateTo({
      url: '/pages/login/login'
    });
  },

  // 手动刷新用户信息（调试用）
  onRefreshUserInfo() {
    console.log('[My] 手动刷新用户信息');
    this.loadUserInfo();
    this.updateMemberStatus();

    wx.showToast({
      title: '已刷新用户信息',
      icon: 'success'
    });
  },

  // 完善个人信息
  onEditProfile() {
    const userInfo = app?.globalData?.userInfo;
    if (!userInfo || !userInfo.phone) {
      this.showLoginPrompt();
      return;
    }

    wx.navigateTo({
      url: '/packageUser/pages/user-profile/user-profile'
    }).catch(() => {
      wx.showToast({
        title: '编辑资料页面开发中',
        icon: 'none'
      });
    });
  },

  // 绑定手机号
  async onBindPhone() {
    try {
      // 直接调用获取手机号
      wx.showModal({
        title: '绑定手机号',
        content: '请点击确定后授权获取手机号',
        success: (res) => {
          if (res.confirm) {
            // 这里应该弹出手机号授权
            wx.showToast({
              title: '请在登录页面完成绑定',
              icon: 'none'
            });

            setTimeout(() => {
              wx.navigateTo({
                url: '/pages/login/login'
              });
            }, 1500);
          }
        }
      });
    } catch (error) {
      console.error('[My] 绑定手机号失败:', error);
    }
  },

  // 显示会员信息
  showMemberInfo() {
    wx.showActionSheet({
      itemList: ['查看会员权益', '升级会员', '会员中心'],
      success: (res) => {
        switch (res.tapIndex) {
          case 0:
            this.showMemberBenefits();
            break;
          case 1:
            this.upgradeMember();
            break;
          case 2:
            wx.navigateTo({
              url: '/packageUser/pages/member-center/member-center'
            }).catch(() => {
              wx.showToast({
                title: '会员中心开发中',
                icon: 'none'
              });
            });
            break;
        }
      }
    });
  },

  // 显示会员权益
  showMemberBenefits() {
    const { memberStatus } = this.data;
    let benefits = '';

    switch (memberStatus.memberType) {
      case 'normal':
        benefits = '• 下单享基础保障\n• 平台统一提供服务';
        break;
      case 'silver':
        benefits = '• 每月赠送2张5元优惠券\n• 客服24小时内响应\n• 享受基础保障';
        break;
      case 'gold':
        benefits = '• 每月赠送3张10元优惠券\n• 下单享受2%折扣\n• 投诉/纠纷优先处理\n• 客服12小时内响应';
        break;
      case 'diamond':
        benefits = '• 每月赠送5张20元优惠券\n• 下单享受5%折扣\n• 专属客服通道\n• 即时人工客服';
        break;
    }

    wx.showModal({
      title: `${memberStatus.level}权益`,
      content: benefits,
      showCancel: false,
      confirmText: '我知道了'
    });
  },

  // 升级会员
  upgradeMember() {
    wx.showModal({
      title: '升级会员',
      content: '升级会员可享受更多专属权益和折扣优惠，是否前往会员中心？',
      confirmText: '立即升级',
      cancelText: '取消',
      success: (res) => {
        if (res.confirm) {
          wx.navigateTo({
            url: '/packageUser/pages/member-center/member-center'
          }).catch(() => {
            wx.showToast({
              title: '会员中心开发中',
              icon: 'none'
            });
          });
        }
      }
    });
  },

  // 显示保险信息
  showInsuranceInfo() {
    const { walletInfo } = this.data;

    wx.showModal({
      title: '宠物保险',
      content: `保险状态：${walletInfo.hasInsurance ? '已投保' : '未投保'}\n${walletInfo.hasInsurance ? `保险类型：${walletInfo.insuranceType}\n保障上限：5000元\n适用范围：平台内所有订单` : '建议为您的爱宠投保，保障更安心'}`,
      confirmText: walletInfo.hasInsurance ? '查看详情' : '立即投保',
      cancelText: '取消',
      success: (res) => {
        if (res.confirm) {
          wx.navigateTo({
            url: '/packageUser/pages/insurance/insurance'
          }).catch(() => {
            wx.showToast({
              title: '保险功能开发中',
              icon: 'none'
            });
          });
        }
      }
    });
  },

  // 联系客服
  contactService() {
    const app = getApp();
    const userInfo = app?.globalData?.userInfo;
    const isVip = userInfo && this.data.memberStatus.isVip;

    const itemList = isVip ?
      ['专属客服', '在线客服', '电话客服', '意见反馈'] :
      ['在线客服', '电话客服', '意见反馈'];

    wx.showActionSheet({
      itemList,
      success: (res) => {
        const baseOptions = ['在线客服', '电话客服', '意见反馈'];
        const selectedOption = isVip ?
          (res.tapIndex === 0 ? '专属客服' : baseOptions[res.tapIndex - 1]) :
          baseOptions[res.tapIndex];

        switch (selectedOption) {
          case '专属客服':
          case '在线客服':
            wx.navigateTo({
              url: '/packageUser/pages/customer-service/customer-service'
            }).catch(() => {
              wx.showToast({
                title: '客服功能开发中',
                icon: 'none'
              });
            });
            break;
          case '电话客服':
            wx.makePhoneCall({
              phone: '400-123-4567',
              fail: () => {
                wx.showToast({
                  title: '拨号失败',
                  icon: 'none'
                });
              }
            });
            break;
          case '意见反馈':
            this.onFeedback();
            break;
        }
      }
    });
  },

  // 显示账户信息
  showAccountInfo() {
    const { userInfo } = this.data;
    wx.showModal({
      title: '账户信息',
      content: `昵称：${userInfo.name || '未设置'}\n手机号：${userInfo.phone || '未绑定'}\n注册时间：${userInfo.loginTime || '未知'}`,
      confirmText: '编辑资料',
      cancelText: '取消',
      success: (res) => {
        if (res.confirm) {
          this.onEditProfile();
        }
      }
    });
  },

  // 申请成为服务者
  applyProvider() {
    // 先检查全局登录状态
    const app = getApp();
    const userInfo = app?.globalData?.userInfo;
    if (!userInfo || !userInfo.phone) {
      this.showLoginPrompt();
      return;
    }

    const user = User.load();

    // 检查用户是否已经是服务者
    if (user && user.isProvider()) {
      this.showProviderOptions(user);
      return;
    }

    wx.showModal({
      title: '成为服务者',
      content: '成为服务者可以为其他用户提供宠物护理服务，并获得相应收益。\n\n申请条件：\n1. 实名认证\n2. 宠物护理相关经验\n3. 通过平台审核\n\n是否提交申请？',
      confirmText: '立即申请',
      cancelText: '取消',
      success: (res) => {
        if (res.confirm) {
          wx.navigateTo({
            url: '/packageProvider/pages/provider-application/provider-application'
          });
        }
      }
    });
  },

  // 显示服务者选项
  showProviderOptions(user) {
    const status = user.providerInfo.status;
    let title = '服务者中心';
    let content = '';
    let showRoleSwitch = false;

    switch (status) {
      case 'pending':
        content = '您的服务者申请正在审核中，预计1-3个工作日完成。';
        break;
      case 'approved':
        content = '您已是认证服务者！选择您要使用的模式：';
        showRoleSwitch = true;
        break;
      case 'rejected':
        content = '很遗憾，您的服务者申请未通过审核。是否重新申请？';
        break;
      default:
        content = '服务者状态异常，请联系客服。';
    }

    if (showRoleSwitch) {
      wx.showActionSheet({
        itemList: ['切换到服务者模式', '查看服务者设置', '切换到客户模式'],
        success: (res) => {
          switch (res.tapIndex) {
            case 0:
              this.switchToProviderMode(user);
              break;
            case 1:
              wx.navigateTo({
                url: '/packageProvider/pages/provider-profile/provider-profile'
              });
              break;
            case 2:
              this.switchToCustomerMode(user);
              break;
          }
        }
      });
    } else {
      const actionText = status === 'rejected' ? '重新申请' : '查看详情';
      wx.showModal({
        title,
        content,
        confirmText: actionText,
        cancelText: '取消',
        success: (res) => {
          if (res.confirm) {
            if (status === 'rejected') {
              wx.navigateTo({
                url: '/packageProvider/pages/provider-application/provider-application?mode=reapply'
              });
            } else {
              wx.navigateTo({
                url: '/packageProvider/pages/provider-profile/provider-profile'
              });
            }
          }
        }
      });
    }
  },

  // 切换到服务者模式
  async switchToProviderMode(user) {
    // 临时注释掉权限检查，直接允许切换
    // if (!user.canAcceptOrders()) {
    //   wx.showToast({
    //     title: '您还不是认证服务者',
    //     icon: 'none'
    //   });
    //   return;
    // }

    try {
      // 更新用户角色
      user.userType = 'provider';
      user.save(); // save()方法已经会自动更新全局状态

      // 独立保存用户类型到本地存储
      wx.setStorageSync('userType', 'provider');

      console.log('[My] 全局状态已更新为服务者模式:', user.userType);

      // 刷新所有页面的tabbar
      const pages = getCurrentPages();
      pages.forEach(page => {
        if (page.getTabBar && page.getTabBar()) {
          page.getTabBar().switchToRole('provider');
        }
      });

      // 更新当前页面的角色信息显示
      this.updateCurrentRoleInfo();

      wx.showToast({
        title: '已切换到服务者模式',
        icon: 'success'
      });

      console.log('[My] 服务者模式切换完成');

    } catch (error) {
      console.error('[My] 切换到服务者模式失败:', error);
      wx.showToast({
        title: '切换失败，请重试',
        icon: 'none'
      });
    }
  },

  // 切换到客户模式
  async switchToCustomerMode(user) {
    try {
      // 更新用户角色
      user.userType = 'customer';
      user.save(); // save()方法已经会自动更新全局状态

      // 独立保存用户类型到本地存储
      wx.setStorageSync('userType', 'customer');

      console.log('[My] 全局状态已更新为客户模式:', user.userType);

      // 刷新所有页面的tabbar
      const pages = getCurrentPages();
      pages.forEach(page => {
        if (page.getTabBar && page.getTabBar()) {
          page.getTabBar().switchToRole('customer');
        }
      });

      // 更新当前页面的角色信息显示
      this.updateCurrentRoleInfo();

      wx.showToast({
        title: '已切换到客户模式',
        icon: 'success'
      });

      console.log('[My] 客户模式切换完成');

    } catch (error) {
      console.error('[My] 切换到客户模式失败:', error);
      wx.showToast({
        title: '切换失败，请重试',
        icon: 'none'
      });
    }
  },

  // 隐私设置
  onPrivacySetting() {
    wx.showActionSheet({
      itemList: ['个人信息授权管理', '数据使用设置', '隐私协议', '注销账号'],
      success: (res) => {
        const options = ['个人信息授权管理', '数据使用设置', '隐私协议', '注销账号'];
        const selectedOption = options[res.tapIndex];

        switch (selectedOption) {
          case '个人信息授权管理':
            wx.showModal({
              title: '个人信息授权',
              content: '您可以管理头像、昵称、手机号等信息的授权状态。',
              showCancel: false,
              confirmText: '我知道了'
            });
            break;
          case '数据使用设置':
            wx.showModal({
              title: '数据使用设置',
              content: '您可以设置是否允许使用您的数据来改善服务体验。',
              showCancel: false,
              confirmText: '我知道了'
            });
            break;
          case '隐私协议':
            wx.showModal({
              title: '隐私协议',
              content: '请查看我们的隐私政策了解数据处理详情。',
              confirmText: '查看协议',
              cancelText: '取消',
              success: (res) => {
                if (res.confirm) {
                  this.onPlatformRulesTap();
                }
              }
            });
            break;
          case '注销账号':
            wx.showModal({
              title: '注销账号',
              content: '注销账号将删除您的所有数据且无法恢复，确定要继续吗？',
              confirmText: '确认注销',
              cancelText: '取消',
              confirmColor: '#ff4757',
              success: (res) => {
                if (res.confirm) {
                  wx.showToast({
                    title: '注销功能开发中',
                    icon: 'none'
                  });
                }
              }
            });
            break;
        }
      }
    });
  },

  // 消息中心
  onMessageCenter() {
    if (!this.data.userInfo.phone) {
      this.showLoginPrompt();
      return;
    }

    wx.showToast({
      title: '功能开发中',
      icon: 'none'
    });
  },

  // 主题设置
  onThemeSetting() {
    wx.showActionSheet({
      itemList: ['浅色主题', '深色主题', '跟随系统'],
      success: (res) => {
        const themes = ['浅色主题', '深色主题', '跟随系统'];
        wx.showToast({
          title: `已切换到${themes[res.tapIndex]}`,
          icon: 'success'
        });
      }
    });
  },

  // 通知设置开关
  onNotificationToggle(e) {
    const enabled = e.detail.value;
    this.setData({
      notificationEnabled: enabled
    });

    wx.showToast({
      title: enabled ? '通知已开启' : '通知已关闭',
      icon: 'success'
    });
  },
  onFeatureModules(e){
    console.log(e.currentTarget.dataset.route);
    const url = e.currentTarget.dataset.route;
    wx.navigateTo({
      url: url
    });

  },

  // 语言设置
  onLanguageSetting() {
    wx.showActionSheet({
      itemList: ['简体中文', 'English', '繁體中文'],
      success: (res) => {
        const languages = ['简体中文', 'English', '繁體中文'];
        wx.showToast({
          title: `语言已切换到${languages[res.tapIndex]}`,
          icon: 'success'
        });
      }
    });
  },

  // 帮助中心
  onHelp() {
    wx.showActionSheet({
      itemList: ['常见问题', '使用教程', '联系客服', '意见反馈', '关于我们'],
      success: (res) => {
        const options = ['常见问题', '使用教程', '联系客服', '意见反馈', '关于我们'];
        const selectedOption = options[res.tapIndex];

        switch (selectedOption) {
          case '常见问题':
            wx.showModal({
              title: '常见问题',
              content: '1. 如何预订宠物看护服务？\n2. 如何申请成为看护师？\n3. 订单可以取消吗？\n4. 如何联系看护师？',
              showCancel: false,
              confirmText: '我知道了'
            });
            break;
          case '使用教程':
            wx.showToast({
              title: '使用教程页面开发中',
              icon: 'none'
            });
            break;
          case '联系客服':
            this.contactService();
            break;
          case '意见反馈':
            this.onFeedback();
            break;
          case '关于我们':
            this.onAbout();
            break;
        }
      }
    });
  },

  // 意见反馈
  onFeedback() {
    wx.showActionSheet({
      itemList: ['功能建议', '服务投诉', '问题反馈', '表扬建议'],
      success: (res) => {
        const options = ['功能建议', '服务投诉', '问题反馈', '表扬建议'];
        const feedbackType = options[res.tapIndex];

        wx.showModal({
          title: `${feedbackType}`,
          content: `感谢您选择${feedbackType}！\n\n请通过以下方式联系我们：\n• 在线客服（推荐）\n• 电话：400-123-4567\n• 邮箱：feedback@chongxin.com\n\n我们会在24小时内回复您的反馈。`,
          confirmText: '联系客服',
          cancelText: '取消',
          success: (res) => {
            if (res.confirm) {
              this.contactService();
            }
          }
        });
      }
    });
  },

  // 关于我们
  onAbout() {
    wx.showModal({
      title: '关于宠信',
      content: `宠信 v${this.data.appVersion}\n\n专业的宠物看护服务平台，致力于让宠物的生活变得更安全、更美好。\n\n核心服务：\n• 专业宠物看护师认证\n• 宠物寄养托管服务\n• 宠物保险保障\n• 24小时客服支持\n\n© 2024 宠信科技\n保留所有权利`,
      showCancel: false,
      confirmText: '我知道了'
    });
  },

  // 退出登录
  onLogout() {
    wx.showModal({
      title: '退出登录',
      content: '确定要退出登录吗？退出后您将需要重新登录才能使用完整功能。',
      confirmText: '确定退出',
      cancelText: '取消',
      success: async (res) => {
        if (res.confirm) {
          try {
            // 调用认证服务退出登录
            const result = await authService.logout();

            if (result.success) {
              // 清除页面数据
              this.setData({
                userInfo: {
                  name: '',
                  avatarUrl: '',
                  phone: '',
                  loginTime: '',
                  token: ''
                },
                loginStatusText: '未登录',
                stats: {
                  orders: 0,
                  services: 0,
                  pets: 0,
                  points: 0
                }
              });

              // 更新全局状态
              app.globalData.needLogin = true;

              wx.showToast({
                title: '退出登录成功',
                icon: 'success'
              });

              console.log('[My] 退出登录成功');
            } else {
              throw new Error(result.error || '退出登录失败');
            }

          } catch (error) {
            console.error('[My] 退出登录失败:', error);
            wx.showToast({
              title: '退出失败，请重试',
              icon: 'none'
            });
          }
        }
      }
    });
  },

  // 显示登录提示
  showLoginPrompt() {
    wx.showModal({
      title: '需要登录',
      content: '此功能需要登录后才能使用，是否立即前往登录？',
      confirmText: '去登录',
      cancelText: '取消',
      success: (res) => {
        if (res.confirm) {
          wx.navigateTo({
            url: '/pages/login/login'
          });
        }
      }
    });
  },

  // 导航栏就绪事件
  onNavBarReady(e) {
    const { totalHeight } = e.detail;
    console.log('导航栏总高度:', totalHeight);
    this.setData({
      navBarHeight: totalHeight
    });
  },

  // 导航栏滚动变色事件
  onNavScrollChange(e) {
    const { isScrolled } = e.detail;
    console.log('导航栏滚动状态:', isScrolled ? '已变色' : '默认状态');

    // 可以在这里添加其他需要同步变化的逻辑
    // 比如状态栏颜色、页面背景色等
  },

  // 初始化滚动观察器
  initScrollObserver() {
    try {
      // 创建 intersection observer
      this.scrollObserver = this.createIntersectionObserver({
        thresholds: [0, 1],
        initialRatio: 1
      });

      // 设置视窗区域（相对于视窗顶部）
      this.scrollObserver.relativeToViewport({
        top: 0,
        bottom: 0
      }).observe('.scroll-sentinel', (res) => {
        console.log('影子元素可见性变化:', res.intersectionRatio);

        // 当影子元素完全不可见时，说明页面滚动超过了阈值
        const isScrolled = res.intersectionRatio === 0;

        // 获取导航栏组件实例并更新状态
        const navBar = this.selectComponent('#main-nav-bar');
        console.log('导航栏组件实例:', navBar);

        if (navBar && navBar.setScrolled) {
          navBar.setScrolled(isScrolled);
          console.log('导航栏滚动状态已更新:', isScrolled);
        } else {
          console.warn('无法获取导航栏组件实例或setScrolled方法不存在');
        }
      });

      console.log('滚动观察器初始化成功');
    } catch (error) {
      console.error('初始化滚动观察器失败:', error);
    }
  },

  // 下拉刷新
  onPullDownRefresh() {
    console.log('[My] 下拉刷新');

    // 刷新用户信息
    this.loadUserInfo();
    this.updateMemberStatus();
    this.loadOrderStats();
    this.loadWalletInfo();

    // 停止下拉刷新
    setTimeout(() => {
      wx.stopPullDownRefresh();
    }, 1000);
  },

  // 页面分享
  onShareAppMessage() {
    return {
      title: '宠信 - 专业的宠物看护服务平台',
      path: '/pages/home/home',
      imageUrl: '/assets/launch.png'
    };
  },

  // 页面分享到朋友圈
  onShareTimeline() {
    return {
      title: '宠信 - 让宠物的生活变得更安全',
      imageUrl: '/assets/launch.png'
    };
  },

  // 更新当前角色信息
  updateCurrentRoleInfo() {
    try {
      const app = getApp();
      const globalUserInfo = app?.globalData?.userInfo;

      // 从全局状态或本地存储中获取用户类型
      const userType = globalUserInfo?.userType || wx.getStorageSync('userType') || 'customer';

      let roleInfo = {
        icon: '/assets/tabbar/home.png',
        title: '客户模式',
        desc: '预订宠物服务'
      };

      if (userType === 'provider') {
        roleInfo = {
          icon: '/assets/tabbar/services.png',
          title: '看护师模式',
          desc: '提供宠物服务'
        };
      }

      this.setData({
        currentRoleInfo: roleInfo
      });

      console.log('[My] 当前角色信息已更新:', userType, roleInfo);
    } catch (error) {
      console.error('[My] 更新角色信息失败:', error);
    }
  },

  // 角色切换按钮点击
  onRoleSwitchTap() {
    // 先检查全局登录状态
    const app = getApp();
    const userInfo = app?.globalData?.userInfo;
    if (!userInfo || !userInfo.phone) {
      this.showLoginPrompt();
      return;
    }

    // 需要User对象进行角色切换操作
    const user = User.load();

    // 临时注释掉服务者资格检查，直接允许切换
    // if (!user.isProvider() || user.providerInfo?.status !== 'approved') {
    //   // 显示申请成为服务者的选项
    //   wx.showModal({
    //     title: '角色切换',
    //     content: '您还不是认证看护师，需要先申请成为看护师才能切换到服务者模式。\n\n申请条件：\n• 身份认证\n• 相关经验证明\n• 通过平台审核',
    //     confirmText: '立即申请',
    //     cancelText: '取消',
    //     success: (res) => {
    //       if (res.confirm) {
    //         wx.navigateTo({
    //           url: '/packageProvider/pages/provider-application/provider-application'
    //         }).catch(() => {
    //           wx.showToast({
    //             title: '页面开发中',
    //             icon: 'none'
    //           });
    //         });
    //       }
    //     }
    //   });
    //   return;
    // }

    // 获取当前用户角色，直接切换
    const currentUserType = user.userType || 'customer';
    const isCurrentlyProvider = currentUserType === 'provider';

    // 直接切换角色，不显示选项
    if (isCurrentlyProvider) {
      this.switchToCustomerMode(user);
    } else {
      this.switchToProviderMode(user);
    }
  },

  // 阻止事件冒泡的空方法
  stopPropagation() {
    // 空方法，用于catchtap=""
  }
});
