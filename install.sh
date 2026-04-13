#!/usr/bin/env bash
# ============================================================================
# Pipeline Orchestrator — Gemini CLI Extension Installer
# ============================================================================
#
# PREFERRED METHOD:
#   gemini extensions install https://github.com/fernandoxavier02/pepiline-orchestrator-gemini
#
# ALTERNATIVE (this script):
#   git clone https://github.com/fernandoxavier02/pepiline-orchestrator-gemini.git
#   cd pepiline-orchestrator-gemini
#   chmod +x install.sh
#   ./install.sh
#
# What it does:
#   Copies ALL extension files (agents, skills, commands, references, manifest,
#   GEMINI.md) to ~/.gemini/extensions/pipeline-orchestrator/
#
# ============================================================================

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
GEMINI_DIR="${HOME}/.gemini"
EXTENSION_DIR="${GEMINI_DIR}/extensions/pipeline-orchestrator"

echo ""
echo "╔══════════════════════════════════════════════════════════════╗"
echo "║  Pipeline Orchestrator — Gemini CLI Extension Installer     ║"
echo "║  Version 2.0.0                                              ║"
echo "╚══════════════════════════════════════════════════════════════╝"
echo ""

# ── Pre-checks ──────────────────────────────────────────────────────

if [ ! -f "${SCRIPT_DIR}/gemini-extension.json" ]; then
  echo "[ERROR] gemini-extension.json not found."
  echo "        Run this script from the repo root."
  exit 1
fi

if [ ! -d "${GEMINI_DIR}" ]; then
  echo "[ERROR] Gemini CLI directory not found at ${GEMINI_DIR}"
  echo "        Install Gemini CLI first: https://github.com/google-gemini/gemini-cli"
  exit 1
fi

# ── Install extension ───────────────────────────────────────────────

echo "[1/2] Installing extension → ${EXTENSION_DIR}"
mkdir -p "${EXTENSION_DIR}"

for dir in agents skills commands references; do
  if [ -d "${SCRIPT_DIR}/${dir}" ]; then
    mkdir -p "${EXTENSION_DIR}/${dir}"
    cp -r "${SCRIPT_DIR}/${dir}/." "${EXTENSION_DIR}/${dir}/"
    echo "      + ${dir}/"
  fi
done

for file in gemini-extension.json GEMINI.md BRIDGE_SPEC.md; do
  if [ -f "${SCRIPT_DIR}/${file}" ]; then
    cp "${SCRIPT_DIR}/${file}" "${EXTENSION_DIR}/${file}"
    echo "      + ${file}"
  fi
done

# ── Verify ──────────────────────────────────────────────────────────

echo "[2/2] Verifying..."

AGENT_COUNT=$(find "${EXTENSION_DIR}/agents" -name "*.md" 2>/dev/null | wc -l | tr -d ' ')
SKILL_COUNT=$(find "${EXTENSION_DIR}/skills" -name "*.md" 2>/dev/null | wc -l | tr -d ' ')
REF_COUNT=$(find "${EXTENSION_DIR}/references" -name "*.md" 2>/dev/null | wc -l | tr -d ' ')

echo "      Agents:     ${AGENT_COUNT}/15"
echo "      Skills:     ${SKILL_COUNT}/31"
echo "      References: ${REF_COUNT}/24"
echo "      GEMINI.md:  $([ -f "${EXTENSION_DIR}/GEMINI.md" ] && echo 'OK' || echo 'MISSING')"
echo "      Manifest:   $([ -f "${EXTENSION_DIR}/gemini-extension.json" ] && echo 'OK' || echo 'MISSING')"

echo ""
echo "══════════════════════════════════════════════════════════════"
echo "  Installation complete!"
echo ""
echo "  Usage in Gemini CLI:"
echo "    /pipeline <task description>"
echo "    /pipeline --hotfix <urgent fix>"
echo "    /pipeline --grill <deep design review>"
echo "    /pipeline --review-only <audit task>"
echo "══════════════════════════════════════════════════════════════"
echo ""
