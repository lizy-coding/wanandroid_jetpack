# Jetpack 项目骨架图与学习流程

## 项目骨架图（路径概览）
```
├── app/
│   ├── src/main/java/com/yechaoa/wanandroid_jetpack/
│   │   ├── base/        # MVVM 基类封装
│   │   ├── common/      # 全局配置常量
│   │   ├── data/        # 数据层（网络、数据库、实体）
│   │   ├── ui/          # 界面层（功能模块）
│   │   └── util/        # 工具方法
│   ├── src/main/res/    # 资源文件（layout/drawable/values）
│   ├── src/test/        # 单元测试
│   └── src/androidTest/ # 仪器测试
├── build.gradle.kts     # 顶层构建
├── app/build.gradle.kts # 模块构建与依赖
├── buildSrc/            # 构建逻辑与版本管理
└── gradle/              # Gradle 配置与 wrapper
```

## 模块关系图（职责链路）
``` 
UI(Activities/Fragments)
        ↓
ViewModel（页面状态与业务）
        ↓
Repository（数据协调）
        ↓
Data（Retrofit/OkHttp/Room/Entity）
```

## Skills 骨架图（学习助手）
```
.claude/
└── skills/
    └── android-learn/
       ├── SKILL.md        # 入口 (37行) - 触发词 + 一级路由 + 执行流程
       ├── router.yaml     # L1 完整关键词路由表
       ├── modules.yaml    # L2 模块路径与分析点
       └── output.yaml     # L3 输出模板与导出规则
```

### Skills 层级作用
- `router.yaml`：按关键词路由到模块 ID（L1）。
- `modules.yaml`：模块定义（base_path、paths、analyze、interview、export）（L2）。
- `output.yaml`：输出模板、任务规则、导出路径与索引更新规则。

### Skills 使用方式（单模块）
1. 先用 `router.yaml` 根据关键词确定模块 ID（或直接从 `modules.yaml` 选模块）。
2. 在 `modules.yaml` 中读取该模块的路径与分析要点。
3. 按 `output.yaml` 的模板生成 `learn_plan/module-{id}-{date}.md` 并更新 `## Completed Analyses`。

## 插件与构建入口（先知晓）
- Android Gradle Plugin：项目构建与打包入口（`build.gradle.kts`, `app/build.gradle.kts`）。
- Kotlin Android Plugin：Kotlin 编译与 Android 集成。
- KSP：Room 编译期生成（`ksp(libs.room.compiler)`）。

## 学习流程（建议顺序）
1. **全局结构与构建入口**  
   先看 `settings.gradle.kts`、`build.gradle.kts` 与 `app/build.gradle.kts`，理解单模块结构与依赖来源。
2. **MVVM 基类约定**  
   阅读 `app/src/main/java/com/yechaoa/wanandroid_jetpack/base/`，理解 Activity/Fragment/ViewModel 的统一封装。
3. **主流程 UI 与导航**  
   从 `ui/main/`、`ui/home/` 入手，掌握页面切换、列表加载与 ViewModel 关联。
4. **数据链路与插件原理**  
   追踪 `data/http/`（Retrofit/OkHttp）与 `data/room/`（Room + KSP），理解数据从接口到本地缓存的路径。
5. **功能模块拆解**  
   按 `ui/login/`、`ui/search/`、`ui/collect/` 等模块逐个深入，结合业务流程与接口模型。
6. **测试与规范补充**
   关注 `src/test/` 与 `src/androidTest/`，理解 JUnit/Espresso 的使用与命名规则。

## Completed Analyses

| Module | Date | File |
|--------|------|------|
| Main UI & Home Navigation | 2024-12-24 | [module-ui-main-home-20251224.md](./module-ui-main-home-20251224.md) |
| Login | 2024-12-24 | [module-login-20251224.md](./module-login-20251224.md) |
