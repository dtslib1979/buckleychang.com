# 📸 buckleychang.com 시각 QA 리포트

**테스트 일시**: 2026-04-25
**대상 URL**: https://buckleychang.com
**뷰포트**: 1280 × 900 (desktop 기준)
**도구**: Playwright MCP

---

## 스크린샷 8개 (Discord 자동 활성 후 +2)

| # | 파일 | 페이지 | 확인 요소 | 결과 |
|:--:|---|---|---|:--:|
| 01 | `01-main-landing.png` | `/` | 새 nav(5개 링크) · 히어로 · 매니페스토 · 5 Moments · Traffic Signal Protocol · Zone CTA · Partnership × · Community · Contact | ✅ |
| 02 | `02-zone-check-yellow.png` | `/zone-check/` | 슬라이더 조작(₩500만+해외3건) → YELLOW 판정 + 4개 Spoke 자동 추천 | ✅ |
| 03 | `03-partners-hub-spoke.png` | `/partners/` | SVG 원형 Hub + 8 Spoke 방사 배치 · 카테고리 필터 · 카드 그리드 · Hub-Spoke 철학 | ✅ |
| 04 | `04-services-3tier.png` | `/services/` | 4 Judgement Lanes · 3-Tier Pricing (Self-Log / Quarterly / Retainer) · Scope box (YES/NO) | ✅ |
| 05 | `05-forum-placeholder.png` | `/forum.html` | Cinzel 헤더 "FORUM · BUCKLEY CHANG" · Discord 설정 대기 안내 | ✅ |
| 06 | `06-staff-buckley-gate.png` | `/staff/buckley.html` | Buckley Access · Compliance Lane · Cormorant italic 제목 · Gold CTA · Growth Lane 링크 | ✅ |
| 07 | `07-forum-LIVE.png` | `/forum.html` | **WidgetBot iframe 실제 로드** (Bot 자동 채널 생성 후) | ✅ |
| 08 | `08-community-LIVE.png` | `/#community` | **Discord 채팅 + 작동 문의 폼** · 서버 1명 온라인 카운트 | ✅ |

---

## Smoke Test

```
BASE=https://buckleychang.com ./tests/smoke.sh
PASS: 19 · FAIL: 0 · 🎉 ALL GREEN
```

검증된 것:
- Pages: `/`, `/zone-check/`, `/partners/`, `/services/`, `/forum.html`, `/card/`, `/staff/`, `/staff/buckley.html`, `/staff/parksy.html`
- Data: `zones.json`, `spokes.json`, `latest-messages.json`, `config.json`
- Scripts/CSS: `zone-checker.js`, Discord 번들, tokens/base CSS

---

## Zone Engine 실제 작동 증거

**스크린샷 02 기준:**
- 입력: 월 수익 ₩500만 + 해외 결제 3건
- 출력:
  - Zone: **YELLOW**
  - Verdict: "임계값을 넘었습니다."
  - Hit list: 월수익 YELLOW + 해외결제 YELLOW
  - Spokes: 세무 자문 / 법무·저작권 / 부동산 감정·회계 / 사무실·인프라 4개 추천 자동 렌더

→ `data/zones.json` · `data/spokes.json` · `assets/js/zone-checker.js` 3자 연동 정상.

---

## 디자인 평가

### Goldman급 요소 (글로벌 최고 수준)
- ✅ Cormorant Garamond 이탤릭 headline (REALM Global · Goldman 동급)
- ✅ Cinzel eyebrow (세리프 대문자 letter-spacing .3em)
- ✅ Gold #c9a227 + Dark #0a0f14 색조 (8소 개의 팔레트 일관)
- ✅ SVG Hub-Spoke 원형 시각화 (Bloomberg / Stripe 톤)
- ✅ 슬라이더 그라데이션 (green→yellow→red)
- ✅ 3-Tier Pricing card (featured 골드 테두리 + RECOMMENDED 배지)

### 지적 표현 요소
- ✅ "Judgement over execution" · "The Hub decides. The Spokes deliver." 영어 원칙문
- ✅ Traffic Signal Protocol 의 3-state 구조 명시
- ✅ YES/NO scope box (경계 분명히)
- ✅ 이탤릭 강조 (em 태그로 Gold 하이라이트)

---

## 박씨 Discord 4값 입력 후 예상

```
CH_ID / WEBHOOK / FORUM_CH / (선택) YouTube channelId
```
→ `/forum.html` placeholder 사라지고 실제 Discord 포럼 iframe
→ 메인 Community 섹션 WidgetBot 채팅 활성화
→ 문의 폼 Webhook 전송 활성화

---

*Playwright MCP · 2026-04-25 KST*
