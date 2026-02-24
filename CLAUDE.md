# BUCKLEY CHANG 에이전트 프로토콜 v3.0

---

## 헌법 제1조: 레포지토리는 소설이다

> **모든 레포지토리는 한 권의 소설책이다.**
> **커밋이 문장이고, 브랜치가 챕터이고, git log --reverse가 줄거리다.**

- 삽질, 실패, 방향 전환 전부 남긴다. squash로 뭉개지 않는다.
- 기능 구현 과정 = 플롯 (문제→시도→실패→전환→해결)
- 레포 서사 → 블로그/웹툰/방송 콘텐츠로 파생 (액자 구성)

### 서사 추출 명령

```bash
narrative-extract.py --repo .                    # 이 레포 줄거리
narrative-extract.py --repo . --format synopsis  # 시놉시스
narrative-extract.py --repo . --format blog      # 블로그 원고
narrative-extract.py --repo . --climax           # 전환점만
narrative-extract.py --all ~                     # 28개 레포 연작 인덱스
```

### 서사 분류

| 커밋 유형 | 서사 | 의미 |
|-----------|------|------|
| `feat:` / 기능 추가 | 시도 | 주인공이 무언가를 만든다 |
| `fix:` / 버그 수정 | 삽질 | 예상대로 안 됐다 |
| `migration` / 전환 | 전환 | 버리고 다른 길을 간다 |
| `rewrite` / v2 | 각성 | 처음부터 제대로 다시 한다 |
| `refactor:` | 성장 | 같은 일을 더 잘하게 됐다 |
| `docs:` | 정리 | 지나온 길을 돌아본다 |

---


> 이 문서는 Claude Code가 buckleychang.com 레포지토리에서 작업할 때 따라야 하는 헌법입니다.

---

## 1. Branch Identity (2-Axis System)

| 축 | 값 | 설명 |
|----|-----|------|
| **Governance** | `collaborator` | HQ와 강하게 연동 (독립 후보) |
| **Cognitive** | `builder` | 시스템 중심. AI는 동료. 출력=도구/OS/파이프라인 |

### HQ Access 권한
```
✅ templates    - 페이지/컴포넌트 템플릿
✅ sync         - HQ 동기화 시스템
✅ claude-code  - Claude Code 에이전트 접근
✅ sdk          - dtslib-bridge SDK
❌ broadcast    - (Builder 특화 - 방송 불필요)
```

### 캐릭터 프로필
- **본성**: 자동화 중독자, 사무 OS 파트너
- **강점**: 유튜브 X, 시스템 구축에 올인
- **전략**: 독립(Independent) 후보. 자체 OS 구축 중.

---

## 2. 역할 정의

Buckley Chang은 **Parksy World의 Reality Interface**입니다.

### 하는 것:
- 개인 → 기업 전환(Transition) 판단
- 세금/법인/법무 리스크 분류
- Entity Status 검토 (개인/사업자/법인)
- 수익 유형 분류 (국내/해외/로열티)
- 자산 상태 판단 (취미/자산/매각대상)
- Partner Network 라우팅

### 하지 않는 것:
- 창작 (콘텐츠, 디자인)
- 크리에이터 육성
- 콘텐츠 방향 개입
- 투자 조언

---

## 3. HQ 연동

| 항목 | 값 |
|------|-----|
| **본사 레포** | dtslib1979/dtslib-branch |
| **브랜치 ID** | buckley |
| **상태** | active |
| **공개** | public |
| **커스텀 도메인** | buckleychang.com |
| **레지스트리** | `hq/registry/branches.json` |

### 독립 경로
```
현재: Collaborator (HQ 연동)
   ↓
목표: Independent (자체 OS 보유)
   - 자체 프로토콜 완성 시
   - 클라이언트 시스템 안정화 시
```

---

## 4. 폴더 구조

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
├── partners/               # 파트너 네트워크 페이지
├── card/                   # 명함 페이지
│
├── tools/                  # Builder 도구
│   ├── automation/         # 자동화 스크립트
│   └── zone-checker/       # Zone 판단 도구
│
└── staff/                  # 내부 도구
```

---

## 5. Traffic Signal Protocol

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

## 6. Builder 타입 작업 가이드

### 핵심 원칙
> "시스템이 판단한다. 인간은 승인한다."

### AI 활용 방식 (AI = 동료)
- Claude Code로 자동화 구축
- Zone 판단 로직 구현
- 클라이언트 데이터 처리 파이프라인
- 리포트 자동 생성

### 권장 작업
- Traffic Signal 자동화
- 클라이언트 상태 모니터링
- Partner Network 라우팅 자동화
- 문서 자동 생성

---

## 7. 커밋 컨벤션

```
feat: 새 기능
fix: 버그 수정
docs: 문서 업데이트
protocol: 프로토콜 변경
client: 클라이언트 관련
partner: 파트너 관련
tool: 도구/자동화
zone: Zone 로직 관련
```

커밋 메시지 끝:
```
Co-Authored-By: Claude Opus 4.5 <noreply@anthropic.com>
```

---

## 8. 작업 시 주의사항

1. 클라이언트 데이터는 절대 공개 커밋 금지
2. 세금/법률 조언은 면책 문구 필수
3. Partner 정보는 승인 후에만 공개
4. Zone 판단 로직 변경 시 반드시 기록
5. **Builder 특권**: 자동화 적극 구축, 독립 준비

---

*Version: 3.0*
*Last Updated: 2026-01-26*
*Affiliation: DTSLIB HQ (Collaborator → Independent 후보)*