---
name: android-learning-module
description: Route and execute the correct workflow for Android module analysis when a user asks to analyze a specific project feature/module (e.g., login/search/collect), main UI/home navigation, MVVM base conventions, data chain (http/room/ksp), build/structure, or testing/quality; also handle single-module requests from LEARNING_PLAN.md.
---

# Android Learning Module

## Router + executor

Use this skill to identify a single module in the prompt and then run the matching workflow in `references/`.

## Route map

1. Confirm the user asked for exactly one module; if not, ask for one module name.
2. Identify the module type from prompt keywords and project context.
3. Load the matching workflow file in `references/` and execute it.
4. Return the output in the workflow's required format.

Module types and routes:
- Build/structure/entrypoint/Gradle/manifest -> `references/module-build-and-structure.md`
- MVVM base conventions/base classes -> `references/module-mvvm-base.md`
- Main UI/home/navigation (main/home) -> `references/module-ui-main-home.md`
- Data chain (http/room/ksp/network/repository) -> `references/module-data-chain.md`
- Feature modules (login/register/search/collect/profile/settings/etc.) -> `references/module-feature-modules.md`
- Testing/quality (unit/ui/lint/coverage) -> `references/module-testing-quality.md`

## Rules

- If the prompt names a feature in Chinese or English, treat it as a feature module even without "ui/".
- If the prompt mentions `LEARNING_PLAN.md`, treat it as a learning-module request.
- Do not perform analysis here; only run the referenced workflow.
- Keep output to the workflow's required format.
