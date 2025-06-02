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
- `history`, `tail` 명령어를 통해 사용자가 최근에 사용했던 명령어 20개를 추출
- `user_commands.txt` 파일에 저장

### [2] 인기 명령어 추출
- `sort`, `uniq`, `head` 명령어를 통해 `user_commands.txt` 파일에서 가장 많이 사용한 상위 5개 명령어 분석
- `popular_commands.txt` 파일에 저장

### [3] 현재 로그인 사용자 보기
- `who` 명령어를 사용하여 현재 로그인한 사용자 목록 출력
- `logged_users.txt` 파일에 저장

### [4] 시스템 상태 확인
- `uptime` 명령어로 시스템 부하 평균 확인
- `system_status.txt` 파일에 저장

### [5] 상위 5개 프로세스 보기
- `prstat` 명령어를 이용하여 CPU 사용률 기준 상위 5개 프로세스 표시
- `top_processes.txt` 파일에 저장

### [6] 종료
- 프로그램 종료