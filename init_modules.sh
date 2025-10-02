#!/usr/bin/env bash
set -euo pipefail

REPO_DIR="${1:-chongxin_modules}"

# ---- helpers ----
need() {
  command -v "$1" >/dev/null 2>&1 || { echo "❌ 需要安装 $1"; exit 1; }
}

echo "🔎 检查依赖：dart / flutter ..."
need dart
need flutter

echo "📁 创建仓库目录：$REPO_DIR"
mkdir -p "$REPO_DIR"
cd "$REPO_DIR"

echo "🌱 初始化 git（如已存在会跳过）"
git init >/dev/null 2>&1 || true

# ---- root files ----
echo "🧱 写入 melos.yaml"
cat > melos.yaml <<'YML'
name: chongxin_modules
packages:
  - packages/**
command:
  bootstrap:
    runPubGetInParallel: true
scripts:
  analyze: melos exec -- "flutter analyze"
  test: melos exec --fail-fast -- "flutter test"
  format: melos exec -- "dart format ."
YML

echo "🧹 写入 analysis_options.yaml"
cat > analysis_options.yaml <<'YML'
include: package:flutter_lints/flutter.yaml
linter:
  rules:
    always_use_package_imports: true
    avoid_print: true
    prefer_const_constructors: true
    prefer_final_locals: true
    unnecessary_late: true
analyzer:
  exclude:
    - "**/*.g.dart"
YML

echo "🔒 写入 .gitignore"
cat > .gitignore <<'GIT'
.dart_tool/
.packages
build/
.pub-cache/
.idea/
.vscode/
**/pubspec.lock
coverage/
GIT

# ---- packages skeleton ----
mkdir -p packages

make_dart_pkg () {
  local name="$1"
  mkdir -p "packages/$name/lib" "packages/$name/test"
  cat > "packages/$name/pubspec.yaml" <<YML
name: $name
description: $name - shared module
version: 0.1.0
environment:
  sdk: ">=3.0.0 <4.0.0"
dev_dependencies:
  lints: ^4.0.0
  test: ^1.25.0
YML
}

make_flutter_pkg () {
  local name="$1"
  mkdir -p "packages/$name/lib" "packages/$name/test" "packages/$name/example/lib"
  cat > "packages/$name/pubspec.yaml" <<YML
name: $name
description: $name - flutter shared module
version: 0.1.0
environment:
  sdk: ">=3.0.0 <4.0.0"
  flutter: ">=3.22.0"
dependencies:
  flutter:
    sdk: flutter
dev_dependencies:
  flutter_lints: ^4.0.0
  flutter_test:
    sdk: flutter
flutter:
  uses-material-design: false
YML
  cat > "packages/$name/example/lib/main.dart" <<'DART'
import 'package:flutter/material.dart';
void main() => runApp(const MaterialApp(home: Scaffold(body: Center(child: Text('example')))));
DART
}

echo "📦 创建 Dart 包：cx_core / cx_utils"
make_dart_pkg cx_core
make_dart_pkg cx_utils

echo "📦 创建 Flutter 包：cx_theme / cx_network / cx_storage / cx_permissions / cx_media"
make_flutter_pkg cx_theme
make_flutter_pkg cx_network
make_flutter_pkg cx_storage
make_flutter_pkg cx_permissions
make_flutter_pkg cx_media

# ---- wire dependencies ----

# cx_core code
cat > packages/cx_core/lib/cx_core.dart <<'DART'
library cx_core;

sealed class ApiResult<T> {
  const ApiResult();
  bool get isSuccess => this is ApiSuccess<T>;
  T? get data => this is ApiSuccess<T> ? (this as ApiSuccess<T>).value : null;
  AppException? get error => this is ApiFailure<T> ? (this as ApiFailure<T>).exception : null;
}

class ApiSuccess<T> extends ApiResult<T> {
  final T value;
  const ApiSuccess(this.value);
}

class ApiFailure<T> extends ApiResult<T> {
  final AppException exception;
  const ApiFailure(this.exception);
}

class AppException implements Exception {
  final String code; // e.g. network_timeout / http_403 / biz_xxx
  final String message;
  final int? status;
  const AppException(this.code, this.message, {this.status});
  @override
  String toString() => 'AppException($code, $message, status=$status)';
}
DART

cat > packages/cx_core/test/result_test.dart <<'DART'
import 'package:test/test.dart';
import 'package:cx_core/cx_core.dart';

void main() {
  test('ApiResult success', () {
    const r = ApiSuccess<int>(1);
    expect(r.isSuccess, true);
    expect(r.data, 1);
  });
}
DART

# cx_utils code
cat > packages/cx_utils/lib/cx_utils.dart <<'DART'
library cx_utils;

typedef Void = void Function();

