class ApiConfig {
  const ApiConfig._();

  static const String defaultVersion = 'v1';
  static const Duration defaultTimeout = Duration(milliseconds: 10000);
  static const bool useMock = false;
  static const bool devMode = false;
  static const String defaultBasePath = '/api';

  static const DevUserConfig devUser = DevUserConfig(
    token: 'dev_token_123456',
    name: '开发测试用户',
    avatar: '',
    avatarUrl: '',
    phone: '13800138000',
    displayPhone: '138****8000',
    userType: 'customer',
    isVerified: false,
  );

  static String prefix(String path, {String? version}) {
    final resolvedVersion = version ?? defaultVersion;
    return '$defaultBasePath/$resolvedVersion$path';
  }
}

class DevUserConfig {
  const DevUserConfig({
    required this.token,
    required this.name,
    required this.avatar,
    required this.avatarUrl,
    required this.phone,
    required this.displayPhone,
    required this.userType,
    required this.isVerified,
  });

  final String token;
  final String name;
  final String avatar;
  final String avatarUrl;
  final String phone;
  final String displayPhone;
  final String userType;
  final bool isVerified;
}

class ApiPath {
  const ApiPath(this.pattern);

  final String pattern;

  String path({String? version}) {
    return ApiConfig.prefix(pattern, version: version);
  }

  String resolve(
    String baseUrl, {
    Map<String, Object?> params = const {},
    String? version,
  }) {
    final resolved = _fillParams(path(version: version), params);
    return '$baseUrl$resolved';
  }

  static String _fillParams(String url, Map<String, Object?> params) {
    if (params.isEmpty) {
      return url;
    }
    return url.replaceAllMapped(_placeholderPattern, (match) {
      final key = match[1];
      if (key == null) {
        return '';
      }
      final value = params[key];
      return Uri.encodeComponent(value?.toString() ?? '');
    });
  }
}

final RegExp _placeholderPattern = RegExp(r'{(\w+)}');

class AuthEndpoints {
  const AuthEndpoints._();

  static const ApiPath register = ApiPath('/auth/wechat/register');
  static const ApiPath login = ApiPath('/auth/wechat/login');
  static const ApiPath userInfo = ApiPath('/auth/user/info');
  static const ApiPath logout = ApiPath('/auth/logout');
  static const ApiPath phoneGetCode = ApiPath('/auth/phone/getCode');
  static const ApiPath phoneLogin = ApiPath('/auth/phone/login');
  static const ApiPath changePhone = ApiPath('/auth/phone/change');
  static const ApiPath validateToken = ApiPath('/auth/validate-token');
  static const ApiPath updateProfile = ApiPath('/auth/update-profile');
}

class IdentityEndpoints {
  const IdentityEndpoints._();

  static const ApiPath status = ApiPath('/identity/status');
  static const ApiPath submitIdCard = ApiPath('/identity/submit-idcard');
  static const ApiPath submitFinal = ApiPath('/identity/submit-final');
  static const ApiPath ocr = ApiPath('/identity/ocr');
  static const ApiPath verification = ApiPath('/auth/identity/verify');
  static const ApiPath faceVerification = ApiPath('/auth/face/verify');
  static const ApiPath uploadIdCard = ApiPath('/auth/identity/upload');
  static const ApiPath faceVerificationInit = ApiPath(
    '/identity/face-verification/init',
  );
  static const ApiPath faceVerificationResult = ApiPath(
    '/identity/face-verification/result',
  );
  static const ApiPath faceVerificationStatus = ApiPath(
    '/identity/face-verification/status',
  );
}

class HomeEndpoints {
  const HomeEndpoints._();

  static const ApiPath bannerList = ApiPath('/home/banners');
  static const ApiPath serviceProviders = ApiPath('/home/providers');
  static const ApiPath searchSuggestions = ApiPath('/search/suggestions');
  static const ApiPath searchProviders = ApiPath('/search/providers');
}

class ProviderEndpoints {
  const ProviderEndpoints._();

  static const ApiPath detail = ApiPath('/providers');
  static const ApiPath reviews = ApiPath('/providers/{id}/reviews');
  static const ApiPath gallery = ApiPath('/providers/{id}/gallery');
  static const ApiPath favorite = ApiPath('/providers/{id}/favorite');
}

