# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.
*本文件为 Claude Code (claude.ai/code) 在此仓库中工作提供指导。*

## Project Overview
*项目概览*

Pawsure App is a Flutter mobile application built with Dart 3 using a feature-driven architecture.
*Pawsure App 是一个使用 Dart 3 构建的 Flutter 移动应用，采用功能驱动架构。*

The project follows strict architectural patterns with Riverpod for state management, GoRouter for navigation, Dio for networking, and supports multi-environment deployments (dev/stg/prod).
*项目遵循严格的架构模式，使用 Riverpod 进行状态管理、GoRouter 进行导航、Dio 进行网络请求，并支持多环境部署（dev/stg/prod）。*

## Commands
*命令*

### Development
*开发*

```bash
# Install dependencies
# 安装依赖
flutter pub get

# Run app (default: dev environment)
# 运行应用（默认：开发环境）
flutter run --dart-define=APP_FLAVOR=dev

# Run with specific environment
# 运行指定环境
flutter run --dart-define=APP_FLAVOR=stg
flutter run --dart-define=APP_FLAVOR=prod

# Static analysis
# 静态分析
flutter analyze

# Run tests
# 运行测试
flutter test

# Generate i18n
# 生成国际化
flutter pub run intl_utils:generate
```

## Architecture
*架构*

### Core Principles
*核心原则*

- **State Management**: All page state managed via Riverpod's `AsyncNotifier` with AsyncValue three-state pattern (loading/success/error)
  *状态管理：所有页面状态通过 Riverpod 的 `AsyncNotifier` 管理，使用 AsyncValue 三态模式（加载中/成功/错误）*

- **Network Layer**: Centralized `AppHttpClient` wraps Dio; all API calls return `ApiResult<T>` (Success/Failure), never raw Response objects
  *网络层：集中式 `AppHttpClient` 封装 Dio；所有 API 调用返回 `ApiResult<T>`（成功/失败），永不返回原始 Response 对象*

- **Error Handling**: `ErrorMapper` converts exceptions to `AppException`; errors propagate through `ApiFailure`
  *错误处理：`ErrorMapper` 将异常转换为 `AppException`；错误通过 `ApiFailure` 传播*

- **Storage Strategy**:
  *存储策略：*
  - `AppStorage` for KV pairs (shared_preferences)
    *`AppStorage` 用于键值对（shared_preferences）*
  - `writeSecure/readSecure` for sensitive data (flutter_secure_storage)
    *`writeSecure/readSecure` 用于敏感数据（flutter_secure_storage）*
  - `writeJson/readJson` for structured objects
    *`writeJson/readJson` 用于结构化对象*

- **Theme System**: All UI uses semantic tokens from `ThemeExtension` (`AppColorTokens`, `AppSpacingTokens`, `AppRadiusTokens`); no hardcoded colors/spacing
  *主题系统：所有 UI 使用来自 `ThemeExtension` 的语义令牌（`AppColorTokens`、`AppSpacingTokens`、`AppRadiusTokens`）；禁止硬编码颜色/间距*

- **i18n**: All strings in ARB files (`lib/l10n/app_*.arb`); access via `context.l10n.xxx`
  *国际化：所有字符串存放在 ARB 文件（`lib/l10n/app_*.arb`）；通过 `context.l10n.xxx` 访问*

- **Routing**: GoRouter with ability-based guards; route abilities declared in `_routeAbilities` map
  *路由：GoRouter 配合基于能力的守卫；路由能力在 `_routeAbilities` 映射中声明*

- **Multi-Environment**: Environment config injected via `AppEnv`; access through `ref.watch(appEnvProvider)`
  *多环境：通过 `AppEnv` 注入环境配置；通过 `ref.watch(appEnvProvider)` 访问*

### Directory Structure
*目录结构*

```
lib/
  app/            # Application shell: env, routing, theme, bootstrap, i18n helpers
                  # 应用外壳：环境、路由、主题、启动引导、国际化辅助
  core/           # Cross-cutting: auth, network (AppHttpClient), storage (AppStorage), error handling
                  # 横切关注点：认证、网络（AppHttpClient）、存储（AppStorage）、错误处理
  data/           # Models and repositories (returns ApiResult<T>)
                  # 模型和仓库（返回 ApiResult<T>）
  features/       # Feature modules with presentation/providers structure
                  # 功能模块，包含 presentation/providers 结构
  shared/         # Reusable widgets (AppAsyncValueWidget), services (PermissionService), providers
                  # 可复用组件（AppAsyncValueWidget）、服务（PermissionService）、providers
  l10n/           # ARB localization resources (generated code)
                  # ARB 本地化资源（生成的代码）
```

### Key Patterns
*关键模式*

**HTTP Requests**:
*HTTP 请求：*

Repositories use `AppHttpClient` from `appHttpClientProvider`:
*仓库使用来自 `appHttpClientProvider` 的 `AppHttpClient`：*
```dart
final client = ref.read(appHttpClientProvider);
final result = await client.get<Pet>(
  '/pets/123',
  decoder: (json) => Pet.fromJson(json as Map<String, dynamic>),
);
return result; // ApiResult<Pet>
```

**Page State**:
*页面状态：*

Pages consume `AsyncNotifier` providers and render with `AppAsyncValueWidget`:
*页面使用 `AsyncNotifier` providers 并通过 `AppAsyncValueWidget` 渲染：*

```dart
final viewState = ref.watch(petListControllerProvider);
return AppAsyncValueWidget(
  value: viewState,
  dataBuilder: (data) => PetListView(data: data),
);
```

**Theme Tokens**:
*主题令牌：*

