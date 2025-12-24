---
name: android-learn
description: |
  分析Android项目模块用于学习。触发: 分析/学习/讲解 + 模块关键词。
  模块: build|mvvm|home|data|feature|test。
---

# Android Learn Skill

## 触发词
`分析|学习|讲解|analyze|learn` + 模块关键词

## 一级路由
| ID | 关键词 |
|----|--------|
| build | gradle,构建,plugin,manifest |
| mvvm | base,viewmodel,基类,架构 |
| home | main,首页,导航,bottomnav |
| data | http,retrofit,room,网络,数据 |
| feature | login,search,collect,登录,搜索 |
| test | test,测试,lint,coverage |

## 执行流程
1. 匹配关键词 → module_id
2. 读取 `router.yaml` → 验证/获取完整路由
3. 读取 `modules.yaml` → paths + analyze + interview
4. 读取源文件 → 分析
5. 读取 `output.yaml` → 生成输出
6. 导出 → `learn_plan/module-{id}-{date}.md`

## 配置引用
```
./router.yaml   # L1 完整关键词路由表
./modules.yaml  # L2 模块路径与分析点定义
./output.yaml   # L3 输出模板与导出规则
```
