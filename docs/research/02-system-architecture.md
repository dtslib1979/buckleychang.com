# 시스템 아키텍처 설계: buckleychang.com 서비스 포털

> 조사일: 2026-03-12
> 목적: 명함 사이트 → 서비스 포털 전환을 위한 아키텍처 설계

---

## 1. 현재 상태 평가

| 항목 | 현재 |
|------|------|
| 호스팅 | GitHub Pages (정적 사이트) |
| 페이지 | index.html (명함), card/ (연락처), staff/ (내부 포털) |
| CSS | 인라인 794줄 (페이지마다 중복) |
| JS | 인라인 (명함 기능만) |
| 데이터 | config.json (설정만) |
| 디자인 | 다크 + 골드, 고급스러움. Cinzel/Cormorant Garamond/Inter/Noto Sans KR |

**문제:** 브랜드는 있으나 기능이 없음. 서비스 3개가 텍스트로만 나열됨.

---

## 2. 제안 파일 구조

```
buckleychang.com/
├── index.html                          # 랜딩 (히어로 + 가치 제안 + CTA)
├── CLAUDE.md
├── CNAME
├── config.json                         # 사이트 전역 설정
├── robots.txt
├── sitemap.xml
├── .nojekyll
│
├── assets/
│   ├── css/
│   │   ├── tokens.css                  # 디자인 토큰 (CSS 변수만)
│   │   ├── base.css                    # 리셋, 타이포, 바디, 유틸리티
│   │   ├── components.css              # 카드, 버튼, 배지, 모달
│   │   └── layouts.css                 # 컨테이너, 그리드, 네비, 푸터
│   ├── js/
│   │   ├── i18n.js                     # 언어 전환 로직
│   │   ├── zone-checker.js             # Traffic Signal 진단 엔진
│   │   └── components.js               # 공유 인터랙티브 컴포넌트
│   ├── icons/
│   ├── img/
│   └── manifest.json
│
├── data/                               # JSON 기반 콘텐츠 ("BOM")
│   ├── services.json                   # 서비스 정의
│   ├── zones.json                      # GREEN/YELLOW/RED 정의
│   ├── triggers.json                   # Yellow Zone 트리거 임계값
│   ├── partners.json                   # 파트너 네트워크 데이터
│   ├── faq.json                        # FAQ (ko + en)
│   ├── i18n/
│   │   ├── ko.json                     # 한국어 UI 문자열
│   │   └── en.json                     # 영어 UI 문자열
│   └── protocols/
│       └── traffic-signal.json         # 프로토콜 전체 정의
│
├── services/                           # 서비스 상세 페이지
│   ├── index.html                      # 서비스 개요
│   ├── entity/index.html               # 법인 전환
│   ├── tax/index.html                  # 세무
│   ├── international/index.html        # 크로스보더/국제
│   └── ip/index.html                   # IP 분리 & 라이선싱
│
├── zone-check/                         # 인터랙티브 진단 도구
│   └── index.html                      # 자가진단 위저드
│
├── partners/
│   └── index.html                      # 파트너 네트워크 표시
│
├── card/
│   └── index.html                      # 디지털 명함 (기존)
│
├── docs/                               # 공개용 가이드
│   ├── index.html                      # 문서 허브
│   ├── research/                       # 리서치 문서 (이 파일들)
│   ├── creator-tax-guide/index.html    # AI 크리에이터 세무 가이드
│   └── entity-checklist/index.html     # 법인 전환 체크리스트
│
├── staff/                              # 내부 포털 (기존, PIN 뒤)
│   └── index.html
│
└── 00_TRUTH/                           # 기존 진실 레이어
    ├── _inherit.json
    └── index.md
```

### 핵심 결정

| 결정 | 선택 | 근거 |
|------|------|------|
| **라우팅** | 멀티페이지 HTML (`dir/index.html`) | JS 불필요, GitHub Pages 네이티브 지원, SEO 최적 |
| **스타일** | 공유 CSS 파일 (`<link>`) | 700+ 줄 인라인 중복 제거 |
| **콘텐츠** | JSON 데이터 + `fetch()` | HTML 수정 없이 편집 가능, 이중 언어 대응 |
| **진단 도구** | 클라이언트 사이드 위저드 `/zone-check/` | 백엔드 불필요, 프라이버시 보장 |
| **i18n** | 런타임 토글 (`<span lang="">` + CSS) | 최소 오버헤드, 빌드 스텝 없음 |
| **정보 구조** | 문제 중심 ("~할 때") | 크리에이터가 생각하는 방식에 맞춤 |