Access theme extensions via `Theme.of(context)`:
*通过 `Theme.of(context)` 访问主题扩展：*

```dart
Theme.of(context).colors.primary
Theme.of(context).spacing.lg
Theme.of(context).radii.md
```

**Routing**:
*路由：*

Routes defined in `lib/app/router/app_router.dart`.
*路由定义在 `lib/app/router/app_router.dart`。*

Add route abilities in `_routeAbilities` map for permission guards.
*在 `_routeAbilities` 映射中添加路由能力以实现权限守卫。*

Navigate with `context.go()` or `context.pushNamed()`.
*使用 `context.go()` 或 `context.pushNamed()` 进行导航。*

**Permissions**:
*权限：*

Use `PermissionService.can('ability')` for component-level feature flags.
*使用 `PermissionService.can('ability')` 进行组件级别的功能开关。*

Route guards redirect to `/forbidden` when abilities missing.
*路由守卫在缺少能力时重定向到 `/forbidden`。*

**Environment Config**:
*环境配置：*

Environment-specific logic lives in `lib/app/env/`.
*环境特定逻辑存放在 `lib/app/env/`。*

Each flavor (dev/stg/prod) has distinct baseUrl, logging, and feature flags.
*每个环境（dev/stg/prod）都有不同的 baseUrl、日志记录和功能开关。*

Access via `appEnvProvider`.
*通过 `appEnvProvider` 访问。*

## Code Style Constraints
*代码风格约束*

From `项目约束.md` and `AGENTS.md`:
*来自 `项目约束.md` 和 `AGENTS.md`：*

- **No hardcoded strings**: All text in ARB files
  *禁止硬编码字符串：所有文本存入 ARB 文件*

- **No hardcoded theme values**: Use ThemeExtension tokens only
  *禁止硬编码主题值：仅使用 ThemeExtension 令牌*

- **Network returns**: Repositories must return `ApiResult<T>`, never Dio Response
  *网络返回：仓库必须返回 `ApiResult<T>`，永不返回 Dio Response*

- **State pattern**: Pages must use Riverpod AsyncValue and handle loading/success/error states
  *状态模式：页面必须使用 Riverpod AsyncValue 并处理 loading/success/error 三态*

- **File naming**: snake_case for files, UpperCamelCase for types, lowerCamelCase for members
  *文件命名：文件用 snake_case，类型用 UpperCamelCase，成员用 lowerCamelCase*

- **Null safety**: Dart 3 null safety required
  *空安全：必须使用 Dart 3 空安全*

- **Material 3**: Use Material 3 components
  *Material 3：使用 Material 3 组件*

- **Analysis**: Must pass `flutter analyze` with zero warnings (flutter_lints enabled)
  *分析：必须通过 `flutter analyze` 且零警告（已启用 flutter_lints）*

## Testing
*测试*

- Test files mirror source paths with `_test.dart` suffix
  *测试文件镜像源文件路径，以 `_test.dart` 后缀命名*

- Focus coverage on AsyncValue states, ApiResult mapping, error conversions
  *重点覆盖 AsyncValue 状态、ApiResult 映射、错误转换*

- Run `flutter test` before commits
  *提交前运行 `flutter test`*

- Core logic requires unit tests or examples
  *核心逻辑需要单元测试或示例*

## Environment Flavors
*环境变体*

Three environments configured via `--dart-define=APP_FLAVOR`:
*通过 `--dart-define=APP_FLAVOR` 配置三个环境：*

- **dev**: Development API, network logs enabled in debug mode (indigo theme)
  *dev：开发 API，调试模式下启用网络日志（靛蓝主题）*

- **stg**: Staging API, network logs and crash reporting enabled (cyan theme)
  *stg：预发布 API，启用网络日志和崩溃报告（青色主题）*

- **prod**: Production API, crash reporting enabled, no network logs (teal theme)
  *prod：生产 API，启用崩溃报告，无网络日志（青绿主题）*

Each flavor has distinct seed color for visual environment identification.
*每个环境都有独特的种子颜色用于视觉识别。*

## Bootstrap Process
*启动流程*

Entry point: `lib/main.dart` reads `APP_FLAVOR` from compile-time define, then calls `bootstrap(env)` which:
*入口点：`lib/main.dart` 从编译时定义读取 `APP_FLAVOR`，然后调用 `bootstrap(env)`，该函数执行：*

1. Initializes Flutter bindings
   *初始化 Flutter 绑定*

2. Creates `AppStorage` instance
   *创建 `AppStorage` 实例*

3. Overrides `appEnvProvider` and `appStorageProvider`
   *覆盖 `appEnvProvider` 和 `appStorageProvider`*

4. Adds `ProviderLogger` observer
   *添加 `ProviderLogger` 观察者*

5. Runs `PawsureApp`
   *运行 `PawsureApp`*

## Important Files
*重要文件*

- `lib/app/env/app_env.dart`: Environment configuration
  *环境配置*

- `lib/core/network/app_http_client.dart`: HTTP client with ApiResult wrapper
  *带 ApiResult 封装的 HTTP 客户端*

- `lib/core/network/api_result.dart`: Success/Failure result type
  *成功/失败结果类型*

- `lib/core/storage/app_storage.dart`: Unified storage interface
  *统一存储接口*

- `lib/app/router/app_router.dart`: GoRouter config with ability guards
  *带能力守卫的 GoRouter 配置*

- `lib/app/theme/app_theme.dart`: Theme tokens and extensions
  *主题令牌和扩展*

- `lib/shared/widgets/app_async_value.dart`: Standard AsyncValue renderer
  *标准 AsyncValue 渲染器*

- `lib/shared/services/permission_service.dart`: Ability-based permissions
  *基于能力的权限*