class FavoritesEndpoints {
  const FavoritesEndpoints._();

  static const ApiPath providers = ApiPath('/favorites/providers');
}

class OrderEndpoints {
  const OrderEndpoints._();

  static const ApiPath list = ApiPath('/orders');
  static const ApiPath detail = ApiPath('/orders');
  static const ApiPath create = ApiPath('/orders');
  static const ApiPath cancel = ApiPath('/orders');
  static const ApiPath chat = ApiPath('/orders');
  static const ApiPath sendMessage = ApiPath('/orders/message');
}

class UserEndpoints {
  const UserEndpoints._();

  static const ApiPath addresses = ApiPath('/user/addresses');
  static const ApiPath pets = ApiPath('/user/pets');
  static const ApiPath coupons = ApiPath('/user/coupons');
}

class CustomerEndpoints {
  const CustomerEndpoints._();

  static const ApiPath getInfo = ApiPath('/customer/detailCustomerInfo');
  static const ApiPath editInfo = ApiPath('/customer/updateCustomerInfo');
}

class PetEndpoints {
  const PetEndpoints._();

  static const ApiPath create = ApiPath('/pet/createPetInfo');
  static const ApiPath update = ApiPath('/pet/createPetInfo');
  static const ApiPath delete = ApiPath('/petInfo/deleteDeleteByPetId');
  static const ApiPath getById = ApiPath('/petInfo/getPetInfoByPetId');
  static const ApiPath listByUser = ApiPath(
    '/petInfo/listPetInfoEntityByUserId',
  );
  static const ApiPath pageQuery = ApiPath(
    '/petInfo/pagePetInfoEntityByMoreCondition',
  );
  static const ApiPath batchDelete = ApiPath(
    '/petInfo/batchDeletePetInfoEntity',
  );
}

class LibraryEndpoints {
  const LibraryEndpoints._();

  static const ApiPath breeds = ApiPath('/lib/breeds/listAll');
}

class InsuranceEndpoints {
  const InsuranceEndpoints._();

  static const ApiPath options = ApiPath('/insurance/options');
}

class ServiceProviderEndpoints {
  const ServiceProviderEndpoints._();

  static const ApiPath application = ApiPath('/provider/application');
  static const ApiPath dashboard = ApiPath('/provider/dashboard');
  static const ApiPath orders = ApiPath('/provider/orders');
  static const ApiPath pendingOrders = ApiPath('/provider/orders/pending');
  static const ApiPath orderAccept = ApiPath('/provider/orders/accept');
  static const ApiPath orderReject = ApiPath('/provider/orders/reject');
  static const ApiPath orderComplete = ApiPath('/provider/orders/complete');
  static const ApiPath checkin = ApiPath('/provider/checkin');
  static const ApiPath checkout = ApiPath('/provider/checkout');
  static const ApiPath income = ApiPath('/provider/income');
  static const ApiPath withdraw = ApiPath('/provider/withdraw');
  static const ApiPath onlineStatus = ApiPath('/provider/status');
  static const ApiPath profile = ApiPath('/provider/profile');
}

class FileEndpoints {
  const FileEndpoints._();

  static const ApiPath upload = ApiPath('/lib/file/upload');
  static const ApiPath getInfo = ApiPath('/lib/file/getInfo');
  static const ApiPath download = ApiPath('/lib/file/download');
  static const ApiPath delete = ApiPath('/lib/file/del');
}

class AddressEndpoints {
  const AddressEndpoints._();

  static const ApiPath create = ApiPath('/address/create');
  static const ApiPath update = ApiPath('/address/update');
  static const ApiPath delete = ApiPath('/address/del');
  static const ApiPath get = ApiPath('/address/get');
  static const ApiPath list = ApiPath('/address/list');
  static const ApiPath setDefault = ApiPath('/address/setDefaultAddress');
  static const ApiPath getDefault = ApiPath('/address/default');
}

class ApiSuccessCode {
  const ApiSuccessCode._();

