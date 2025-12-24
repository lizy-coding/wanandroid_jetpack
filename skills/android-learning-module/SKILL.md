---
name: android-learning-module
description: Route a single learning-module request (from LEARNING_PLAN.md) to the correct second-level workflow for 3-year Android social hire study analysis, interview focus expansion, and job-market-aligned guidance.
---

# Android Learning Module

## Router only

Use this skill only to route a single module request to the correct second-level workflow.

## Route map

1. Confirm the user asked for exactly one module; if not, ask for one module from `LEARNING_PLAN.md`.
2. Identify the module type and load the matching workflow file in `references/`.
3. Execute that workflow and return its specified output.

Module types and routes:
- Global structure/build entrypoints -> `references/module-build-and-structure.md`
- MVVM base conventions -> `references/module-mvvm-base.md`
- Main UI/navigation (main/home) -> `references/module-ui-main-home.md`
- Data chain (http/room/ksp) -> `references/module-data-chain.md`
- Feature modules (login/search/collect/etc.) -> `references/module-feature-modules.md`
- Testing/quality -> `references/module-testing-quality.md`

## Rules

- Do not perform analysis here; only route to the second-level workflow.
- Keep output to the workflow's required format.
