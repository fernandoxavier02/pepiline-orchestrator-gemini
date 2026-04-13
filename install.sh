#!/usr/bin/env bash
# ============================================================================
# Pipeline Orchestrator — Gemini CLI Extension Installer
# ============================================================================
# Usage:
#   git clone https://github.com/fernandoxavier02/pepiline-orchestrator-gemini.git
#   cd pepiline-orchestrator-gemini
#   chmod +x install.sh
#   ./install.sh
#
# What it does:
#   1. Copies extension files (agents, skills, commands, manifest)
#      → ~/.gemini/extensions/pipeline-orchestrator/
#   2. Copies shared references (checklists, gates, pipelines)
#      → ~/.gemini/skills/pipeline/references/
#
# Both locations are required for the extension to function correctly.
# ============================================================================

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SOURCE_DIR="${SCRIPT_DIR}/extension"
GEMINI_DIR="${HOME}/.gemini"
EXTENSION_DIR="${GEMINI_DIR}/extensions/pipeline-orchestrator"
REFERENCES_DIR="${GEMINI_DIR}/skills/pipeline/references"

echo ""
echo "╔══════════════════════════════════════════════════════════════╗"
echo "║  Pipeline Orchestrator — Gemini CLI Extension Installer     ║"
echo "║  Version 1.3.0                                              ║"
echo "╚══════════════════════════════════════════════════════════════╝"
echo ""

# ── Pre-checks ──────────────────────────────────────────────────────

if [ ! -d "${SOURCE_DIR}" ]; then
  echo "[ERROR] extension/ directory not found."
  echo "        Run this script from the repo root."
  exit 1
fi

if [ ! -d "${GEMINI_DIR}" ]; then
  echo "[ERROR] Gemini CLI directory not found at ${GEMINI_DIR}"
  echo "        Install Gemini CLI first: https://github.com/google-gemini/gemini-cli"
  exit 1
fi

# ── Step 1: Install extension ───────────────────────────────────────

echo "[1/3] Installing extension → ${EXTENSION_DIR}"
mkdir -p "${EXTENSION_DIR}"

for dir in agents skills commands; do
  if [ -d "${SOURCE_DIR}/${dir}" ]; then
    mkdir -p "${EXTENSION_DIR}/${dir}"
    cp -r "${SOURCE_DIR}/${dir}/." "${EXTENSION_DIR}/${dir}/"
    echo "      ✓ ${dir}/"
  fi
done

for file in gemini-extension.json BRIDGE_SPEC.md; do
  if [ -f "${SOURCE_DIR}/${file}" ]; then
    cp "${SOURCE_DIR}/${file}" "${EXTENSION_DIR}/${file}"
    echo "      ✓ ${file}"
  fi
done

# ── Step 2: Install shared references ──────────────────────────────

echo "[2/3] Installing references → ${REFERENCES_DIR}"

if [ -d "${SOURCE_DIR}/references" ]; then
  mkdir -p "${REFERENCES_DIR}"
  cp -r "${SOURCE_DIR}/references/." "${REFERENCES_DIR}/"
  echo "      ✓ checklists/ (7 files)"
  echo "      ✓ gates/ (2 files)"
  echo "      ✓ pipelines/ (12 files)"
  echo "      ✓ complexity-matrix, glossary, sentinel, team-registry"
else
  echo "[WARN] references/ not found — agents may not work correctly."
fi

# ── Step 3: Verify ─────────────────────────────────────────────────

echo "[3/3] Verifying..."

AGENT_COUNT=$(find "${EXTENSION_DIR}/agents" -name "*.md" 2>/dev/null | wc -l | tr -d ' ')
SKILL_COUNT=$(find "${EXTENSION_DIR}/skills" -name "*.md" 2>/dev/null | wc -l | tr -d ' ')
REF_COUNT=$(find "${REFERENCES_DIR}" -name "*.md" 2>/dev/null | wc -l | tr -d ' ')
MANIFEST="${EXTENSION_DIR}/gemini-extension.json"

PASS=true

if [ ! -f "${MANIFEST}" ]; then
  echo "      ✗ gemini-extension.json MISSING"
  PASS=false
else
  echo "      ✓ gemini-extension.json"
fi

echo "      Agents:     ${AGENT_COUNT}/15"
echo "      Skills:     ${SKILL_COUNT}/31"
echo "      References: ${REF_COUNT}/24"

[ "${AGENT_COUNT}" -lt 15 ] && echo "      ⚠ Expected 15 agents" && PASS=false
[ "${REF_COUNT}" -lt 20 ] && echo "      ⚠ Expected ~24 reference files" && PASS=false

echo ""
if [ "${PASS}" = true ]; then
  echo "══════════════════════════════════════════════════════════════"
  echo "  Installation complete!"
  echo ""
  echo "  Usage in Gemini CLI:"
  echo "    /pipeline <task description>"
  echo "    /pipeline --hotfix <urgent fix>"
  echo "    /pipeline --grill <deep design review>"
  echo "    /pipeline --review-only <audit task>"
  echo "══════════════════════════════════════════════════════════════"
else
  echo "  Installation completed with warnings. Check output above."
fi
echo ""
