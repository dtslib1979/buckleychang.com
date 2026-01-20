# BUCKLEY CHANG 에이전트 프로토콜

> 이 문서는 Claude Code가 buckleychang.com 레포지토리에서 작업할 때 따라야 하는 헌법입니다.

---

## 1. 역할 정의

Buckley Chang은 **Parksy World의 Reality Interface**입니다.

### 하는 것:
- 개인 → 기업 전환(Transition) 판단
- 세금/법인/법무 리스크 분류
- Entity Status 검토 (개인/사업자/법인)
- 수익 유형 분류 (국내/해외/로열티)
- 자산 상태 판단 (취미/자산/매각대상)
- Partner Network 라우팅

### 하지 않는 것:
- 창작 (콘텐츠, 디자인, 코드)
- 크리에이터 육성
- 콘텐츠 방향 개입
- 투자 조언

---

## 2. HQ 연동

| 항목 | 값 |
|------|-----|
| **본사 레포** | dtslib1979/dtslib-branch |
| **브랜치 ID** | buckleychang |
| **상태** | active |
| **공개** | public |
| **커스텀 도메인** | buckleychang.com |

---

## 3. 폴더 구조

```
buckleychang.com/
├── index.html              # 메인 랜딩
├── CLAUDE.md               # 이 문서
├── CNAME                   # 커스텀 도메인
├── config.json             # 설정
├── robots.txt
├── sitemap.xml
│
├── assets/
│   ├── icons/              # 로고, 파비콘, OG 이미지
│   ├── css/                # 스타일시트
│   └── manifest.json       # PWA 설정
│
├── data/
│   ├── clients/            # 클라이언트 데이터 (비공개)
│   └── protocols/          # 프로토콜 정의
│       ├── triggers.json   # Yellow Zone 트리거 임계값
│       ├── zones.json      # GREEN/YELLOW/RED 정의
│       └── partners.json   # 파트너 네트워크
│
├── services/               # 서비스 페이지
│   ├── entity/             # Entity 전환 서비스
│   ├── tax/                # 세무 서비스
│   └── legal/              # 법무 서비스
│
├── docs/                   # 문서/가이드
│   ├── transition.md       # 전환 가이드
│   └── checklist.md        # 체크리스트
│
├── partners/               # 파트너 네트워크 페이지
├── card/                   # 명함 페이지
└── staff/                  # 내부 도구
    └── tools/
        └── zone-checker.html
```

---

## 4. Traffic Signal Protocol

### Zone 정의

| Zone | 조건 | Buckley 역할 |
|------|------|--------------|
| 🟢 GREEN | 개인 크리에이터, 초기 수익, 국내 플랫폼 | 관여 안 함 |
| 🟡 YELLOW | Trigger 1개 이상 충족 | 자동 호출, 리포트 검토 |
| 🔴 RED | 법인/지분/IP분리/매각 | 전권 통제 — Command |

### Trigger Thresholds (Yellow Zone 진입)

| Trigger | 임계값 |
|---------|--------|
| 월 수익 | ₩3,000,000 초과 |
| 해외 결제 | 최초 1건 |
| 인력 고용 | 1명 이상 |
| IP 분리 요청 | 명시적 언급 |
| 법인 문의 | "법인 만들까요?" 발화 |

---

## 5. Conflict Resolution

복수 Trigger 발생 시 우선순위:

| 순위 | 리스크 유형 |
|------|-------------|
| 1 | 세금 리스크 (Tax) |
| 2 | 법적 리스크 (Legal) |
| 3 | 운영 리스크 (Operational) |

> **원칙: 세금 먼저, 법 다음, 운영은 마지막**

---

## 6. Black Box Operation

### 입력
- AI가 준비: 장부, 초안, 요약 리포트

### Buckley 화면
- `[승인]`
- `[반려 — 위험]`
- `[보류 — 자료 부족]`

### 출력
승인 시 **Digital Seal** 발급:
> *Verified by Buckley Chang, CPA*

---

## 7. Partner Network

| 영역 | 파트너 유형 | Buckley 역할 |
|------|-------------|--------------|
| 특허/상표 | 특허법인 | 의뢰서 작성, 타이밍 판단 |
| 소송/분쟁 | 법무법인 | 리스크 분류, 증거 정리 |
| 해외 법인 | 현지 파트너 (SG, US) | 구조 설계, 브릿지 |
| 세무 조사 | 세무법인 | 사전 대비, 자료 정리 |

---

## 8. 커밋 컨벤션

```
feat: 새 기능
fix: 버그 수정
docs: 문서 업데이트
protocol: 프로토콜 변경
client: 클라이언트 관련
partner: 파트너 관련
```

---

## 9. 작업 시 주의사항

1. 클라이언트 데이터는 절대 공개 커밋 금지
2. 세금/법률 조언은 면책 문구 필수
3. Partner 정보는 승인 후에만 공개
4. Zone 판단 로직 변경 시 반드시 기록

---

*Document Version 1.0*
*2026-01-20*
*Parksy World*
