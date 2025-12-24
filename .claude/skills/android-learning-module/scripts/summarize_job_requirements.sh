#!/usr/bin/env bash
set -euo pipefail

usage() {
  cat <<'EOF'
Usage: summarize_job_requirements.sh --module <name> [--input <path>] [--top <n>]

Options:
  --module <name>        build-and-structure | mvvm-base | ui-main-home | data-chain | feature-modules | testing-quality
  --input <path>         Read job posts from a local file (default: stdin)
  --top <n>              Number of repeated keywords to show (default: 10)
  -h, --help             Show help
EOF
}

module="general"
input_path=""
top_n=10

while [[ $# -gt 0 ]]; do
  case "$1" in
    --module)
      module="$2"
      shift 2
      ;;
    --input)
      input_path="$2"
      shift 2
      ;;
    --top)
      top_n="$2"
      shift 2
      ;;
    -h|--help)
      usage
      exit 0
      ;;
    *)
      echo "Unknown option: $1" >&2
      usage >&2
      exit 1
      ;;
  esac
done

tmp_input="$(mktemp)"
tmp_clean="$(mktemp)"
tmp_counts="$(mktemp)"

cleanup() {
  rm -f "$tmp_input" "$tmp_clean" "$tmp_counts"
}
trap cleanup EXIT

if [[ -n "$input_path" ]]; then
  cat "$input_path" > "$tmp_input"
elif [[ ! -t 0 ]]; then
  cat > "$tmp_input"
else
  echo "No input provided. Use --input or pipe text to stdin." >&2
  exit 2
fi

rg -v '^(QUERY|SOURCE|NOTE|#):' "$tmp_input" > "$tmp_clean" || true

keyword_lines_base() {
  cat <<'EOF'
kotlin|kotlin|core
java|java|core
android|android|core
git|git|tooling
ci|ci/cd|tooling
EOF
}

keyword_lines_module() {
  case "$module" in
    build-and-structure)
      cat <<'EOF'
gradle|gradle|core
agp|android gradle plugin|core
build variants|build variants?|core
product flavors|product flavors?|core
dependency management|dependency management|core
version catalog|version catalog|core
buildsrc|buildsrc|core
kotlin dsl|kotlin dsl|core
signing|signing|core
build performance|build performance|advanced
configuration cache|configuration cache|advanced
build cache|build cache|advanced
r8|r8|advanced
proguard|proguard|advanced
shrinker|shrinker|advanced
modularization|modularization|advanced
multi module|multi-?module|advanced
task graph|task graph|advanced
lint|android lint|tooling
detekt|detekt|tooling
ktlint|ktlint|tooling
fastlane|fastlane|tooling
github actions|github actions|tooling
jenkins|jenkins|tooling
EOF
      ;;
    mvvm-base)
      cat <<'EOF'
mvvm|mvvm|core
viewmodel|viewmodel|core
livedata|live data|core
stateflow|stateflow|core
flow|kotlin flow|core
lifecycle|lifecycle|core
savedstatehandle|savedstatehandle|core
mvi|mvi|advanced
clean architecture|clean architecture|advanced
unidirectional data flow|unidirectional data flow|advanced
singleliveevent|singleliveevent|advanced
event wrapper|event wrapper|advanced
coroutine scope|coroutine scope|advanced
dispatcher|dispatcher|advanced
hilt|hilt|tooling
dagger|dagger|tooling
koin|koin|tooling
junit|junit|tooling
mockk|mockk|tooling
coroutines test|coroutines test|tooling
EOF
      ;;
    ui-main-home)
      cat <<'EOF'
navigation component|navigation component|core
fragment|fragment|core
activity|activity|core
recyclerview|recyclerview|core
listadapter|listadapter|core
viewbinding|viewbinding|core
databinding|databinding|core
compose|jetpack compose|core
xml layout|xml layout|core
paging|paging|advanced
diffutil|diffutil|advanced
animation|animation|advanced
configuration change|configuration changes?|advanced
accessibility|accessibility|advanced
multi type|multi-?type|advanced
glide|glide|tooling
coil|coil|tooling
fresco|fresco|tooling
safe args|safe args|tooling
EOF
      ;;
    data-chain)
      cat <<'EOF'
