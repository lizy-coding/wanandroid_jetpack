# Module Workflow: build-and-structure

Scope derived from `LEARNING_PLAN.md` skeleton or project module analysis:
- Global structure & build entrypoints
- `settings.gradle.kts`, `build.gradle.kts`, `app/build.gradle.kts`, `buildSrc/`, `gradle/`

Steps:
1. Read build entrypoints and identify how the single app module is wired.
2. Explain dependency/version centralization and plugin setup.
3. Map to interview topics: build pipeline, Gradle plugins, build variants, dependency resolution, build performance.
4. Pull job requirements using `scripts/fetch_job_requirements.sh` and summarize with `scripts/summarize_job_requirements.sh`.
   - Skip this step unless the user asks for interview/job-market alignment.
   - If blocked, request 3-5 recent job posts.
5. Produce output using `references/module-shared-format.md`.
