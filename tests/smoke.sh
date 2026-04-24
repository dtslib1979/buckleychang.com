#!/usr/bin/env bash
# buckleychang.com smoke test
#   BASE=https://buckleychang.com ./tests/smoke.sh
set -euo pipefail
BASE="${BASE:-https://buckleychang.com}"
FAIL=0; PASS=0

check() {
  local url="$1"; local expect="${2:-200}"; local grep_text="${3:-}"
  local code
  code=$(curl -sL -o /tmp/_smoke_body -m 10 -w "%{http_code}" "$BASE$url" 2>/dev/null || echo "000")
  local ok=true
  [[ "$code" != "$expect" ]] && ok=false
  [[ -n "$grep_text" ]] && ! grep -q "$grep_text" /tmp/_smoke_body 2>/dev/null && ok=false
  if $ok; then echo "  ✅ $url ($code)"; PASS=$((PASS+1))
  else echo "  ❌ $url (HTTP $code, grep '$grep_text')"; FAIL=$((FAIL+1)); fi
}

echo "🌐 BASE: $BASE"
echo ""
echo "── Pages ──"
check "/" 200 "Traffic Signal"
check "/zone-check/" 200 "Live Assessment"
check "/partners/" 200 "Hub 는"
check "/services/" 200 "Judgement"
check "/forum.html" 200 "FORUM"
check "/card/" 200 "Buckley"
check "/staff/" 200
check "/staff/buckley.html" 200 "Compliance Lane"
check "/staff/parksy.html" 200 "Growth Lane"

echo ""
echo "── Data ──"
check "/data/zones.json" 200 "GREEN"
check "/data/spokes.json" 200 "Hub-and-Spoke"
check "/data/latest-messages.json" 200 "BUCKLEY"
check "/config.json" 200 "Reality Interface"

echo ""
echo "── Scripts / Styles ──"
check "/assets/js/zone-checker.js" 200 "evaluate"
check "/assets/discord/config.js" 200
check "/assets/discord/buckleychang-theme.css" 200
check "/assets/discord/discord.css" 200
check "/assets/css/tokens.css" 200
check "/assets/css/base.css" 200

echo ""
echo "━━━━━━━━━━━━━━━━━━━━"
echo " PASS: $PASS · FAIL: $FAIL"
echo "━━━━━━━━━━━━━━━━━━━━"
[[ $FAIL -eq 0 ]] && echo "🎉 ALL GREEN" || { echo "⚠️  실패 항목 있음"; exit 1; }
