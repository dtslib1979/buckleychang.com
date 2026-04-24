/**
 * Buckley Chang · Traffic Signal Protocol Engine
 *
 * 입력: triggers 객체 (monthly_revenue, foreign_payment, employees, ip_separation, entity_inquiry, exit_in_sight)
 * 출력: { zone: 'green'|'yellow'|'red', hits: [...], spokes: [...] }
 *
 * 판정 로직 (우선순위):
 *   1. exit_in_sight = true     → RED 즉시
 *   2. 임계값 RED 1개 이상       → RED
 *   3. YELLOW 트리거 1개 이상    → YELLOW
 *   4. 아무것도 해당 없음         → GREEN
 */

let ZONES = null;
let SPOKES = null;

async function loadData() {
  if (ZONES && SPOKES) return;
  const [zRes, sRes] = await Promise.all([
    fetch('/data/zones.json'),
    fetch('/data/spokes.json'),
  ]);
  ZONES = await zRes.json();
  SPOKES = await sRes.json();
}

export async function getZoneData() {
  await loadData();
  return { zones: ZONES, spokes: SPOKES };
}

/**
 * 실제 판정 함수.
 * @param {Object} input  예: { monthly_revenue: 5000000, foreign_payment: 2, employees: 1, ip_separation: false, entity_inquiry: false, exit_in_sight: false }
 */
export async function evaluate(input = {}) {
  await loadData();
  const triggers = ZONES.triggers;
  const hits = [];
  let zone = 'green';

  for (const trig of triggers) {
    const val = input[trig.id] ?? trig.default;

    // RED 판정
    let hitRed = false, hitYellow = false;
    if (trig.type === 'number') {
      if (trig.threshold_red !== undefined && val >= trig.threshold_red) hitRed = true;
      else if (trig.threshold_yellow !== undefined && val >= trig.threshold_yellow) hitYellow = true;
    } else if (trig.type === 'boolean') {
      if (trig.threshold_red === true  && val === true) hitRed = true;
      if (trig.threshold_yellow === true && val === true) hitYellow = true;
    }

    if (hitRed) {
      zone = 'red';
      hits.push({ trigger: trig, level: 'red', value: val });
    } else if (hitYellow && zone !== 'red') {
      zone = 'yellow';
      hits.push({ trigger: trig, level: 'yellow', value: val });
    }
  }

  const zoneData = ZONES.zones[zone];
  const spokeIds = zoneData.recommended_spokes || [];
  const spokes = spokeIds
    .map(id => SPOKES.spokes.find(s => s.id === id))
    .filter(Boolean);

  return { zone, zoneData, hits, spokes };
}

export function formatKRW(n) {
  if (n >= 100000000) return `₩${(n/100000000).toFixed(1)}억`;
  if (n >= 10000) return `₩${(n/10000).toFixed(0)}만`;
  return `₩${n.toLocaleString('ko-KR')}`;
}
