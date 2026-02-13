#!/usr/bin/env bash
set -euo pipefail

# Usage:
#   move-workspaces.sh "<output_match>" "<workspaces_regex_or_list>" [focus_ws]
#
# Examples:
#   move-workspaces.sh "Microstep MPG271QX" "1 2 3" 1
#   move-workspaces.sh "DELL P2425" "4" 4

TARGET_MATCH="${1:-}"
WS_LIST="${2:-}"
FOCUS_WS="${3:-}"

if [[ -z "$TARGET_MATCH" || -z "$WS_LIST" ]]; then
  echo "Usage: $0 <output_match> <\"1 2 3\"|\"4\"> [focus_ws]" >&2
  exit 2
fi

# Find output .name (DP-x etc) by matching on name/description/make/model/serial
OUT="$(swaymsg -t get_outputs -r | jq -r --arg m "$TARGET_MATCH" '
  .[] | select(.active) |
  select(
    (.name // "" | contains($m)) or
    (.description // "" | contains($m)) or
    (.make // "" | contains($m)) or
    (.model // "" | contains($m)) or
    (.serial // "" | contains($m))
  ) |
  .name
' | head -n1)"

if [[ -z "$OUT" ]]; then
  echo "move-workspaces: no active output matched: $TARGET_MATCH" >&2
  exit 0
fi

# Move each workspace in the list
for ws in $WS_LIST; do
  swaymsg "workspace $ws; move workspace to output $OUT" >/dev/null
done

# Optional: focus a workspace at end
if [[ -n "$FOCUS_WS" ]]; then
  swaymsg "workspace $FOCUS_WS" >/dev/null
fi