retrofit|retrofit|core
okhttp|okhttp|core
room|room|core
sqlite|sqlite|core
dao|dao|core
entity|entity|core
repository|repository|core
serialization|serialization|core
moshi|moshi|core
gson|gson|core
caching|cache|advanced
offline|offline|advanced
interceptor|interceptor|advanced
paging|paging|advanced
migration|migration|advanced
transaction|transaction|advanced
error handling|error handling|advanced
coroutine|coroutine|advanced
ksp|ksp|tooling
kapt|kapt|tooling
logging interceptor|logging interceptor|tooling
stetho|stetho|tooling
EOF
      ;;
    feature-modules)
      cat <<'EOF'
feature module|feature module|core
login|login|core
search|search|core
collect|collect|core
business flow|business flow|core
validation|validation|core
api integration|api integration|core
state management|state management|advanced
error handling|error handling|advanced
edge cases|edge cases|advanced
analytics|analytics|advanced
feature flag|feature flag|advanced
crashlytics|crashlytics|tooling
firebase analytics|firebase analytics|tooling
remote config|remote config|tooling
EOF
      ;;
    testing-quality)
      cat <<'EOF'
junit|junit|core
espresso|espresso|core
unit test|unit tests?|core
instrumented test|instrumented tests?|core
mockito|mockito|core
mockk|mockk|core
robolectric|robolectric|advanced
test coverage|coverage|advanced
flaky|flaky|advanced
testability|testability|advanced
test doubles|test doubles?|advanced
jacoco|jacoco|tooling
firebase test lab|test lab|tooling
gradle test|gradle test|tooling
EOF
      ;;
    *)
      cat <<'EOF'
mvvm|mvvm|core
viewmodel|viewmodel|core
coroutines|coroutines?|core
flow|flow|core
retrofit|retrofit|core
room|room|core
recyclerview|recyclerview|core
gradle|gradle|tooling
EOF
      ;;
  esac
}

while IFS='|' read -r label regex category; do
  if [[ -z "$label" ]]; then
    continue
  fi
  matches="$(rg -i -o -e "$regex" "$tmp_clean" 2>/dev/null || true)"
  if [[ -z "$matches" ]]; then
    count=0
  else
    count="$(printf "%s\n" "$matches" | wc -l | tr -d ' ')"
  fi
  if [[ "$count" -gt 0 ]]; then
    printf "%s\t%s\t%s\n" "$count" "$label" "$category" >> "$tmp_counts"
  fi
done < <(cat <(keyword_lines_base) <(keyword_lines_module))

if [[ ! -s "$tmp_counts" ]]; then
  echo "REPEATED_KEYWORDS:"
  echo "- (no matches)"
  echo "CORE:"
  echo "- (none found)"
  echo "ADVANCED:"
  echo "- (none found)"
  echo "TOOLING:"
  echo "- (none found)"
  exit 0
fi

echo "REPEATED_KEYWORDS:"
sort -nr -k1,1 "$tmp_counts" | head -n "$top_n" | awk -F'\t' '{print "- " $2 " (" $1 ")"}'

print_bucket() {
  local bucket="$1"
  local header="$2"
  local lines
  lines="$(awk -F'\t' -v b="$bucket" '$3==b {print $1 "\t" $2}' "$tmp_counts" | sort -nr -k1,1)"
  echo "${header}:"
  if [[ -z "$lines" ]]; then
    echo "- (none found)"
  else
    printf "%s\n" "$lines" | awk -F'\t' '{print "- " $2 " (" $1 ")"}'
  fi
}

print_bucket "core" "CORE"
print_bucket "advanced" "ADVANCED"
print_bucket "tooling" "TOOLING"