  static const int success = 10001;
  static const int querySuccess = 10002;
  static const Set<int> values = {success, querySuccess};
}

class ApiWarningCode {
  const ApiWarningCode._();

  static const int warning = 20001;
  static const int paramValidationError = 20002;
  static const int constraintViolation = 20003;
  static const int jsonFormatError = 20004;
  static const int productLimitReached = 20005;
  static const int operationLimitReached = 20006;
  static const int managementLimitReached = 20007;
  static const int noProductInfo = 20008;
  static const int invalidDataExists = 20009;
  static const int productNotSubscribable = 20010;
  static const int noViewPermission = 20011;
  static const int contentUnchanged = 20012;
  static const Set<int> values = {
    warning,
    paramValidationError,
    constraintViolation,
    jsonFormatError,
    productLimitReached,
    operationLimitReached,
    managementLimitReached,
    noProductInfo,
    invalidDataExists,
    productNotSubscribable,
    noViewPermission,
    contentUnchanged,
  };
}

class ApiUserErrorCode {
  const ApiUserErrorCode._();

  static const int operationFailed = 30001;
  static const int sessionExpired = 30002;
  static const int noPermission = 30003;
  static const int accountLoginElsewhere = 30004;
  static const int paramError = 30005;
  static const int operationTimeout = 30006;
  static const int illegalParam = 30007;
  static const int fileNotCompliant = 30008;
  static const int fileGenerationFailed = 30009;
  static const int tooManyRequests = 30010;
  static const int accountLocked = 30011;
  static const int accountAbnormal = 30012;
  static const int fileUploadFailed = 30013;
  static const int encryptionFailed = 30014;
  static const int userNotRegistered = 30015;
  static const int fileUploadError = 30016;
  static const int fileDownloadError = 30017;
  static const int fileNotFound = 30018;
  static const int fileDeleteError = 30019;
  static const Set<int> values = {
    operationFailed,
    sessionExpired,
    noPermission,
    accountLoginElsewhere,
    paramError,
    operationTimeout,
    illegalParam,
    fileNotCompliant,
    fileGenerationFailed,
    tooManyRequests,
    accountLocked,
    accountAbnormal,
    fileUploadFailed,
    encryptionFailed,
    userNotRegistered,
    fileUploadError,
    fileDownloadError,
    fileNotFound,
    fileDeleteError,
  };
}

class ApiSystemErrorCode {
  const ApiSystemErrorCode._();

  static const int unknownError = 50001;
  static const int emptyParamError = 50002;
  static const int logicError = 50003;
  static const int serviceUnavailable = 50004;
  static const Set<int> values = {
    unknownError,
    emptyParamError,
    logicError,
    serviceUnavailable,
  };
}

class ApiUnexpectedErrorCode {
  const ApiUnexpectedErrorCode._();

  static const int businessBusy = 70001;
  static const int codeNotFound = 70002;
  static const int paymentIdError = 70003;
  static const int paymentCallbackError = 70004;
  static const int paymentVerifyError = 70005;
  static const int wechatApiError = 70006;
  static const int wechatParamError = 70007;
  static const int wechatNotLogin = 70008;
  static const Set<int> values = {
    businessBusy,
    codeNotFound,
    paymentIdError,
    paymentCallbackError,
    paymentVerifyError,
    wechatApiError,
    wechatParamError,
    wechatNotLogin,
  };
}

class ApiStatusCode {
  const ApiStatusCode._();

  static const String successText = 'success';
  static const int success = ApiSuccessCode.success;
  static const int querySuccess = ApiSuccessCode.querySuccess;
  static const int tokenInvalid = ApiUserErrorCode.sessionExpired;
  static const int paramError = ApiUserErrorCode.paramError;
  static const int permissionDenied = ApiUserErrorCode.noPermission;
  static const int serverError = ApiSystemErrorCode.unknownError;
  static const int networkError = ApiSystemErrorCode.serviceUnavailable;
}

class ApiCodeMessages {
  const ApiCodeMessages._();