---

## 3. 정보 아키텍처: 서비스 중심이 아닌 문제 중심

컨설팅 펌 웹사이트 연구 결과, 가장 강력한 사이트는 **내부 서비스 분류**가 아니라 **클라이언트의 문제**로 구성됨.

### 사이트맵 (방문자 여정)

```
HOME
  "AI 콘텐츠 크리에이터로 수익을 올리고 계신가요?"
  ├── [CTA] "내 Zone 체크하기" → /zone-check/
  └── [자세히] → /services/

SERVICES (개요)
  4가지 "순간"으로 구성:
  ├── "콘텐츠가 자산이 되려 할 때"         → /services/ip/
  ├── "개인이 기업이 되려 할 때"           → /services/entity/
  ├── "수익이 국경을 넘을 때"              → /services/international/
  └── "세무서에서 연락이 올 때"            → /services/tax/

ZONE CHECK (인터랙티브 진단)
  5-7 단계 위저드 → 개인화된 결과 → 연락 CTA

PARTNERS
  전문 분야별 신뢰 파트너 네트워크

DOCS
  교육용 가이드 (전문성 확립, SEO 가치)

CARD
  공유 가능한 디지털 명함
```

### 서비스 상세 페이지 템플릿

McKinsey 및 부티크 펌의 프랙티스 페이지 구조:

1. **문제 진술** — 크리에이터의 언어로 1-2문장
2. **경고 신호** — 접힌 상태, 클릭 시 펼침 (Progressive Disclosure)
3. **Buckley가 하는 것** — 결과물이 아닌 프로세스
4. **결과** — 크리에이터가 얻는 것
5. **관련 가이드** — `/docs/` 링크
6. **CTA** — 연락 또는 Zone 체크

---

## 4. Zone Check 도구 — 핵심 인터랙티브 기능

### 아키텍처

- **파일:** `/zone-check/index.html`
- **엔진:** `/assets/js/zone-checker.js`
- **데이터:** `/data/triggers.json` + `/data/zones.json`

### 플로우 (6단계)

```
Step 1: "무엇을 만드시나요?"
  [ ] YouTube 영상
  [ ] 디지털 프로덕트
  [ ] AI 생성 콘텐츠
  [ ] 음악 / 아트
  [ ] 기타: ___

Step 2: "월 수익이 얼마인가요?"
  슬라이더: ₩0 — ₩100만 — ₩300만 — ₩500만 — ₩1000만+
  (₩300만 초과 → YELLOW 트리거)

Step 3: "수익이 어디서 오나요?"
  [ ] 국내 플랫폼만 (네이버, 쿠팡)
  [ ] YouTube AdSense (USD)
  [ ] Patreon / Gumroad / 해외
  [ ] 스폰서십 딜
  (비국내 = YELLOW 트리거)

Step 4: "누구와 함께 일하나요?"
  [ ] 혼자, 직원 없음
  [ ] 외주/프리랜서 있음
  [ ] 직원 있음
  (직원 >= 1 → YELLOW 트리거)

Step 5: "이런 생각을 해보셨나요?"
  [ ] IP를 개인 자산에서 분리
  [ ] 법인 설립
  [ ] 아니오
  (어느 하나 = YELLOW 트리거)

Step 6: 결과
  → 🟢 GREEN: "안전 영역입니다. 계속 만드세요."
     (팁, 가이드 링크)
  → 🟡 YELLOW: "전환 신호가 감지되었습니다."
     (어떤 트리거가 작동했는지, 관찰 사항, 연락 CTA)
  → 🔴 RED: "지금 전문 가이던스가 필요합니다."
     (긴급 CTA, 다이렉트 이메일/스케줄링)
```

### 핵심 엔진 로직

```javascript
// zone-checker.js
function evaluateZone(answers) {
  const triggers = [];
  if (answers.monthlyRevenue > 3000000) triggers.push('revenue');
  if (answers.foreignPayment) triggers.push('foreign');
  if (answers.employees >= 1) triggers.push('employees');
  if (answers.ipSeparation) triggers.push('ip');
  if (answers.entityInquiry) triggers.push('entity');

  if (triggers.length === 0) return { zone: 'GREEN', triggers };
  if (triggers.includes('ip') && triggers.includes('entity'))
    return { zone: 'RED', triggers };
  return { zone: 'YELLOW', triggers };
}
```

