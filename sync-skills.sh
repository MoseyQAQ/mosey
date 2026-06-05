#!/usr/bin/env bash
set -euo pipefail

usage() {
  cat <<'EOF'
Usage:
  ./sync-skills.sh [options]

Default:
  ./sync-skills.sh --daily global --research global

Options:
  --daily <global|project|none>     Link Daily skills to the selected target.
  --research <global|project|none>  Link Research skills to the selected target.
  --target <global|project|none>    Shortcut that sets both --daily and --research.
  --project-dir <path>              Project root for project links. Default: current directory.
  --no-pull                         Skip git pull --ff-only.
  --dry-run                         Print planned actions without changing files.
  --force                           Replace conflicting target files, directories, or symlinks.
  --help                            Show this help.
EOF
}

error() {
  printf 'error: %s\n' "$*" >&2
  exit 1
}

log_action() {
  printf '%-10s %s\n' "$1" "$2"
}

validate_target() {
  case "$1" in
    global|project|none) ;;
    *) error "invalid target '$1'; expected global, project, or none" ;;
  esac
}

canonical_dir() {
  local path=$1
  (cd "$path" && pwd -P)
}

canonical_existing_path() {
  local path=$1
  if [[ -d "$path" ]]; then
    canonical_dir "$path"
  else
    local dir
    local base
    dir=$(dirname "$path")
    base=$(basename "$path")
    printf '%s/%s\n' "$(canonical_dir "$dir")" "$base"
  fi
}

resolve_symlink_target() {
  local link_path=$1
  local raw_target
  raw_target=$(readlink "$link_path")

  if [[ "$raw_target" = /* ]]; then
    printf '%s\n' "$raw_target"
  else
    printf '%s/%s\n' "$(dirname "$link_path")" "$raw_target"
  fi
}

same_symlink_target() {
  local link_path=$1
  local source_path=$2
  local raw_target
  raw_target=$(resolve_symlink_target "$link_path")

  [[ -e "$raw_target" ]] || return 1
  [[ "$(canonical_existing_path "$raw_target")" == "$(canonical_existing_path "$source_path")" ]]
}

link_skill() {
  local group=$1
  local source_path=$2
  local target_base=$3
  local skill_name
  local target_path

  skill_name=$(basename "$source_path")
  target_path="$target_base/$skill_name"

  log_action "skill" "$group/$skill_name"
  log_action "source" "$source_path"
  log_action "target" "$target_path"

  if [[ "$dry_run" == "1" ]]; then
    if [[ -L "$target_path" ]] && same_symlink_target "$target_path" "$source_path"; then
      log_action "would" "leave unchanged"
    elif [[ -e "$target_path" || -L "$target_path" ]]; then
      if [[ "$force" == "1" ]]; then
        log_action "would" "replace conflict and link"
      else
        log_action "would" "report conflict"
      fi
    else
      log_action "would" "create symlink"
    fi
    printf '\n'
    return 0
  fi

  mkdir -p "$target_base"

  if [[ -L "$target_path" ]] && same_symlink_target "$target_path" "$source_path"; then
    log_action "action" "unchanged"
    printf '\n'
    return 0
  fi

  if [[ -e "$target_path" || -L "$target_path" ]]; then
    if [[ "$force" != "1" ]]; then
      log_action "action" "conflict"
      printf '\n'
      return 1
    fi

    rm -rf "$target_path"
    ln -s "$source_path" "$target_path"
    log_action "action" "replaced"
    printf '\n'
    return 0
  fi

  ln -s "$source_path" "$target_path"
  log_action "action" "linked"
  printf '\n'
}

link_group() {
  local group=$1
  local target_kind=$2
  local source_base="$repo_root/$group"
  local target_base
  local found=0
  local failed=0
  local source_path

  case "$target_kind" in
    global) target_base="$HOME/.codex/skills" ;;
    project) target_base="$project_dir/.codex/skills" ;;
    none)
      log_action "group" "$group skipped"
      printf '\n'
      return 0
      ;;
    *) error "internal invalid target '$target_kind'" ;;
  esac

  [[ -d "$source_base" ]] || {
    log_action "group" "$group missing"
    printf '\n'
    return 0
  }

  for source_path in "$source_base"/*; do
    [[ -d "$source_path" ]] || continue
    [[ -f "$source_path/SKILL.md" ]] || continue
    found=1
    if ! link_skill "$group" "$source_path" "$target_base"; then
      failed=1
    fi
  done

  if [[ "$found" == "0" ]]; then
    log_action "group" "$group has no SKILL.md directories"
    printf '\n'
  fi

  return "$failed"
}

invocation_dir=$(pwd -P)
script_dir=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd -P)
repo_root=$script_dir

daily_target=global
research_target=global
project_dir=$invocation_dir
no_pull=0
dry_run=0
force=0

while [[ $# -gt 0 ]]; do
  case "$1" in
    --daily)
      [[ $# -ge 2 ]] || error "--daily requires a value"
      validate_target "$2"
      daily_target=$2
      shift 2
      ;;
    --research)
      [[ $# -ge 2 ]] || error "--research requires a value"
      validate_target "$2"
      research_target=$2
      shift 2
      ;;
    --target)
      [[ $# -ge 2 ]] || error "--target requires a value"
      validate_target "$2"
      daily_target=$2
      research_target=$2
      shift 2
      ;;
    --project-dir)
      [[ $# -ge 2 ]] || error "--project-dir requires a value"
      project_dir=$(cd "$2" && pwd -P)
      shift 2
      ;;
    --no-pull)
      no_pull=1
      shift
      ;;
    --dry-run)
      dry_run=1
      shift
      ;;
    --force)
      force=1
      shift
      ;;
    --help|-h)
      usage
      exit 0
      ;;
    *)
      error "unknown option '$1'"
      ;;
  esac
done

log_action "repo" "$repo_root"
log_action "daily" "$daily_target"
log_action "research" "$research_target"
log_action "project" "$project_dir"

if [[ "$no_pull" == "1" ]]; then
  log_action "pull" "skipped (--no-pull)"
elif [[ "$dry_run" == "1" ]]; then
  log_action "pull" "would run git pull --ff-only"
else
  log_action "pull" "running git pull --ff-only"
  git -C "$repo_root" pull --ff-only
fi
printf '\n'

failed=0
link_group "Daily" "$daily_target" || failed=1
link_group "Research" "$research_target" || failed=1

if [[ "$failed" == "1" ]]; then
  error "one or more skill links had conflicts; rerun with --force to replace them"
fi
