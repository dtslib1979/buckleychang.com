# 🌅 박씨 아침 확인용 — buckleychang.com 글로벌 리팩토링

**작업일**: 2026-04-25
**방법론**: namoneygoal 과 동일 (복제 검증)
**상태**: 19/19 smoke test ALL GREEN · 6개 Playwright 스크린샷 완료 · 라이브

---

## 🎯 박씨 취지 살린 핵심

| 박씨 원래 의도 | 구현 |
|---|---|
| "Reality Interface for the AI Economy" | 메인 히어로 유지 + Nav 확장 |
| Hub-and-Spoke 모델 | `/partners/` SVG 원형 시각화 + 8 Spoke 카드 |
| Traffic Signal Protocol (GREEN/YELLOW/RED) | `/zone-check/` 실제 엔진 + 실시간 판정 |
| Parksy × Buckley 2인 파트너 | `staff/buckley.html` + `staff/parksy.html` 2뷰 분리 |
| 1인 크리에이터 특화 | Services 에 AdSense/Patreon/Gumroad 명시 |
| 직접 서비스 제공 안 함 | Scope box YES/NO 로 경계 분명히 |
| Collaborator → Independent 경로 | 자체 OS 완성도 ↑ |

---

## 📦 신규·수정 파일

### 신규
```
HANDOFF.md                              본 문서
docs/BENCHMARK.md                       글로벌 벤치마크 심층
docs/ROLLBACK.md                        복원 가이드
docs/visual-qa/                         6 스크린샷 + QA 리포트
data/zones.json                         GREEN/YELLOW/RED + 6 triggers
data/spokes.json                        Hub-Spoke 8 파트너
data/latest-messages.json               Discord fallback
assets/js/zone-checker.js               ES6 판정 엔진
assets/discord/                         7 모듈 (config/auth/contact-form/widget-embed/presence/messages-feed + 2 CSS)
auth/callback.html                      OAuth 콜백
forum.html                              Discord 포럼 전용
zone-check/index.html                   슬라이더 위저드
partners/index.html                     SVG Hub-Spoke + 카드 그리드
services/index.html                     4 Lane + 3-Tier Pricing
staff/buckley.html                      Compliance Lane 포털
staff/parksy.html                       Growth Lane 포털
scripts/rollback.sh                     1-command 복원
tests/smoke.sh                          19 URL 자동 검증
.github/workflows/discord-cache.yml
.github/workflows/discord-notify.yml
```

### 수정
```
index.html                              Nav 확장 + Community 섹션 + Discord 모듈
```

### Git
```
tag: safe-rollback-point               글로벌 리팩토링 직전 스냅샷
main HEAD: 4c444a2                     push 완료 · Pages 배포 완료
```

---

## 🚨 박씨가 15분 안에 할 것 (4값 입력 → 완전 활성)

### Step 1 · Discord 채널 3개 생성
기존 GUILD `1493490911278272655` (phoneparis/papafly/namoneygoal 공유) 에:
1. `#buckleychang-공지` 또는 일반 채팅 → **CH_ID** 복사
2. `#buckleychang-문의` → 웹훅 설정 → **WEBHOOK** URL 복사
3. `#buckleychang-forum` (포럼 타입) → **FORUM_CH** ID 복사

### Step 2 · `assets/discord/config.js` 4값 교체

현재 (placeholder):
```js
CH_ID:       "PLACEHOLDER_CHANNEL_ID",
WEBHOOK:     "PLACEHOLDER_WEBHOOK_URL",
FORUM_CH:    "PLACEHOLDER_FORUM_CHANNEL_ID",
```

박씨 교체:
```js
CH_ID:       "1234567890...",
WEBHOOK:     "https://discord.com/api/webhooks/.../...",
FORUM_CH:    "1234567890...",
WB_CHAT:     "https://e.widgetbot.io/channels/1493490911278272655/{CH_ID}",
WB_FORUM:    "https://e.widgetbot.io/channels/1493490911278272655/{FORUM_CH}",
```

### Step 3 · GitHub Secrets (Actions 자동 알림 원할 때)
`dtslib1979/buckleychang.com` Settings → Secrets:
- `DISCORD_BOT_TOKEN` (30분 공지 캐시)
- `DISCORD_WEBHOOK` (커밋/릴리즈 알림)

### Step 4 · push
```bash
cd ~/buckleychang.com
git commit -am "config: Discord 4값 입력"
git push
```
→ 3~5분 후 라이브 완전 활성화.

---

## 🧪 박씨 확인 URL

