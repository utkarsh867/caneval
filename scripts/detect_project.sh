#!/usr/bin/env bash
# Resolve the project file (or schematic) that matches the board.
#
# KiRi and KiBot prefer .kicad_pro for project-level operations, but many
# KiCad projects store only the .kicad_sch (or even just the .kicad_pcb).
# This script picks the most-specific file that exists, in this order:
#
#   1. <board>.kicad_pro
#   2. <board>.kicad_sch
#   3. <board>.kicad_pcb  (fallback)
#
# Usage:
#   scripts/detect_project.sh <board>
#
# Prints the resolved path on stdout, suitable for `$(...)` substitution.

set -euo pipefail

if [[ $# -lt 1 ]]; then
  echo "::error::detect_project.sh requires the board basename as an argument." >&2
  exit 1
fi

BOARD="$1"

if [[ -f "${BOARD}.kicad_pro" ]]; then
  echo "${BOARD}.kicad_pro"
elif [[ -f "${BOARD}.kicad_sch" ]]; then
  echo "${BOARD}.kicad_sch"
elif [[ -f "${BOARD}.kicad_pcb" ]]; then
  echo "${BOARD}.kicad_pcb"
else
  echo "::error::No project file found for board '${BOARD}'." >&2
  echo "::error::Expected one of: ${BOARD}.kicad_pro, ${BOARD}.kicad_sch, ${BOARD}.kicad_pcb" >&2
  exit 1
fi