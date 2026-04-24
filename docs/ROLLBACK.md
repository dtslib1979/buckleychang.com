# 🔄 buckleychang.com 롤백 가이드

**언제든 박씨가 리팩토링 이전 상태로 1분 안에 되돌릴 수 있도록.**

---

## 롤백 지점

| 태그 / 해시 | 시점 | 상태 |
|---|---|---|
| `safe-rollback-point` | 2026-04-25 | 글로벌 리팩토링 직전 스냅샷 |
| `3828d72` | 2026-03-18 | 박씨 직접 마지막 커밋 (헌법 광역 적용) |
| `5c0f92f` | 2026-03-12 | Goldman 풀 업그레이드 Phase 2.1 |

## 시나리오

### 🔴 전부 싫음 — 박씨 2026-03-18 상태로 완전 복귀
```bash
./scripts/rollback.sh full
```
내부: `git reset --hard 3828d72 && git push origin main --force-with-lease`

### 🟡 10/10 작업만 싫음 — Zone/Partners/Services 제거
```bash
./scripts/rollback.sh soft
```
내부: `git reset --hard safe-rollback-point && git push origin main --force-with-lease`

### 🟢 특정 커밋만 되돌리기 (revert)
```bash
git log --oneline -20
git revert <commit-hash>
git push origin main
```
헌법 제2조 권장 방식.

---

## 경고

- `--force-with-lease` 는 안전 버전. 다른 사람이 push 했으면 거부됨.
- Buckley 와 박씨 2인 운영이므로 full/soft 사용 전 상대방에게 알림 권장.

---

*헌법 제2조: 재공품을 방치하지 않는다. 원할 때 되돌린다.*
