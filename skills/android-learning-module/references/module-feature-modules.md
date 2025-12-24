# Module Workflow: feature-modules

Scope derived from `LEARNING_PLAN.md` skeleton:
- Feature modules: login/search/collect/etc.
- `ui/login/`, `ui/search/`, `ui/collect/` and other feature folders under `ui/`

Steps:
1. If the feature is not explicit, ask the user to name one module under `ui/`.
2. Read the target feature folder and identify UI + ViewModel + repository touchpoints.
3. Map to interview topics: feature-driven architecture, input validation, error/edge cases, API integration.
4. Pull job requirements using `scripts/fetch_job_requirements.sh` and summarize with `scripts/summarize_job_requirements.sh`.
   - If blocked, request 3-5 recent job posts.
5. Produce output using `references/module-shared-format.md`.
