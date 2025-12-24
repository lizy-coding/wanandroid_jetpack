# Analyze Module

分析项目模块用于学习。输入: $ARGUMENTS

## 执行流程

### L1: 路由匹配
1. 读取 `.claude/skills/android-learn/router.yaml`
2. 用户输入与 `routes` 关键词匹配 → 确定 `module_id`
3. 无匹配时询问用户选择: build|mvvm|home|data|feature|test

### L2: 模块执行
1. 读取 `.claude/skills/android-learn/modules.yaml`
2. 获取 `modules[module_id]` 配置
3. 展开 `paths` (替换 `$` 为 `base_path`)
4. 读取所有源文件并分析

### L3: 输出生成
1. 读取 `.claude/skills/android-learn/output.yaml`
2. 填充模板变量生成分析报告
3. 导出到 `learn_plan/module-{id}-{YYYYMMDD}.md`
4. 更新 `learn_plan/LEARNING_PLAN.md` 索引

## 快速示例

```
/analyze login    → feature.login
/analyze 网络     → data
/analyze mvvm     → mvvm
/analyze 首页     → home
/analyze gradle   → build
/analyze 测试     → test
```

## 配置引用

- L1 路由: `skills/android-learn/router.yaml`
- L2 模块: `skills/android-learn/modules.yaml`
- L3 输出: `skills/android-learn/output.yaml`
