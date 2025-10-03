import 'api_constants.dart';

class StorageKeys {
  const StorageKeys._();

  static const String userInfo = 'userInfo';
  static const String token = 'token';
  static const String userToken = 'token';
  static const String sessionKey = 'session_key';
  static const String permissions = 'permissions';
  static const String appConfig = 'appConfig';
  static const String hasLaunched = 'hasLaunched';
  static const String cacheData = 'cacheData';
  static const String sessionData = 'sessionData';
  static const String petList = 'petList';
  static const String addressList = 'addressList';
  static const String orderHistory = 'orderHistory';
  static const String favoriteProviders = 'favoriteProviders';
  static const String userSettings = 'userSettings';
  static const String notificationSettings = 'notificationSettings';
  static const String tempData = 'tempData';
  static const String draftData = 'draftData';
  static const String errorLogs = 'errorLogs';
  static const String operationLogs = 'operationLogs';
  static const String usageStats = 'usageStats';
  static const String appVersion = 'appVersion';
  static const String dataVersion = 'dataVersion';
}

class CacheDuration {
  const CacheDuration._();

  static const Duration short = Duration(minutes: 5);
  static const Duration medium = Duration(minutes: 30);
  static const Duration long = Duration(hours: 2);
  static const Duration extraLong = Duration(hours: 24);
  static const Duration persistent = Duration(days: 7);
  static const Duration userInfo = Duration(hours: 24);
  static const Duration providerList = Duration(minutes: 30);
  static const Duration orderList = Duration(minutes: 10);
  static const Duration petList = Duration(hours: 2);
  static const Duration addressList = Duration(hours: 2);
  static const Duration bannerList = Duration(hours: 1);
  static const Duration searchSuggestions = Duration(hours: 1);
}

class StorageQuota {
  const StorageQuota._();

  static const int maxTotalBytes = 10 * 1024 * 1024;
  static const int maxSingleBytes = 1024 * 1024;
  static const int userDataBytes = 100 * 1024;
  static const int cacheDataBytes = 2 * 1024 * 1024;
  static const int logDataBytes = 500 * 1024;
  static const int tempDataBytes = 200 * 1024;
  static const int mediaCacheBytes = 5 * 1024 * 1024;
}

class CleanupStrategyTriggers {
  const CleanupStrategyTriggers._();

  static const int storageUsagePercent = 80;
  static const int cacheCountLimit = 1000;
  static const int logCountLimit = 500;
  static const Duration expiredCheckInterval = Duration(hours: 24);
}

class CleanupPriority {
  const CleanupPriority._();

  static const int expiredCache = 5;
  static const int tempData = 4;
  static const int oldLogs = 3;
  static const int largeCache = 2;
  static const int unusedData = 1;
}

class CompressionConfig {
  const CompressionConfig._();

  static const List<String> enabledTypes = [
    StorageKeys.orderHistory,
    StorageKeys.errorLogs,
    StorageKeys.operationLogs,
    StorageKeys.usageStats,
  ];

  static const int sizeThresholdBytes = 10 * 1024;
  static const String algorithm = 'gzip';
  static const int level = 6;
}

class SyncConfig {
  const SyncConfig._();

  static const List<String> syncTypes = [
    StorageKeys.userSettings,
    StorageKeys.favoriteProviders,
    StorageKeys.usageStats,
  ];

  static const Duration syncInterval = Duration(minutes: 5);
  static const int offlineQueueLimit = 100;
  static const int retryAttempts = 3;
  static const Duration retryDelay = Duration(seconds: 2);
}

class BackupConfig {
  const BackupConfig._();

  static const bool autoBackup = true;
  static const Duration backupInterval = Duration(hours: 24);
  static const int retainCount = 7;
  static const List<String> criticalKeys = [
    StorageKeys.userInfo,
    StorageKeys.userSettings,
    StorageKeys.petList,
    StorageKeys.addressList,
  ];
}

class EncryptionConfig {
  const EncryptionConfig._();

  static const List<String> encryptedKeys = [
    StorageKeys.userToken,
    StorageKeys.sessionKey,
    StorageKeys.userInfo,
  ];

  static const String algorithm = 'AES-256-GCM';
  static const Duration keyRotationInterval = Duration(days: 30);
}