  static const Map<int, String> values = {
    ApiSuccessCode.success: '操作成功',
    ApiSuccessCode.querySuccess: '查询成功',
    ApiWarningCode.warning: '警告！',
    ApiWarningCode.paramValidationError: '参数校验错误！',
    ApiWarningCode.constraintViolation: '违反约束！',
    ApiWarningCode.jsonFormatError: '参数JSON格式错误',
    ApiWarningCode.productLimitReached: '可订阅产品数量已达到上限',
    ApiWarningCode.operationLimitReached: '可操作订阅数量已达到上限！',
    ApiWarningCode.managementLimitReached: '可管理订阅产品数量已达到上限',
    ApiWarningCode.noProductInfo: '文件未检测到任何可用的产品信息！',
    ApiWarningCode.invalidDataExists: '存在已失效的数据',
    ApiWarningCode.productNotSubscribable: '未匹配成功的产品不可订阅',
    ApiWarningCode.noViewPermission: '无查看权限',
    ApiWarningCode.contentUnchanged: '修改内容不能和原内容一致',
    ApiUserErrorCode.operationFailed: '操作失败',
    ApiUserErrorCode.sessionExpired: '会话失效，请重新登录',
    ApiUserErrorCode.noPermission: '您还没有权限哦',
    ApiUserErrorCode.accountLoginElsewhere: '账号已在其它地方登录',
    ApiUserErrorCode.paramError: '参数错误',
    ApiUserErrorCode.operationTimeout: '操作超时',
    ApiUserErrorCode.illegalParam: '非法参数',
    ApiUserErrorCode.fileNotCompliant: '文件不符合规范',
    ApiUserErrorCode.fileGenerationFailed: '生成文件失败，请联系客服',
    ApiUserErrorCode.tooManyRequests: '请求太多，请稍后重试',
    ApiUserErrorCode.accountLocked: '账户当前已被锁定',
    ApiUserErrorCode.accountAbnormal: '账号当前处于异常状态',
    ApiUserErrorCode.fileUploadFailed: '上传文件失败，请联系客服',
    ApiUserErrorCode.encryptionFailed: '加解密失败',
    ApiUserErrorCode.userNotRegistered: '该用户尚未注册',
    ApiUserErrorCode.fileUploadError: '文件上传失败',
    ApiUserErrorCode.fileDownloadError: '文件下载失败',
    ApiUserErrorCode.fileNotFound: '文件未找到',
    ApiUserErrorCode.fileDeleteError: '文件删除失败',
    ApiSystemErrorCode.unknownError: '服务器未知错误',
    ApiSystemErrorCode.emptyParamError: '传入参数为空异常',
    ApiSystemErrorCode.logicError: '代码逻辑错误',
    ApiSystemErrorCode.serviceUnavailable: '服务暂时不可用',
    ApiUnexpectedErrorCode.businessBusy: '业务繁忙，请稍后重试',
    ApiUnexpectedErrorCode.codeNotFound: '错误码未找到',
    ApiUnexpectedErrorCode.paymentIdError: '付款单id异常',
    ApiUnexpectedErrorCode.paymentCallbackError: '支付回调非成功',
    ApiUnexpectedErrorCode.paymentVerifyError: '支付信息验签失败',
    ApiUnexpectedErrorCode.wechatApiError: '调用微信失败',
    ApiUnexpectedErrorCode.wechatParamError: '调用微信非法参数',
    ApiUnexpectedErrorCode.wechatNotLogin: '微信未登录',
  };
}

class ApiCodeUtils {
  const ApiCodeUtils._();

  static bool isSuccess(int code) {
    return ApiSuccessCode.values.contains(code);
  }

  static bool isLoginRequired(int code) {
    return code == ApiUserErrorCode.sessionExpired ||
        code == ApiUserErrorCode.accountLoginElsewhere ||
        code == ApiUnexpectedErrorCode.wechatNotLogin;
  }

  static bool shouldShowError(int code) {
    return !isSuccess(code);
  }

  static String messageFor(int code) {
    return ApiCodeMessages.values[code] ?? '未知错误';
  }
}

String buildApiUrl(
  ApiPath endpoint, {
  required String baseUrl,
  Map<String, Object?> params = const {},
  String? version,
}) {
  return endpoint.resolve(baseUrl, params: params, version: version);
}
