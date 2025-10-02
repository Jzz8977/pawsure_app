# Repository Guidelines
*仓库协作指南*

## Project Structure & Module Organization
- `lib/app/`: application shell (env, routing, theme, localization helpers).（应用外壳：环境、路由、主题、本地化辅助。）
- `lib/core/`: cross-cutting capabilities such as auth, network, storage, and error handling.（核心通用能力：鉴权、网络、存储、异常处理。）
- `lib/features/`: feature-driven modules; e.g., `home/` renders the overview screen.（业务功能模块，如 `home/` 展示总览页。）
- `lib/shared/`: reusable widgets, providers, and services shared across features.（共享组件、Provider 与服务。）
- `lib/l10n/`: ARB localization resources compiled by Flutter intl tooling.（ARB 多语言资源，交由 intl 工具编译。）
- `test/`: mirrors production layout for unit tests (`core/`, `shared/`, etc.).（单测目录，遵循与源码一致的结构。）

## Build, Test, and Development Commands
- `flutter pub get`: install or refresh dependencies before any build.（安装或刷新依赖。）
- `flutter analyze`: run static analysis via `flutter_lints`.（静态代码检查。）
- `flutter test`: execute unit/widget suites; ensure green before PR.（运行单元与组件测试，提交前需通过。）
- `flutter run --dart-define=APP_FLAVOR=dev`: launch dev flavor locally; swap `stg`/`prod` as needed.（按需切换环境运行。）

## Coding Style & Naming Conventions
- Use Dart 3 null safety, Material 3, and prefer stateless widgets.（遵循 Dart 3 空安全与 M3 设计，优先无状态组件。）
- Indent with 2 spaces; UpperCamelCase types, lowerCamelCase members, snake_case files.（缩进 2 空格；类型用帕斯卡命名，字段/方法用小驼峰，文件用下划线。）
- Theme tokens live in `AppTheme` extensions—never hardcode colors, spacing, or radii.（主题令牌集中在 `AppTheme`，禁止在业务中写死色值与间距。）
- Strings belong in ARB files; route identifiers reside in `AppRouteName`.（文案入 ARB，路由名称集中在 `AppRouteName`。）

## Testing Guidelines
- Primary toolchain: `flutter_test` with Riverpod utilities.（使用 `flutter_test` 与 Riverpod 测试工具。）
- Mirror source paths and suffix files with `_test.dart`.（测试文件与源码路径一致，文件名以 `_test.dart` 结尾。）
- Cover AsyncValue states, ApiResult mapping, and error conversions per module.（重点覆盖 AsyncValue 三态、ApiResult 映射、异常转换。）
- Run `flutter test` after local changes; document flaky cases in PR notes.（改动后执行 `flutter test`，若存在不稳定案例需在 PR 中说明。）

## Commit & Pull Request Guidelines
- Use imperative, concise commit subjects, e.g., `feat: add app http client`.（提交摘要使用祈使语，示例如 `feat: add app http client`。）
- Squash fixup commits before pushing for review.（评审前合并修复类提交。）
- PRs must include summary, verification (`flutter analyze`/`flutter test`), linked issues, and UI evidence when relevant.（PR 需包含概述、验证输出、关联需求编号及界面截图。）
- Keep environment-specific logic in `lib/app/env`; avoid sprinkling flavor checks in features.（环境差异逻辑集中在 `lib/app/env`，避免在业务模块散落配置。）