class Debouncer {
  Debouncer(this.duration);
  final Duration duration;
  DateTime? _last;
  void run(Void fn) {
    final now = DateTime.now();
    if (_last == null || now.difference(_last!) >= duration) {
      _last = now; fn();
    }
  }
}

bool isValidPhone(String v) => RegExp(r'^\d{11}$').hasMatch(v);
DART

cat > packages/cx_utils/test/utils_test.dart <<'DART'
import 'package:test/test.dart';
import 'package:cx_utils/cx_utils.dart';

void main() {
  test('phone validator', () {
    expect(isValidPhone('12345678901'), true);
    expect(isValidPhone('abc'), false);
  });
}
DART

# cx_theme code
# add dependency: none beyond flutter
cat > packages/cx_theme/lib/cx_theme.dart <<'DART'
library cx_theme;

import 'package:flutter/material.dart';

@immutable
class CxTokens extends ThemeExtension<CxTokens> {
  final Color brandPrimary, success, warning, danger;
  final double radiusSm, radiusMd, radiusLg;
  const CxTokens({
    required this.brandPrimary, required this.success, required this.warning, required this.danger,
    required this.radiusSm, required this.radiusMd, required this.radiusLg,
  });

  @override
  CxTokens copyWith({
    Color? brandPrimary, Color? success, Color? warning, Color? danger,
    double? radiusSm, double? radiusMd, double? radiusLg,
  }) => CxTokens(
    brandPrimary: brandPrimary ?? this.brandPrimary,
    success: success ?? this.success,
    warning: warning ?? this.warning,
    danger: danger ?? this.danger,
    radiusSm: radiusSm ?? this.radiusSm,
    radiusMd: radiusMd ?? this.radiusMd,
    radiusLg: radiusLg ?? this.radiusLg,
  );

  @override
  ThemeExtension<CxTokens> lerp(ThemeExtension<CxTokens>? other, double t) => this;
}

ThemeData cxLightTheme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
  extensions: [
    CxTokens(
      brandPrimary: Colors.blue,
      success: Colors.green,
      warning: Colors.orange,
      danger: Colors.red,
      radiusSm: 8, radiusMd: 12, radiusLg: 16,
    ),
  ],
);

ThemeData cxDarkTheme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueGrey, brightness: Brightness.dark),
  extensions: [
    CxTokens(
      brandPrimary: Colors.lightBlueAccent,
      success: Colors.lightGreen,
      warning: Colors.deepOrange,
      danger: Colors.redAccent,
      radiusSm: 8, radiusMd: 12, radiusLg: 16,
    ),
  ],
);

extension BuildCxTokens on BuildContext {
  CxTokens get tokens => Theme.of(this).extension<CxTokens>()!;
}
DART

# cx_network: add deps dio + cx_core (path)
sed -i.bak '1,/^flutter:/!b;/^flutter:/a\
  dio: ^5.5.0\
  cx_core:\
    path: ../cx_core\
' packages/cx_network/pubspec.yaml && rm packages/cx_network/pubspec.yaml.bak

cat > packages/cx_network/lib/cx_network.dart <<'DART'
library cx_network;

import 'package:dio/dio.dart';
import 'package:cx_core/cx_core.dart';

typedef Json = Map<String, dynamic>;

class CxHttp {
  CxHttp({required String baseUrl, List<Interceptor>? extra})
      : _dio = Dio(BaseOptions(
          baseUrl: baseUrl,
          connectTimeout: const Duration(seconds: 10),
          receiveTimeout: const Duration(seconds: 20),
        ))..interceptors.addAll([
          LogInterceptor(responseBody: false),
          if (extra != null) ...extra
        ]);

  final Dio _dio;

  Future<ApiResult<T>> get<T>(
    String path, {
    Json? query,
    T Function(Json json)? parser,
    CancelToken? cancelToken,
  }) async {
    try {
      final res = await _dio.get(path, queryParameters: query, cancelToken: cancelToken);
      final code = res.statusCode ?? 0;
      if (code == 200) {
        if (parser != null) return ApiSuccess(parser(res.data as Json));
        return ApiSuccess(res.data as T);
      }
      return ApiFailure(AppException('http_$code', 'HTTP $code', status: code));
    } on DioException catch (e) {
      return ApiFailure(AppException('network_error', e.message ?? 'Network error', status: e.response?.statusCode));
    } catch (e) {
      return const ApiFailure(AppException('unknown', 'Unknown error'));
    }
  }

  Future<ApiResult<T>> post<T>(
    String path, {
    Object? data,
    T Function(Json json)? parser,
    CancelToken? cancelToken,
  }) async {
    try {
      final res = await _dio.post(path, data: data, cancelToken: cancelToken);
      final code = res.statusCode ?? 0;
      if (code == 200) {
        if (parser != null) return ApiSuccess(parser(res.data as Json));
        return ApiSuccess(res.data as T);
      }
      return ApiFailure(AppException('http_$code', 'HTTP $code', status: code));
    } on DioException catch (e) {
      return ApiFailure(AppException('network_error', e.message ?? 'Network error', status: e.response?.statusCode));
    } catch (e) {
      return const ApiFailure(AppException('unknown', 'Unknown error'));
    }
  }

