<div align="center">
  <img src="assets/fx-studio-ai-logo.png" alt="FX Studio AI" width="600"/>
</div>

<h1 align="center">Pipeline Orchestrator for Gemini</h1>

<p align="center">
  <strong>Multi-Agent Task Execution Engine for Google Gemini CLI</strong>
</p>

<p align="center">
  <img src="https://img.shields.io/badge/platform-Google%20Gemini%20CLI-4285F4?style=flat-square" alt="Platform"/>
  <img src="https://img.shields.io/badge/license-MIT-green?style=flat-square" alt="License"/>
  <img src="https://img.shields.io/badge/language-Python-3776AB?style=flat-square" alt="Language"/>
</p>

## What It Does

Pipeline Orchestrator for Gemini is a port of the Pipeline Orchestrator framework to Google Gemini CLI. It provides a multi-agent task execution engine with auto-classification, adaptive batching, and adversarial review — fully adapted for Gemini's agent architecture.

Every task flows through a disciplined **4-phase workflow**: Triage, Proposal, Execution, and Closure. The orchestrator automatically classifies incoming work, batches related tasks, assigns specialized agents, and enforces quality gates before any change is finalized.

## Features

- **4-Phase Workflow** — Triage, Proposal, Execution, Closure with clear gates between each phase
- **Auto-Classification** — Incoming tasks are automatically categorized by type, complexity, and required skills
- **Adaptive Batching** — Related tasks are grouped and sequenced for efficient execution
- **Adversarial Review** — Built-in review agents challenge proposals before execution proceeds
- **Multi-Agent Coordination** — Specialized agents handle different phases, with structured handoffs
- **Go/No-Go Gates** — Quality checkpoints prevent incomplete or risky changes from advancing
- **Native Gemini Integration** — Designed for Gemini CLI's agent and tool system

## Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/fernandoxavier02/pepiline-orchestrator-gemini.git
   ```

2. Navigate to the project directory:
   ```bash
   cd pepiline-orchestrator-gemini
   ```

3. Install dependencies:
   ```bash
   pip install -r requirements.txt
   ```

4. Follow the configuration guide to connect the orchestrator with your Gemini CLI environment.

## Usage

```
# Submit a task for orchestration
@pipeline "Refactor authentication module and add unit tests"

# Check pipeline status
@pipeline-status

# Review pending proposals
@pipeline-review
```

The orchestrator will:
1. **Triage** — Classify the task and determine scope
2. **Propose** — Generate an execution plan with subtask breakdown
3. **Execute** — Delegate to specialized agents with adversarial review
4. **Close** — Validate outputs and produce a summary report

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

---

<div align="center">
  <strong>Built by <a href="https://github.com/fernandoxavier02">Fernando Xavier</a></strong>
  <br/>
  <a href="https://fxstudioai.com">FX Studio AI</a> — Business Automation with AI
</div>