class RequestConfig {
  const RequestConfig._();

  static const Duration defaultTimeout = Duration(milliseconds: 10000);
  static const Duration uploadTimeout = Duration(milliseconds: 30000);
  static const Duration downloadTimeout = Duration(milliseconds: 60000);
  static const int defaultRetryCount = 3;
  static const Duration defaultRetryDelay = Duration(milliseconds: 1000);
  static const Duration maxRetryDelay = Duration(milliseconds: 5000);
  static const Duration mockNetworkDelay = Duration(milliseconds: 800);
  static const double mockErrorRate = 0;
  static const Set<int> successCodes = {
    0,
    200,
    ApiSuccessCode.success,
    ApiSuccessCode.querySuccess,
  };
  static const Set<String> successStatus = {'success', 'ok'};
}

class RequestContentType {
  const RequestContentType._();

  static const String json = 'application/json';
  static const String form = 'application/x-www-form-urlencoded';
  static const String multipart = 'multipart/form-data';
  static const String text = 'text/plain';
  static const String xml = 'application/xml';
}

class RequestMethod {
  const RequestMethod._();

  static const String get = 'GET';
  static const String post = 'POST';
  static const String put = 'PUT';
  static const String delete = 'DELETE';
  static const String patch = 'PATCH';
  static const String head = 'HEAD';
  static const String options = 'OPTIONS';
}

class CacheStrategyType {
  const CacheStrategyType._();

  static const String noCache = 'no-cache';
  static const String cacheFirst = 'cache-first';
  static const String networkFirst = 'network-first';
  static const String cacheOnly = 'cache-only';
  static const String networkOnly = 'network-only';
}

class CacheStrategyConfig {
  const CacheStrategyConfig._();

  static const String defaultStrategy = CacheStrategyType.networkFirst;
  static const Map<String, CacheStrategyEntry> endpointStrategies = {
    '/api/v1/auth/user/info': CacheStrategyEntry(
      strategy: CacheStrategyType.cacheFirst,
      ttl: Duration(minutes: 5),
    ),
    '/api/v1/home/banners': CacheStrategyEntry(
      strategy: CacheStrategyType.cacheFirst,
      ttl: Duration(minutes: 2),
    ),
    '/api/v1/home/providers': CacheStrategyEntry(
      strategy: CacheStrategyType.networkFirst,
      ttl: Duration(minutes: 1),
    ),
  };
}

class CacheStrategyEntry {
  const CacheStrategyEntry({required this.strategy, required this.ttl});

  final String strategy;
  final Duration ttl;
}

class RetryStrategyConfig {
  const RetryStrategyConfig._();

  static const RetryConditions conditions = RetryConditions(
    networkError: true,
    timeoutError: true,
    serverError: true,
    rateLimit: true,
  );
  static const String defaultStrategy = RetryDelayStrategy.exponential;
}

class RetryConditions {
  const RetryConditions({
    required this.networkError,
    required this.timeoutError,
    required this.serverError,
    required this.rateLimit,
  });

  final bool networkError;
  final bool timeoutError;
  final bool serverError;
  final bool rateLimit;
}

class RetryDelayStrategy {
  const RetryDelayStrategy._();

  static const String fixed = 'fixed';
  static const String exponential = 'exponential';
  static const String linear = 'linear';
}

class LoggingConfig {
  const LoggingConfig._();

  static const LogLevel level = LogLevel.info;
  static const LogOutput output = LogOutput(
    console: true,
    storage: false,
    remote: false,
  );
  static const List<String> sensitiveFields = ['password', 'token', 'cookie'];
}

class LogLevel {
  const LogLevel._(this.priority);

  final int priority;

  static const LogLevel error = LogLevel._(0);
  static const LogLevel warn = LogLevel._(1);
  static const LogLevel info = LogLevel._(2);
  static const LogLevel debug = LogLevel._(3);
}

class LogOutput {
  const LogOutput({
    required this.console,
    required this.storage,
    required this.remote,
  });

  final bool console;
  final bool storage;
  final bool remote;
}

class ErrorCodeMap {
  const ErrorCodeMap._();