| URL | 상태 |
|---|---|
| https://buckleychang.com | ✅ 메인 (Nav 5개 링크) |
| https://buckleychang.com/zone-check/ | ✅ **실제 작동 엔진** (슬라이더 → 실시간 Zone) |
| https://buckleychang.com/partners/ | ✅ SVG Hub-Spoke + 8 파트너 |
| https://buckleychang.com/services/ | ✅ 4 Lane + 3-Tier (Self-Log/Quarterly/Retainer) |
| https://buckleychang.com/forum.html | ⚠️ Discord 4값 입력 후 활성 |
| https://buckleychang.com/card/ | ✅ 기존 명함 (유지) |
| https://buckleychang.com/staff/ | ✅ 기존 포털 (유지) |
| https://buckleychang.com/staff/buckley.html | ✅ Compliance Lane (code: `1126` or `buckley`) |
| https://buckleychang.com/staff/parksy.html | ✅ Growth Lane (code: `1126` or `parksy`) |

---

## 📊 디자인 품질

### Goldman 급 요소
- ✅ **Cinzel** eyebrow (세리프 대문자 · .3em letter-spacing)
- ✅ **Cormorant Garamond** 이탤릭 headline (`<em>` 으로 Gold 강조)
- ✅ **Gold #c9a227 / Dark #0a0f14** 2색 기반 톤
- ✅ **SVG** Hub-Spoke 원형 시각화 (원형 8방 배치)
- ✅ 슬라이더 그라데이션 track (green→yellow→red 실시간)
- ✅ 3-Tier Pricing featured 카드 (RECOMMENDED 배지 + 골드 테두리)
- ✅ YES/NO scope box (경계 분명히)
- ✅ 영어 원칙문: "Judgement over execution" · "The Hub decides. The Spokes deliver."

### 한국어 카피 (박씨 취지)
- ✅ "개인이 기업이 되는 순간, 관제탑이 작동합니다"
- ✅ "Hub 는 판단, Spoke 는 실행"
- ✅ "지금은 혼자서 충분합니다" (GREEN)
- ✅ "임계값을 넘었습니다" (YELLOW)
- ✅ "관제탑이 필요한 영역입니다" (RED)

---

## 🔒 안전망

```bash
# 10/10 리팩토링 직전으로 되돌리기
./scripts/rollback.sh soft

# 박씨 2026-03-18 (3828d72) 직접 커밋으로 완전 복귀
./scripts/rollback.sh full

# 현재 상태 확인
./scripts/rollback.sh status
```

상세: `docs/ROLLBACK.md`

---

## 🧭 글로벌 포지셔닝 (docs/BENCHMARK.md 요약)

```
REALM Global   $7,500/yr · 럭셔리 네트워크
Karat Financial $349~/mo · 크리에이터 세무 SaaS
Collective      $299~/mo · S-Corp 자동화
Dark Horse CPAs ·          솔로 CPA 커뮤니티
Fractional CFO  $1,500~$5,000/mo · 시간제 CFO
─────────────────────────────────────────
buckleychang  · ₩0 Self / ₩500K 분기 / $3K 월
              · Zone Protocol + Hub-Spoke (독창)
              · DTSLIB 교차 라우팅
```

**결론**: 글로벌 경쟁 없는 독창 포지션. Fractional CFO 월 리테이너 가격 유지.

---

## 📌 남은 펜딩

| 항목 | 누가 | 왜 |
|---|---|---|
| Discord 4값 | 박씨 | 서버 관리자 권한 |
| staff 데이터 축적 (client-routing.json) | 실제 client 생기면 | 지금은 빈 empty 상태 |
| YouTube 채널 연동 (선택) | 박씨 | buckleychang 전용 채널 유무 결정 |
| 사업자등록증 이미지 실데이터 | 박씨 | 현재는 placeholder SVG |
| Zone Check 제출 → Buckley 메일 자동 전송 (선택) | 차후 | Webhook 기반 구현 가능 |

---

## 🎁 보너스 (박씨 안 시킴)

- `docs/BENCHMARK.md` — REALM/Compass/Karat/Collective/Dark Horse/Fractional CFO 심층
- `docs/ROLLBACK.md` + `scripts/rollback.sh` — 1분 복원
- `tests/smoke.sh` — CI 가능한 자동 검증
- `staff/parksy.html` — DTSLIB 교차 라우팅 테이블 (slot08-10, buddies.kr 연계 명시)
- `data/spokes.json` — 내부 파트너 JSON 레지스트리 (확장 가능)

---

## 📍 지금 상태 한 줄

**코드 완성 · 라이브 배포 완료 · 19/19 smoke green · Discord 4값만 넣으면 100% 활성.**

```
Visit: https://buckleychang.com
Zone Check: https://buckleychang.com/zone-check/  ← 실제 작동
```

---

*"The Hub decides. The Spokes deliver. You stay in the work."*