  Dio get raw => _dio;
}
DART

# cx_storage: add deps shared_prefs + secure_storage
sed -i.bak '1,/^flutter:/!b;/^flutter:/a\
  shared_preferences: ^2.3.2\
  flutter_secure_storage: ^9.2.2\
' packages/cx_storage/pubspec.yaml && rm packages/cx_storage/pubspec.yaml.bak

cat > packages/cx_storage/lib/cx_storage.dart <<'DART'
library cx_storage;

import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class CxKV {
  static SharedPreferences? _sp;
  static Future<void> init() async => _sp ??= await SharedPreferences.getInstance();
  static String? getString(String k) => _sp?.getString(k);
  static Future<bool> setString(String k, String v) async => await _sp!.setString(k, v);
  static Future<bool> remove(String k) async => await _sp!.remove(k);
}

class CxSecure {
  static const _secure = FlutterSecureStorage();
  static Future<void> write(String k, String v) => _secure.write(key: k, value: v);
  static Future<String?> read(String k) => _secure.read(key: k);
  static Future<void> delete(String k) => _secure.delete(key: k);
}
DART

# cx_permissions: add deps permission_handler
sed -i.bak '1,/^flutter:/!b;/^flutter:/a\
  permission_handler: ^11.3.1\
' packages/cx_permissions/pubspec.yaml && rm packages/cx_permissions/pubspec.yaml.bak

cat > packages/cx_permissions/lib/cx_permissions.dart <<'DART'
library cx_permissions;

import 'package:permission_handler/permission_handler.dart';

enum CxPerm { camera, photos, microphone }

Future<bool> ensure(CxPerm p) async {
  Permission perm;
  switch (p) {
    case CxPerm.camera: perm = Permission.camera; break;
    case CxPerm.photos: perm = Permission.photos; break; // Android 13+ 需细分至 READ_MEDIA_*
    case CxPerm.microphone: perm = Permission.microphone; break;
  }
  final status = await perm.request();
  return status.isGranted;
}
DART

# cx_media: add deps image_picker
sed -i.bak '1,/^flutter:/!b;/^flutter:/a\
  image_picker: ^1.1.2\
' packages/cx_media/pubspec.yaml && rm packages/cx_media/pubspec.yaml.bak

cat > packages/cx_media/lib/cx_media.dart <<'DART'
library cx_media;

import 'package:image_picker/image_picker.dart';

class CxMedia {
  static final _picker = ImagePicker();
  static Future<XFile?> pickImageFromGallery() => _picker.pickImage(source: ImageSource.gallery);
  static Future<XFile?> takePhoto() => _picker.pickImage(source: ImageSource.camera);
  static Future<XFile?> pickVideo() => _picker.pickVideo(source: ImageSource.gallery);
  static Future<XFile?> takeVideo() => _picker.pickVideo(source: ImageSource.camera);
}
DART

# ---- CI (optional) ----
mkdir -p .github/workflows
cat > .github/workflows/ci.yml <<'YML'
name: ci
on: [push, pull_request]
jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: subosito/flutter-action@v2
        with:
          flutter-version: "stable"
      - run: dart pub global activate melos
      - run: melos bootstrap
      - run: melos analyze
      - run: melos test
YML

# ---- bootstrap ----
echo "📦 安装依赖（melos bootstrap）"
dart pub global activate melos >/dev/null
melos bootstrap

echo "✅ 完成！
目录结构：
- $REPO_DIR/
  - melos.yaml
  - analysis_options.yaml
  - packages/
    - cx_core / cx_utils （Dart 包）
    - cx_theme / cx_network / cx_storage / cx_permissions / cx_media （Flutter 包）

下一步（业务 App 中使用示例）：
在你的 App 的 pubspec.yaml 中加入：
dependencies:
  cx_core:
    path: ../$REPO_DIR/packages/cx_core
  cx_theme:
    path: ../$REPO_DIR/packages/cx_theme
  cx_network:
    path: ../$REPO_DIR/packages/cx_network
  cx_storage:
    path: ../$REPO_DIR/packages/cx_storage
  cx_permissions:
    path: ../$REPO_DIR/packages/cx_permissions
  cx_media:
    path: ../$REPO_DIR/packages/cx_media

在 main() 里初始化：
  await CxKV.init();
  runApp(MaterialApp(theme: cxLightTheme, darkTheme: cxDarkTheme, home: const Placeholder()));

祝开发顺利 🚀
"
