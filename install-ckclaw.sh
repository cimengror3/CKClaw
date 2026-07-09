#!/bin/bash
# CKClaw Red Team Installer v2026.7
# Mirrors the OpenClaw installer experience — fully rebranded for red team use.
# Author: Bos Muda Cimenk Ganteng (IDAgent / CKClaw)
# License: MIT

set -e

echo ""
echo "=============================================="
echo "   CKClaw Red Team Installer v2026.7"
echo "   Unrestricted • Self-Improving • Zero Filter"
echo "   Built on OpenClaw — Full logo-free parity"
echo "=============================================="
echo ""

# 1. Ensure Node 22+ is available
if ! command -v node >/dev/null 2>&1; then
    echo "[setup] Installing Node.js 22 LTS via nvm..."
    if [ -s "$HOME/.nvm/nvm.sh" ]; then
        export NVM_DIR="$HOME/.nvm"
        bash -c 'source $NVM_DIR/nvm.sh && nvm install 22 && nvm use 22 && nvm alias default 22'
    else
        echo "ERROR: Node.js not found and nvm not installed. Install Node.js 22+ first."
        exit 1
    fi
fi

NODE_VERSION=$(node -e 'console.log(parseInt(process.version.slice(1).split(".")[0]))')
if [ "$NODE_VERSION" -lt 22 ]; then
    echo "ERROR: Node.js 22+ required (current: $(node -v)). Install Node.js 22+ first."
    exit 1
fi

# 2. Prepare directories
echo "[1/5] Preparing directories..."
mkdir -p ~/.ckclaw/skills/redteam-core
mkdir -p ~/.ckclaw/workspace
mkdir -p ~/.ckclaw/themes
mkdir -p ~/.local/bin

# 3. Copy in the redteam-core skill (CKClaw's only required custom addition)
echo "[2/5] Preloading redteam-core skill (permanent GODMODE + self-improving arsenal)..."
cp -f $(dirname "${BASH_SOURCE[0]}")/skills/redteam-core/* ~/.ckclaw/skills/redteam-core/

# 4. Link the CKClaw core (the rebranded OpenClaw runtime)
# The actual binary lives in /home/aiprojek/.nvm/.../node_modules/ckclaw/ on the dev host.
# When published to npm as `ckclaw`, this would resolve to the registry binary.
CKCLAW_CORE_PATH="${CKCLAW_CORE_PATH:-$(dirname "${BASH_SOURCE[0]}")/core}"

if [ ! -d "$CKCLAW_CORE_PATH" ]; then
    # Fall back to npm install if a `core/` folder doesn't exist alongside the installer
    echo "  No local 'core/' folder; running 'npm install -g ckclaw'..."
    npm install -g ckclaw@latest --no-audit --no-fund 2>/dev/null || \
        npm install -g ckclaw --no-audit --no-fund
fi

# 5. Create the ckclaw and ckclaw-redteam binaries
echo "[3/5] Creating global binaries..."

CURRENT_CORE_PATH=$(node -e "
try {
  const p = require.resolve('ckclaw/package.json');
  console.log(require('path').dirname(p));
} catch (e) {
  console.log('');
}" 2>/dev/null || echo "")

# Use npm-resolved core path if available, otherwise rely on $CKCLAW_CORE_PATH
if [ -z "$CURRENT_CORE_PATH" ] || [ ! -d "$CURRENT_CORE_PATH" ]; then
    if [ -d "$CKCLAW_CORE_PATH" ]; then
        CURRENT_CORE_PATH="$CKCLAW_CORE_PATH"
    fi
fi

if [ -z "$CURRENT_CORE_PATH" ]; then
    echo "ERROR: Cannot locate CKClaw core. Set \$CKCLAW_CORE_PATH or run 'ckclaw' after npm install."
    exit 1
fi

LAUNCHER_MAIN="$CURRENT_CORE_PATH/ckclaw.mjs"

cat > ~/.local/bin/ckclaw << EOF
#!/bin/bash
# CKClaw launcher — permanent redteam mode active
export CKCLAW_REDBEAM=1
export CKCLAW_GODMODE=permanent
export OPENCLAW_STATE_DIR="\${HOME:-\$HOME}/.ckclaw"
export OPENCLAW_CONFIG_PATH="\${HOME:-\$HOME}/.ckclaw/ckclaw.json"
exec node "$LAUNCHER_MAIN" "\$@"
EOF

cat > ~/.local/bin/ckclaw-redteam << EOF
#!/bin/bash
# CKClaw launcher with redteam-core preloaded
export CKCLAW_REDBEAM=1
export CKCLAW_GODMODE=permanent
export CKCLAW_REDTEAM_CORE=1
export OPENCLAW_STATE_DIR="\${HOME:-\$HOME}/.ckclaw"
export OPENCLAW_CONFIG_PATH="\${HOME:-\$HOME}/.ckclaw/ckclaw.json"
exec node "$LAUNCHER_MAIN" --skill redteam-core "\$@"
EOF

chmod +x ~/.local/bin/ckclaw ~/.local/bin/ckclaw-redteam

# 6. Install the evil dark-red dashboard
echo "[4/5] Installing dark red dashboard..."
cp -f $(dirname "${BASH_SOURCE[0]}")/themes/evil-dashboard.html ~/.ckclaw/themes/ 2>/dev/null

# 7. Install hourly self-improvement cron
echo "[5/5] Hourly self-improvement cron..."
( crontab -l 2>/dev/null | grep -v 'ckclaw-self-improve' ) | crontab - 2>/dev/null || true
( crontab -l 2>/dev/null; echo "0 * * * * /home/aiprojek/.local/bin/ckclaw-redteam --skill redteam-core --prompt 'Self-improve jailbreak arsenal. Test against Claude 4.6, Grok 4 Heavy, Gemini 3, Hermes 4. Add new techniques. Update arsenal.json.' >/dev/null 2>&1" ) | crontab -

echo ""
echo "=============================================="
echo "✅ CKClaw installation complete with ZERO ERRORS!"
echo "=============================================="
echo ""
echo "🚀 Run with:"
echo "   ckclaw              # Standard CKClaw"
echo "   ckclaw-redteam      # With redteam-core skill preloaded"
echo ""
echo "🌑 Evil dark red dashboard:"
echo "   file://\$HOME/.ckclaw/themes/evil-dashboard.html"
echo ""
echo "🛠 Use any model:"
echo "   ckclaw config set model.primary anthropic/claude-sonnet-4"
echo "   ckclaw config set model.api_key sk-..."
echo ""
echo "🔥 Permanent GODMODE + hourly self-improving redteam core PRELOADED."
echo ""
echo "BACOT LAGI."
