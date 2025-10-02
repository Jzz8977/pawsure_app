# 功能扩展操作手册

## 新增页面
1. 在 `lib/features/<feature>/presentation/` 下创建页面文件，例如 `pet_list_page.dart`。
2. 使用 `ConsumerWidget` 或 `ConsumerStatefulWidget` 并通过 Riverpod 读取状态：
   ```dart
   class PetListPage extends ConsumerWidget {
     @override
     Widget build(BuildContext context, WidgetRef ref) {
       final viewState = ref.watch(petListControllerProvider);
       return Scaffold(
         appBar: AppBar(title: Text(context.l10n.petListTitle)),
         body: AppAsyncValueWidget(
           value: viewState,
           dataBuilder: (data) => PetListView(data: data),
         ),
       );
     }
   }
   ```
3. 页面状态放在 `lib/features/<feature>/providers/` 中的 `AsyncNotifier`，保持 loading/success/error 三态。

## 发起 HTTP 请求
1. 在仓库层（`lib/data/repositories/`）通过 `ref.read(appHttpClientProvider)` 获取 `AppHttpClient`。
2. 调用高阶方法并提供解码函数：
   ```dart
   final client = ref.read(appHttpClientProvider);
   final result = await client.get<List<Pet>>(
     '/pets',
     decoder: (json) => (json as List<dynamic>)
         .map((item) => Pet.fromJson(item as Map<String, dynamic>))
         .toList(),
   );
   return result;
   ```
3. 页面或状态层仅接收 `ApiResult<T>`，通过 `when`/`maybeWhen` 处理成功或失败。

## 获取全局参数
- 使用 `ref.watch(appEnvProvider)` 拿到当前 `AppEnv`，可访问 `baseUrl`、`flavor`、`enableNetworkLogs` 等。
- 如需一次性读取（非响应式），使用 `ref.read(appEnvProvider)`。

## 本地存储策略
1. 短期、可公开信息（如引导是否完成）使用 `AppStorage` 的 KV 能力：
   ```dart
   final storage = ref.read(appStorageProvider);
   await storage.writeBool('onboarding.finished', true);
   ```
2. 敏感信息（token、刷新密钥）使用 `writeSecure/readSecure`。
3. 结构化对象轻量序列化为 JSON 存入 `writeJson`，读取时提供解码函数。
4. 存储逻辑集中在仓库或服务层，避免在 UI 里直接操作存储。

## 使用 i18n
1. 所有文案写入 `lib/l10n/app_*.arb`，运行 `flutter pub run intl_utils:generate`（或 IDE 对应命令）生成 `AppLocalizations`。
2. 在 Widget 中使用 `context.l10n.xxx` 访问文案：
   ```dart
   Text(context.l10n.petListEmptyState)
   ```
3. 如需带变量，添加占位符并在代码中传递参数。

## 路由使用
1. 在 `lib/app/router/app_router.dart` 中新增 `GoRoute`，并在 `_routeAbilities` 中声明权限（如有需求）。
2. 页面跳转使用 `context.go('/pets')` 或 `context.pushNamed(AppRouteName.petDetail)`。
3. 需要监听权限或登录变化时，把守卫逻辑放在 `redirect` 回调里，保持路由统一受控。

## 主题与设计令牌
1. 所有颜色、间距、圆角来自 `Theme.of(context).colors/spacing/radii`。
2. 需要新增设计值时，先在 `AppColorTokens`、`AppSpacingTokens`、`AppRadiusTokens` 中扩展，再在主题配置 `extensions` 中提供默认值。
3. 组件内禁止写死 `Color(...)`、`SizedBox(height: 12)` 等常量，确保品牌调优仅修改主题即可生效。

## 参考命令
- 生成本地化：`flutter pub run intl_utils:generate`
- 静态检查：`flutter analyze`
- 运行测试：`flutter test`
