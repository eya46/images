#!/usr/bin/env bash
set -euo pipefail

is_image_dir() {
  local name=$1
  [[ -f $name/Dockerfile && -f $name/VERSION ]]
}

all_images() {
  find . -mindepth 1 -maxdepth 1 -type d ! -name '.*' -printf '%f\n' | sort | while read -r name; do
    if is_image_dir "$name"; then
      printf '%s\n' "$name"
    fi
  done
}

to_json() {
  python3 -c 'import json,sys; print(json.dumps([line.strip() for line in sys.stdin if line.strip()]))'
}

mode=${1:-auto}
explicit=${2:-}

case $mode in
  one)
    if [[ -z $explicit ]]; then
      echo "image name required" >&2
      exit 1
    fi
    if ! is_image_dir "$explicit"; then
      echo "not an image directory: $explicit" >&2
      exit 1
    fi
    printf '%s\n' "$explicit" | to_json
    ;;
  all)
    all_images | to_json
    ;;
  auto)
    before=${BEFORE_SHA:-}
    if [[ -z $before || $before =~ ^0+$ ]]; then
      all_images | to_json
      exit 0
    fi
    git diff --name-only "$before" "${GITHUB_SHA:-HEAD}" \
      | awk -F/ 'NF { print $1 }' \
      | sort -u \
      | while read -r name; do
          [[ -d $name ]] || continue
          is_image_dir "$name" && printf '%s\n' "$name"
        done \
      | to_json
    ;;
  *)
    echo "unknown mode: $mode" >&2
    exit 1
    ;;
esac
