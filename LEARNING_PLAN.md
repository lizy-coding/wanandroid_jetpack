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
skills/
└── android-learning-module/
    ├── SKILL.md                         # 路由与触发规则
    ├── references/
    │   ├── module-shared-format.md      # 统一输出格式
    │   ├── module-build-and-structure.md
    │   ├── module-mvvm-base.md
    │   ├── module-ui-main-home.md
    │   ├── module-data-chain.md
    │   ├── module-feature-modules.md
    │   └── module-testing-quality.md
    └── scripts/
        ├── fetch_job_requirements.sh
        └── summarize_job_requirements.sh
android-learning-module.skill            # 打包产物
```

### Skills 层级作用
- `SKILL.md`：只负责识别用户输入并路由到对应的二级模块工作流。
- `references/module-*.md`：按模块拆分的二级工作流，规定分析步骤与产出要求。
- `references/module-shared-format.md`：所有模块统一的输出格式模板。
- `scripts/*.sh`：招聘要求检索与归类工具（只标识用途，不展开实现）。
- `.skill`：可分发的技能包，便于复用与迁移。

### Skills 使用方式（单模块）
1. 从 `LEARNING_PLAN.md` 中选定一个模块（一次只分析一个）。
2. 由 `SKILL.md` 将模块映射到对应的 `references/module-*.md`。
3. 按模块工作流读取项目路径并输出分析结果。
4. 如需招聘要求，对接 `scripts/fetch_job_requirements.sh` + `scripts/summarize_job_requirements.sh`；若不可用，手动补充招聘信息。
5. 输出必须遵循 `references/module-shared-format.md`。

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

