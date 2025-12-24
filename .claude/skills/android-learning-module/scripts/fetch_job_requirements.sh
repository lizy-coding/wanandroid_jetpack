#!/usr/bin/env bash
set -euo pipefail

usage() {
  cat <<'EOF'
Usage: fetch_job_requirements.sh --module <name> [options]

Options:
  --module <name>        build-and-structure | mvvm-base | ui-main-home | data-chain | feature-modules | testing-quality
  --role <text>          Role keyword (default: Android Developer)
  --location <text>      Location keyword (optional)
  --experience <text>    Experience keyword (default: 3 years)
  --source-file <path>   Read job posts from a local file
  --source-url <url>     Fetch job posts from a URL (requires network access)
  --query-only           Print the query string and exit
  --output <path>        Write output to a file (default: stdout)
  -h, --help             Show help

Notes:
  - If no source is provided, the script prints the query and exits with code 2.
  - If stdin is piped, it will be used as the source.
EOF
}

module="general"
role="Android Developer"
location=""
experience="3 years"
source_file=""
source_url=""
query_only=0
output_path=""

while [[ $# -gt 0 ]]; do
  case "$1" in
    --module)
      module="$2"
      shift 2
      ;;
    --role)
      role="$2"
      shift 2
      ;;
    --location)
      location="$2"
      shift 2
      ;;
    --experience)
      experience="$2"
      shift 2
      ;;
    --source-file)
      source_file="$2"
      shift 2
      ;;
    --source-url)
      source_url="$2"
      shift 2
      ;;
    --query-only)
      query_only=1
      shift
      ;;
    --output)
      output_path="$2"
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

module_keywords() {
  case "$module" in
    build-and-structure)
      echo "Gradle AGP build variants product flavors dependency management version catalog build performance"
      ;;
    mvvm-base)
      echo "MVVM ViewModel LiveData StateFlow lifecycle SavedStateHandle coroutines"
      ;;
    ui-main-home)
      echo "Navigation Component RecyclerView ListAdapter ViewBinding DataBinding UI state Compose"
      ;;
    data-chain)
      echo "Retrofit OkHttp Room SQLite repository caching serialization"
      ;;
    feature-modules)
      echo "feature module login search business flow validation API integration"
      ;;
    testing-quality)
      echo "JUnit Espresso unit test instrumented test mock test coverage"
      ;;
    *)
      echo "Kotlin Android Jetpack MVVM"
      ;;
  esac
}

query="${role} ${experience} $(module_keywords)"
if [[ -n "$location" ]]; then
  query="${query} ${location}"
fi

out="${output_path:-/dev/stdout}"

if [[ "$query_only" -eq 1 ]]; then
  echo "QUERY: ${query}" > "$out"
  exit 0
fi

{
  echo "QUERY: ${query}"
  if [[ -n "$source_file" ]]; then
    cat "$source_file"
  elif [[ -n "$source_url" ]]; then
    curl -L -s "$source_url"
  elif [[ ! -t 0 ]]; then
    cat
  else
    echo "NOTE: No source provided. Use --source-file, --source-url, or pipe input." >&2
    exit 2
  fi
} > "$out"
