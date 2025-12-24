# Repository Guidelines

## Project Structure
```
app/src/main/java/com/yechaoa/wanandroid_jetpack/
├── base/     # MVVM base classes
├── common/   # Config constants
├── data/     # Network + Room + Entities
├── ui/       # Features (login/search/collect/main/...)
└── util/     # Helpers
```

## Commands
| Task | Command |
|------|---------|
| Build debug | `./gradlew assembleDebug` |
| Install | `./gradlew installDebug` |
| Build release | `./gradlew assembleRelease` |
| Unit test | `./gradlew testDebugUnitTest` |
| UI test | `./gradlew connectedDebugAndroidTest` |
| Lint | `./gradlew lintDebug` |

## Code Style
- Kotlin JVM 17, 4-space indent
- Class: `PascalCase`, func/var: `camelCase`, const: `UPPER_SNAKE`
- Resource: `lower_snake_case`
- MVVM: UI→ViewModel→Repository→Data

## Commit Style
`type: description` (feat/fix/style/refactor/test/docs)

---

## Learning Module Skill

分析项目模块用于学习，使用 `/analyze <module>` 或自然语言触发。

### 双层架构
```
L1: router.yaml    → 关键词匹配 → module_id
L2: modules.yaml   → 路径+分析点+面试主题
L3: output.yaml    → 输出模板
```

### 配置路径
```
.claude/skills/android-learn/
├── router.yaml   # 关键词路由表
├── modules.yaml  # 模块执行配置
└── output.yaml   # 输出格式模板
```

### 模块 ID
| ID | 关键词 |
|----|--------|
| build | gradle,manifest,构建,plugin |
| mvvm | base,viewmodel,基类,架构 |
| home | main,首页,导航,bottomnav |
| data | http,retrofit,room,网络,数据 |
| feature | login,search,collect,登录,搜索 |
| test | test,测试,lint,coverage |

### 执行流程
1. 匹配关键词 → `router.yaml`
2. 加载模块配置 → `modules.yaml`
3. 读取源文件并分析
4. 生成报告 → `output.yaml`
5. 导出 → `learn_plan/module-{id}-{date}.md`

### 触发方式
- 命令: `/analyze login`
- 自然语言: "分析登录模块" / "学习网络层"
