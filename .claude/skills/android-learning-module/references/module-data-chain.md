# Module Workflow: data-chain

Scope derived from `LEARNING_PLAN.md` skeleton or project module analysis:
- Data chain with Retrofit/OkHttp and Room/KSP
- `data/http/`, `data/room/`

Steps:
1. Read `app/src/main/java/com/yechaoa/wanandroid_jetpack/data/http/` and `app/src/main/java/com/yechaoa/wanandroid_jetpack/data/room/`.
2. Trace request -> repository -> cache -> UI; note error handling and threading.
3. Map to interview topics: networking, serialization, database schema, migrations, caching strategy.
4. Pull job requirements using `scripts/fetch_job_requirements.sh` and summarize with `scripts/summarize_job_requirements.sh`.
   - Skip this step unless the user asks for interview/job-market alignment.
   - If blocked, request 3-5 recent job posts.
5. Produce output using `references/module-shared-format.md`.
