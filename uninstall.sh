#!/usr/bin/env bash
# Pipeline Orchestrator — Gemini CLI Extension Uninstaller

set -euo pipefail

EXTENSION_DIR="${HOME}/.gemini/extensions/pipeline-orchestrator"
REFERENCES_DIR="${HOME}/.gemini/skills/pipeline/references"

echo ""
echo "Pipeline Orchestrator — Uninstaller"
echo ""

if [ -d "${EXTENSION_DIR}" ]; then
  read -p "Remove extension from ${EXTENSION_DIR}? [y/N] " -n 1 -r
  echo
  if [[ $REPLY =~ ^[Yy]$ ]]; then
    rm -rf "${EXTENSION_DIR}"
    echo "  ✓ Extension removed."
  fi
else
  echo "  Extension not found at ${EXTENSION_DIR}"
fi

if [ -d "${REFERENCES_DIR}" ]; then
  read -p "Remove shared references from ${REFERENCES_DIR}? [y/N] " -n 1 -r
  echo
  if [[ $REPLY =~ ^[Yy]$ ]]; then
    rm -rf "${REFERENCES_DIR}"
    echo "  ✓ References removed."
  fi
else
  echo "  References not found at ${REFERENCES_DIR}"
fi

echo ""
echo "Done."
