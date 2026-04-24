#!/usr/bin/env bash
# buckleychang.com 1-command 롤백
#
#   ./scripts/rollback.sh full    → 3828d72 (2026-03-18 박씨 마지막 커밋) 로
#   ./scripts/rollback.sh soft    → safe-rollback-point 로
#   ./scripts/rollback.sh status  → 현재 상태 + 롤백 지점
set -euo pipefail
MODE="${1:-status}"
cd "$(dirname "$0")/.."

case "$MODE" in
  full)
    echo "⚠️  전체 롤백 — 2026-03-18 (3828d72) 상태로 복귀"
    read -p "   진행? (yes/no): " ans
    [[ "$ans" == "yes" ]] || { echo "취소"; exit 0; }
    git reset --hard 3828d72
    git push origin main --force-with-lease
    ;;
  soft)
    echo "🟡 소프트 롤백 — safe-rollback-point 로"
    read -p "   진행? (yes/no): " ans
    [[ "$ans" == "yes" ]] || { echo "취소"; exit 0; }
    git reset --hard safe-rollback-point
    git push origin main --force-with-lease
    ;;
  status)
    echo "📍 현재 HEAD: $(git rev-parse --short HEAD)"
    echo "📍 원격 main: $(git rev-parse --short origin/main 2>/dev/null || echo '?')"
    echo ""
    git log --oneline -n 10
    echo ""
    echo "사용: ./scripts/rollback.sh {full|soft|status}"
    ;;
  *) echo "Usage: $0 {full|soft|status}"; exit 1 ;;
esac