### UX 패턴 적용

- **Progressive Disclosure:** 각 단계에 질문 하나만 표시 ([NNGroup](https://www.nngroup.com/articles/progressive-disclosure/))
- **Progress Bar:** 상단 시각적 진행 표시 (Step 3 of 6)
- **뒤로/앞으로 네비게이션:** 이전 답변 수정 가능
- **브라우저 밖으로 데이터 안 나감:** 프라이버시 메시지 명시
- **결과 전 요약:** Zone 공개 전 모든 답변 확인
- **애니메이션 결과:** 기존 디자인 시스템의 신호등 애니메이션 활용

---

## 5. 디자인 시스템 추출

### tokens.css — 디자인 토큰

```css
:root {
  /* Colors */
  --bg: #0a0f14;
  --bg-elevated: #0f161d;
  --bg-card: #141c26;
  --gold: #c9a227;
  --gold-light: #e8c547;
  --gold-pale: #f4e4a6;
  --gold-dim: rgba(201,162,39,.08);
  --gold-glow: rgba(201,162,39,.15);
  --green: #22c55e;
  --yellow: #eab308;
  --red: #ef4444;
  --text: #f8fafc;
  --text-secondary: rgba(248,250,252,.7);
  --text-muted: rgba(248,250,252,.45);
  --text-dim: rgba(248,250,252,.25);
  --border: rgba(248,250,252,.08);
  --border-gold: rgba(201,162,39,.25);

  /* Spacing */
  --space-xs: 4px;
  --space-sm: 8px;
  --space-md: 16px;
  --space-lg: 24px;
  --space-xl: 40px;
  --space-2xl: 64px;

  /* Radii */
  --radius-sm: 8px;
  --radius-md: 14px;
  --radius-lg: 20px;
  --radius-xl: 28px;
  --radius-full: 9999px;

  /* Typography */
  --font-display: 'Cinzel', serif;
  --font-accent: 'Cormorant Garamond', Georgia, serif;
  --font-body: 'Inter', 'Noto Sans KR', -apple-system, sans-serif;

  /* Shadows */
  --shadow-lg: 0 20px 60px rgba(0,0,0,.6);
  --shadow-gold: 0 8px 50px rgba(201,162,39,.15);
}
```

### 다크 럭셔리 가이드라인

- 골드 악센트는 절제 — CTA, 보더, 헤딩에만. 큰 면적 골드 배경 금지
- 페이지당 최대 2개 골드 폰트 웨이트 (디스플레이 헤딩 + 악센트 라벨)
- 본문은 화이트/라이트. 골드는 인터랙티브와 브랜드 요소에만
- 노이즈 텍스처 오버레이 (기존 SVG 필터) 매우 낮은 불투명도 (0.01-0.02)
- 호버: border-color → gold 트랜지션, 미묘한 translateY(-2px) 리프트

---

## 6. 이중 언어 (한국어 + 영어) 아키텍처

### 권장: 런타임 i18n (빌드 스텝 없음)

```html
<!-- 예시 -->
<h2 data-i18n="services.entity.title">
  <span lang="ko">개인이 기업이 되려 할 때</span>
  <span lang="en">When You Become a Company</span>
</h2>
```

```css
/* 언어 토글 (body 클래스) */
body.lang-ko [lang="en"] { display: none; }
body.lang-en [lang="ko"] { display: none; }
```

- UI 문자열: `/data/i18n/ko.json`, `/data/i18n/en.json`
- `i18n.js`: `localStorage` 선호도 읽기, JSON fetch, `data-i18n` 속성에 적용
- 언어 토글: `한국어 | English` (각 라벨을 해당 언어로 표기)
- `<html lang="">` 속성 동적 업데이트

---

## 7. 네비게이션 패턴

### 공유 네비게이션

```
┌─────────────────────────────────────────────┐
│  BC   BUCKLEY CHANG        한국어 | English  │
│  ─── Home  Services  Zone Check  Contact ── │
└─────────────────────────────────────────────┘
```

- **모바일:** 햄버거 메뉴, 풀스크린 오버레이 (다크 배경, 골드 링크)
- **데스크톱 (>768px):** 수평 네비바, 스크롤 시 상단 고정
- **현재 페이지:** 골드 언더라인 하이라이트

### 공유 푸터

```
┌─────────────────────────────────────────────┐
│  [신호등: green yellow red]                  │
│  2026 BUCKLEY CHANG · PARKSY WORLD          │
│  buckleychang.com · buckley@parksy.world     │
│  [지문 아이콘 → Staff Portal]                │
└─────────────────────────────────────────────┘
```

---

## 8. JSON 기반 콘텐츠 패턴

### services.json 예시

```json
{
  "services": [
    {
      "id": "entity",
      "icon": "building",
      "title": {
        "ko": "개인이 기업이 되려 할 때",
        "en": "When You Become a Company"
      },
      "subtitle": {
        "ko": "사업자 전환 · 법인 설립 · 지분 구조",
        "en": "Entity Transition · Incorporation · Equity Structure"
      },
      "url": "/services/entity/",
      "zone": "yellow"
    }
  ]
}
```

### 렌더링 패턴

```javascript
fetch('/data/services.json')
  .then(r => r.json())
  .then(data => {
    const lang = document.body.classList.contains('lang-en') ? 'en' : 'ko';
    const container = document.getElementById('service-list');
    data.services.forEach(s => {
      container.innerHTML += `
        <a href="${s.url}" class="service-item">
          <div class="service-spine"></div>
          <div class="service-content">
            <div class="service-title">${s.title[lang]}</div>
            <div class="service-meta">${s.subtitle[lang]}</div>
          </div>
        </a>`;
    });
  });
```

---

## 9. 파트너 네트워크 표시

### 구조

```
/partners/index.html

┌─────────────────────────────────────┐
│  PARTNER NETWORK                    │
│  "전문 분야별 신뢰 파트너"            │
│                                      │
│  ┌─────────┐ ┌─────────┐           │
│  │ 세무     │ │ 법무     │           │
│  │ Tax      │ │ Legal    │           │
│  └─────────┘ └─────────┘           │
│  ┌─────────┐ ┌─────────┐           │
│  │ 특허/IP  │ │ 국제     │           │
│  │ Patent   │ │ Int'l    │           │
│  └─────────┘ └─────────┘           │
│                                      │
│  [각 카드 클릭 → 상세 아코디언]       │
└─────────────────────────────────────┘
```

데이터 소스: `/data/partners.json` (런타임 로드, 클릭 시 상세 표시)

---

## 10. 구현 우선순위

| 순서 | 작업 | 이유 |
|------|------|------|
| **Phase 1** | CSS 추출 + 공유 네비/푸터 | 멀티페이지 기반 구축 |
| **Phase 2** | index.html → 서비스 포털 랜딩 재설계 | 방문자 첫 경험 |
| **Phase 3** | Zone Check 인터랙티브 도구 | 킬러 피쳐, 리드 제너레이션 |
| **Phase 4** | 서비스 상세 페이지 4개 | 깊이 있는 정보 |
| **Phase 5** | 파트너 네트워크 페이지 | Hub-and-Spoke 가시화 |
| **Phase 6** | 이중 언어 + 가이드 문서 | 글로벌 확장, SEO |

---

*Sources:*
- [NNGroup — Wizards](https://www.nngroup.com/articles/wizards/)
- [NNGroup — Progressive Disclosure](https://www.nngroup.com/articles/progressive-disclosure/)
- [NNGroup — Language Switching](https://www.nngroup.com/articles/language-switching-ecommerce/)
- [PatternFly — Wizard Guidelines](https://www.patternfly.org/components/wizard/design-guidelines/)
- [Consulting Success — Client-Generating Website](https://www.consultingsuccess.com/consulting-website)
- [Melisa Liberman — Consulting Website Examples](https://www.melisaliberman.com/blog/consulting-website-examples)
- [SimpleLocalize — Language Selector](https://simplelocalize.io/blog/posts/ui-design-language-selector-examples/)
- [99designs — Luxury Website Inspiration](https://99designs.com/inspiration/websites/luxury)
- [CXL — Website Information Architecture](https://cxl.com/blog/website-information-architecture-optimal-user-experience/)
