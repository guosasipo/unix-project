# 사용자 로그 기록 및 요약 시스템

## 실행 방법

### 1. 스크립트 실행 권한 부여
```bash
chmod +x user_log_tool.sh
```

### 2. 스크립트 실행
```bash
./user_log_tool.sh
```

## 기능

### [1] 사용자 명령어 기록 저장
- 사용자의 `~/.bash_history` 또는 `~/.zsh_history` 파일에서 최근 20개 명령어를 추출
- `user_commands.txt` 파일에 저장
- 히스토리 파일이 없는 경우 현재 세션의 history 명령어 사용

### [2] 인기 명령어 추출
- 저장된 명령어에서 가장 많이 사용한 상위 5개 명령어 분석
- `sort`, `uniq`, `head` 등의 유닉스 명령어 활용
- `popular_commands.txt` 파일에 결과 저장

### [3] 현재 로그인 사용자 보기
- `who` 명령어를 사용하여 현재 로그인한 사용자 목록 출력
- `logged_users.txt` 파일에 저장
- 총 로그인 사용자 수도 함께 표시

### [4] 시스템 상태 확인
- `uptime` 명령어로 시스템 부하 평균(Load Average) 확인
- 메모리 사용률과 디스크 사용률 정보 포함
- `system_status.txt` 파일에 종합 보고서 저장

### [5] 상위 5개 프로세스 보기 (보너스 기능)
- `ps` 명령어를 이용하여 CPU 사용률 기준 상위 5개 프로세스 표시
- `top_processes.txt` 파일에 저장

### [6] 종료
- 프로그램 종료 전 모든 기능을 한 번에 실행할 수 있는 옵션 제공

## 생성되는 파일들

- `user_commands.txt`: 최근 사용한 20개 명령어
- `popular_commands.txt`: 인기 명령어 상위 5개
- `logged_users.txt`: 현재 로그인한 사용자 목록
- `system_status.txt`: 시스템 상태 종합 보고서
- `top_processes.txt`: CPU 사용률 상위 5개 프로세스