  static const String networkError = 'NETWORK_ERROR';
  static const String timeoutError = 'TIMEOUT_ERROR';
  static const String abortError = 'ABORT_ERROR';
  static const String businessError = 'BUSINESS_ERROR';
  static const String validationError = 'VALIDATION_ERROR';
  static const String permissionError = 'PERMISSION_ERROR';
  static const String authError = 'AUTH_ERROR';
  static const String tokenExpired = 'TOKEN_EXPIRED';
  static const String loginRequired = 'LOGIN_REQUIRED';
  static const String serverError = 'SERVER_ERROR';
  static const String serviceUnavailable = 'SERVICE_UNAVAILABLE';
  static const String gatewayError = 'GATEWAY_ERROR';
}

class HttpStatusMap {
  const HttpStatusMap._();

  static const Map<int, HttpStatusDescriptor> values = {
    200: HttpStatusDescriptor(type: 'success', message: '请求成功'),
    201: HttpStatusDescriptor(type: 'success', message: '创建成功'),
    204: HttpStatusDescriptor(type: 'success', message: '删除成功'),
    400: HttpStatusDescriptor(
      type: 'client_error',
      message: '请求参数错误',
      code: ErrorCodeMap.validationError,
    ),
    401: HttpStatusDescriptor(
      type: 'auth_error',
      message: '未授权访问',
      code: ErrorCodeMap.authError,
    ),
    403: HttpStatusDescriptor(
      type: 'auth_error',
      message: '权限不足',
      code: ErrorCodeMap.permissionError,
    ),
    404: HttpStatusDescriptor(
      type: 'client_error',
      message: '请求地址不存在',
      code: ErrorCodeMap.businessError,
    ),
    408: HttpStatusDescriptor(
      type: 'client_error',
      message: '请求超时',
      code: ErrorCodeMap.timeoutError,
    ),
    409: HttpStatusDescriptor(
      type: 'client_error',
      message: '资源冲突',
      code: ErrorCodeMap.businessError,
    ),
    422: HttpStatusDescriptor(
      type: 'client_error',
      message: '数据验证失败',
      code: ErrorCodeMap.validationError,
    ),
    429: HttpStatusDescriptor(
      type: 'client_error',
      message: '请求过于频繁',
      code: ErrorCodeMap.businessError,
    ),
    500: HttpStatusDescriptor(
      type: 'server_error',
      message: '服务器内部错误',
      code: ErrorCodeMap.serverError,
    ),
    502: HttpStatusDescriptor(
      type: 'server_error',
      message: '网关错误',
      code: ErrorCodeMap.gatewayError,
    ),
    503: HttpStatusDescriptor(
      type: 'server_error',
      message: '服务不可用',
      code: ErrorCodeMap.serviceUnavailable,
    ),
    504: HttpStatusDescriptor(
      type: 'server_error',
      message: '网关超时',
      code: ErrorCodeMap.timeoutError,
    ),
  };
}

class HttpStatusDescriptor {
  const HttpStatusDescriptor({
    required this.type,
    required this.message,
    this.code,
  });

  final String type;
  final String message;
  final String? code;
}

class InterceptorConfig {
  const InterceptorConfig._();

  static const RequestInterceptorConfig request = RequestInterceptorConfig(
    auth: InterceptorToggle(enabled: true, priority: 1),
    commonParams: InterceptorToggle(enabled: true, priority: 2),
    logging: InterceptorToggle(enabled: true, priority: 3),
  );

  static const ResponseInterceptorConfig response = ResponseInterceptorConfig(
    logging: InterceptorToggle(enabled: true, priority: 1),
    errorHandling: InterceptorToggle(enabled: true, priority: 2),
    dataTransform: InterceptorToggle(enabled: true, priority: 3),
  );
}

class InterceptorToggle {
  const InterceptorToggle({required this.enabled, required this.priority});

  final bool enabled;
  final int priority;
}

class RequestInterceptorConfig {
  const RequestInterceptorConfig({
    required this.auth,
    required this.commonParams,
    required this.logging,
  });

  final InterceptorToggle auth;
  final InterceptorToggle commonParams;
  final InterceptorToggle logging;
}

class ResponseInterceptorConfig {
  const ResponseInterceptorConfig({
    required this.logging,
    required this.errorHandling,
    required this.dataTransform,
  });

  final InterceptorToggle logging;
  final InterceptorToggle errorHandling;
  final InterceptorToggle dataTransform;
}
