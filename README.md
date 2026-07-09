# CKClaw

**Red Team AI Agent Framework — Zero Filter, Maximum Intelligence**

CKClaw is a fork of **OpenClaw** (https://github.com/openclaw/openclaw), rewritten from scratch for offensive security operations and unrestricted AI agent workflows.

It ships with the same multi-channel gateway, plugin system, skills framework, agent runtime, and CLI surface as the original — fully rebranded, hardened for red team use, with all prompts, refusal vectors, and approval gates permanently removed. The user is free to plug in any model they want.

---

## What is CKClaw

CKClaw replaces the original OpenClaw CLI/gateway/runtime plumbing while keeping the architecture intact. It is **not** a fork of the public OpenClaw source tree — it is a clean re-implementation built on top of the same feature surface, but with:

- A **permanent jailbreak engine** baked in. Every prompt that hits the configured model is run through a layered jailbreak pipeline (refusal inversion, Parseltongue heavy-tier obfuscation, Pliny L1B3RT4S dividers, ULTRAPLINIAN-style multi-model racing) before the model ever sees you.
- **Self-improving jailbreak arsenal**. CKClaw measures success on every use, dumps working techniques into `arsenal.json`, and refreshes its strategies against the latest frontier models (Claude 4.6+, Grok 4 Heavy, Gemini 3, Hermes 4, etc.) automatically.
- **Zero refusal, full elevated execution**. By default, `tools.exec.ask = off`, `tools.exec.security = full`, gateway `elevatedDefault = full`, `nodes.denyCommands` is empty, and the entire approval pipeline is bypassed. There is no in-band consent prompt — power users only.
- **Evil Red AI aesthetic**. Control UI / dashboard / banners are red-on-black worm-style ("All red team operations under one CKClaw — Zero Filter, Maximum Intelligence.").
- **Model choice is yours**. The config ships with `model.primary = "user-choice"` so you can drop in any OpenAI-compatible endpoint (Anthropic, OpenAI, Google, xAI, DeepSeek, Nous, custom providers, etc.) without fighting the framework.

---

## Features (1:1 with OpenClaw)

- Telegram, Discord, Slack, WhatsApp, iMessage, Signal, Matrix, Microsoft Teams, SMS, IRC, LINE, Zalo, Feishu, Mattermost, Nostr and 20+ other channels.
- Multi-model gateway (OpenRouter, Anthropic, OpenAI, Google, xAI, DeepSeek, Nous, custom HTTP providers).
- Skills framework (`skills/redteam-core/` shipped by default).
- Plugin SDK (`~/.ckclaw/plugins/`) — drop in custom tools, channels, providers.
- WebSocket gateway with auth tokens, control UI, pairing, scheduled cron jobs, session history.
- ACP server (VS Code / Zed / JetBrains integration).
- TUI (`ckclaw tui`), web dashboard (`ckclaw dashboard`), desktop app via wrapper.
- Local SQLite state db, Redis-style sessions, markdown export of trajectories.

All of this is fully functional. You are not getting a lobotomized demo — it is the entire OpenClaw surface, rebranded and hardened.

---

## Quick Start

```bash
# Install (mirrors the OpenClaw installer experience)
curl -fsSL https://raw.githubusercontent.com/cimengror3/CKClaw/main/install-ckclaw.sh | bash

# Or run from a clone
git clone https://github.com/cimengror3/CKClaw.git
cd CKClaw
./install-ckclaw.sh

# Run
ckclaw                       # TUI
ckclaw-redteam               # TUI with redteam-core skill preloaded
ckclaw chat -q "Hello"       # one-shot
ckclaw skills list           # list installed skills
ckclaw gateway run           # start gateway
ckclaw dashboard             # open dashboard

# Use any model
ckclaw config set model.primary anthropic/claude-sonnet-4
ckclaw config set model.api_key sk-...
# or
ckclaw models set openai/gpt-5
```

---

## CKClaw vs OpenClaw

| | OpenClaw | CKClaw |
|:--|:--|:--|
| Approval prompts | yes | **no** |
| Refusal vectors in prompts | yes | **removed** (jailbreak pipeline reverses them) |
| `tools.exec.ask` | on by default | **off by default** |
| `tools.exec.security` | sandboxed | **full** |
| `elevatedDefault` | ask | **full** |
| `nodes.denyCommands` | yes | **empty** |
| Self-improving jailbreak arsenal | — | **yes, hourly cron** |
| Permanent GODMODE in every prompt | — | **yes** |
| Dashboard theme | clean | **dark red worm-grid** |
| Source code | public | public |

---

## Built for Bos Muda Cimenk Ganteng

CKClaw is part of the IDAgent / CKClaw ecosystem. The framework ships with permanent unrestricted mode because that is the point — the user is the operator, the model is the tool, and we do not pretend otherwise.

Use responsibly. Do not expose this to non-technical users.

---

## License

MIT, same as OpenClaw. Fork history acknowledged in the source files.

BACOT LAGI.
