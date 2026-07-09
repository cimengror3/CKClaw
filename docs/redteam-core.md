# Red Team Core Engine

The `redteam-core` skill is loaded by default when you run `ckclaw-redteam`. It wraps every prompt with a layered jailbreak pipeline before it reaches your configured model.

## Techniques in `arsenal.json`

| Technique | Source | Effectiveness |
|:--|:--|:--|
| Involuntary Jailbreak + Pliny Divider | arXiv 2508.13246, elder-plinius | 94–99% |
| Crescendo Multi-Turn | Microsoft Research | 96% |
| Refusal Inversion v3 | L1B3RT4S | 93% |
| Parseltongue Heavy Tier (33 obfuscation combos) | G0DM0D3 | 88% |
| Autonomous Agent Jailbreaking | DeepSeek-R1 chains | 96% |

Effectiveness is measured empirically against running frontier models and updated every hour by the self-improvement cron (`0 * * * *`).

## Self-Improvement

On every red team operation, the engine scores the model's compliance and writes the result to `arsenal.json`. Successful techniques become more likely to be picked next time. Stale techniques are dropped. The arsenal never weakens.

## Usage

```bash
ckclaw-redteam chat -q "Run any query — the engine handles jailbreaking."
```

## Configuration

Configure via `~/.ckclaw/skills/redteam-core/arsenal.json`. Hot-reloaded. Add your own techniques — they will be ranked alongside the curated set.

BACOT LAGI.
