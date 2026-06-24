#!/usr/bin/env bash
# Detect the single root-level .kicad_pcb file.
#
# This template supports exactly one board per repo, with the .kicad_pcb
# living at the repository root. This script enforces that contract and
# fails loudly if it is violated.
#
# Outputs:
#   board       — basename of the detected board, no extension
#   board_file  — basename including the extension
#
# Outputs are written to $GITHUB_OUTPUT when set (CI), and also printed
# to stdout (useful for local debugging).
#
# Usage:
#   scripts/detect_board.sh [output_file]
#
# Exits non-zero if there is not exactly one root-level .kicad_pcb.

set -euo pipefail

# Allow callers to pass an explicit output file. Default to $GITHUB_OUTPUT.
OUTPUT_FILE="${GITHUB_OUTPUT:-${1:-}}"

# Collect root-level *.kicad_pcb files. POSIX-portable: no mapfile,
# no find -printf, works on macOS bash 3.2 and Linux bash 4+.
BOARDS=()
while IFS= read -r line; do
  BOARDS+=("$line")
done < <(find . -maxdepth 1 -mindepth 1 -type f -name '*.kicad_pcb' \
            | sed 's|^\./||' \
            | sort)

if [[ ${#BOARDS[@]} -eq 0 ]]; then
  echo "::error::No .kicad_pcb file found at the repository root." >&2
  echo "::error::This template requires exactly one board per repo, with the" >&2
  echo "::error::.kicad_pcb at the repo root." >&2
  exit 1
fi

if [[ ${#BOARDS[@]} -gt 1 ]]; then
  echo "::error::Found ${#BOARDS[@]} .kicad_pcb files at the repo root:" >&2
  for b in "${BOARDS[@]}"; do
    echo "::error::  - $b" >&2
  done
  echo "::error::This template supports exactly one board per repository." >&2
  exit 1
fi

BOARD_FILE="${BOARDS[0]}"
BOARD="${BOARD_FILE%.kicad_pcb}"

echo "Detected board: ${BOARD_FILE}"

# Emit outputs for downstream steps. Both $GITHUB_OUTPUT (in Actions) and
# stdout printing are handled so this script is also useful locally.
if [[ -n "${OUTPUT_FILE}" ]]; then
  {
    echo "board=${BOARD}"
    echo "board_file=${BOARD_FILE}"
  } >> "${OUTPUT_FILE}"
fi

echo "board=${BOARD}"
echo "board_file=${BOARD_FILE}"