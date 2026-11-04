# Codex Contest Agent Kit

제한 시간 안에 **README 명세를 분석하고 웹 애플리케이션을 구현·검증**하기 위한 Codex 멀티 에이전트 스타터 킷입니다.

> Orchestrator는 메인 Codex가 담당하며, **Planner / Generator / Reviewer / QA** 네 역할을 서브에이전트로 분리합니다. 네 역할을 무조건 동시에 돌리지 않고, 작업 의존성에 따라 선택적으로 병렬화합니다.

## 가장 간단한 사용법: 프롬프트만 복사 (추천)

**대회 플랫폼 안에서 바로 개발할 때는 설치가 필요하지 않습니다.**

1. [START_CONTEST.md](prompts/START_CONTEST.md)를 엽니다.
2. 대회 프로젝트의 README가 열려 있는 AI 코딩 플랫폼에 **프롬프트 본문만** 복사해 붙여넣습니다.
3. 플랫폼이 멀티 에이전트를 지원하면 Planner / Generator / Reviewer / QA를 실제로 활용하고, 지원하지 않으면 역할별 절차를 단일 에이전트가 수행합니다.

이 방식은 `$contest-webapp` Skill이나 별도의 TOML 설정 설치를 요구하지 않습니다. **아래 설치 절차는 Codex 에이전트를 반복 사용하고 싶을 때만 선택적으로 활용하세요.**

## 1. 선택 사항: Codex 에이전트·Skill 설치 (macOS / Linux)

```bash
git clone https://github.com/77romin/agent-skills.git
cd agent-skills
bash scripts/install.sh
```

설치되는 파일:

- `agents/*.toml` → `~/.codex/agents/` (4개 서브에이전트 정의)
- `.agents/skills/contest-webapp/` → `~/.agents/skills/contest-webapp/` (Skill)

기존 파일이 다르면 **타임스탬프 백업 후** 교체합니다. `~/.codex/config.toml` 및 기존 전역 `AGENTS.md`는 변경하지 않습니다. 설치 후 Codex를 다시 시작하세요.

```bash
bash scripts/check-setup.sh
```

`codex`/서브에이전트 기능은 설치한 Codex 버전·환경에 따라 지원 여부가 다를 수 있습니다. 설치 스크립트는 Codex 실행 파일이나 권한 설정을 자동 설치·수정하지 않습니다.

## 2. 대회 시작할 때

1. **대회 프로젝트 폴더**에서 Codex를 시작하세요. (`agent-skills` 저장소가 아니라 문제의 README가 있는 폴더입니다.)
2. `prompts/START_CONTEST.md`의 본문을 복사해 Codex에 전달하세요. 또는 `$contest-webapp`을 명시적으로 호출해도 됩니다.
3. 남은 시간·제출 방법·필수 기술 스택이 있으면 처음 지시할 때 함께 제공하세요.
4. 초기에 Planner와 QA를 독립적으로 실행해 요구사항 추적표 및 테스트 기준을 수립합니다.
5. Generator가 **P0 핵심 사용자 흐름부터 수직 슬라이스**로 구현하고, Reviewer/QA가 독립 검증합니다.
6. 마지막에는 새 기능 추가를 멈추고 **실행·빌드·핵심 흐름·제출 조건**을 확인합니다.

대회 프로젝트에 규칙을 고정하려면 `templates/CONTEST_AGENTS.md` 내용을 **해당 프로젝트의** `AGENTS.md`로 복사하세요. 이미 파일이 있다면 덮어쓰지 말고 병합하세요. 이 저장소 자체에는 설치용 `AGENTS.md`를 강제로 넣지 않습니다.

## 3. 역할 및 소유권

| 역할 | 담당 | 앱 코드 수정 |
| --- | --- | --- |
| Orchestrator (메인 Codex) | 우선순위·위임·충돌 방지·통합·최종 판정 | 필요 시 |
| Planner | README 요구사항 ID, P0/P1/P2, 데이터/API 계약, 구현 순서 | 금지 |
| Generator | 기능 구현·테스트·오류 수정 | **전담** |
| Reviewer | 명세 미준수·동시성·보안·상태 전이·회귀 위험 분석 | 금지 |
| QA | 독립 테스트 설계·API/E2E·경계값/동시성 검증 | 앱 코드 금지 |

- **Planner + QA**: 서로의 분석을 복사하지 않고 README 원문을 각자 읽습니다.
- **Generator**: 초기 실행 가능한 앱을 먼저 만들고, 기능 단위로 테스트합니다.
- **Reviewer + QA**: 구현 결과를 병렬 검토할 수 있으나 애플리케이션 코드는 수정하지 않습니다.
- 검증 실패는 Generator에게 돌리고, 수정 후 관련 테스트를 다시 실행합니다.
- 추가 Generator나 Git Worktree는 **파일 소유권이 분리될 때만** 고려합니다.

## 4. tmux (선택)

```bash
# macOS: brew install tmux
bash /path/to/agent-skills/scripts/tmux-contest.sh /path/to/contest-project
```

`contest` 세션에 `codex`, `server`, `test` 창을 마련합니다. 각 창은 **빈 셸**이며 서버나 코드를 자동 실행하지 않습니다. tmux는 프로세스/로그 관리 도구이고, Codex 서브에이전트 오케스트레이션과는 별개입니다.

## 5. 파일 구성

```text
agent-skills/
├── README.md
├── agents/
│   ├── planner.toml
│   ├── generator.toml
│   ├── reviewer.toml
│   └── qa.toml
├── .agents/skills/contest-webapp/
│   ├── SKILL.md
│   └── references/edge-case-checklist.md
├── prompts/START_CONTEST.md
├── templates/CONTEST_AGENTS.md
└── scripts/
    ├── install.sh
    ├── check-setup.sh
    └── tmux-contest.sh
```

## 6. 설계 원칙

- **명세 우선**: README에 없는 기능을 그럴듯하게 만들어 점수를 잃지 않습니다.
- **실행으로 검증**: 테스트하지 않은 성공은 성공이 아닙니다. 실행 불가능한 테스트는 BLOCKED로 표시합니다.
- **과도한 병렬화 금지**: 동시 수정 충돌보다 한 기능의 끝까지 동작을 보장하는 편이 낫습니다.
- **안전한 설치**: 백업·명시적 설치·낮은 권한을 기본으로 합니다.
- **제출 우선**: 최종 검증/제출 시간을 따로 확보합니다.

## 참고

- [Codex 개발 문서](https://developers.openai.com/codex/)
- [Agent Skills 가이드](https://developers.openai.com/api/docs/guides/tools-skills)
- [Git worktree 문서](https://git-scm.com/docs/git-worktree)

이 저장소는 검증 절차와 설정 파일을 제공하는 **템플릿**입니다. 실제 대회 문제의 실행 명령·테스트·채점 기준은 README와 현장 환경에 맞춰 조정해야 합니다.
