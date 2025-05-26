#!/bin/bash

# 색상 정의
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# 메인 메뉴 출력 함수
show_menu() {
    clear
    echo -e "${BLUE}======================================${NC}"
    echo -e "${BLUE}   사용자 로그 기록 및 요약 시스템   ${NC}"
    echo -e "${BLUE}======================================${NC}"
    echo ""
    echo -e "${GREEN}[1] 사용자 명령어 기록 저장${NC}"
    echo -e "${GREEN}[2] 인기 명령어 추출${NC}"
    echo -e "${GREEN}[3] 현재 로그인 사용자 보기${NC}"
    echo -e "${GREEN}[4] 시스템 상태 확인${NC}"
    echo -e "${GREEN}[5] 상위 5개 프로세스 보기 (보너스)${NC}"
    echo -e "${RED}[6] 종료${NC}"
    echo ""
    echo -n "선택하세요 (1-6): "
}

# 1. 사용자 명령어 기록 수집 함수
save_user_commands() {
    echo -e "${YELLOW}사용자 명령어 기록을 수집하는 중...${NC}"
    
    # bash_history 파일 경로 확인
    if [ -f ~/.bash_history ]; then
        HISTORY_FILE=~/.bash_history
    else
        echo -e "${RED}히스토리 파일을 찾을 수 없습니다.${NC}"
        echo "현재 세션의 history 명령어를 사용합니다..."
        history | tail -20 | cut -c 8- > user_commands.txt
        echo -e "${GREEN}user_commands.txt 파일이 생성되었습니다.${NC}"
        return
    fi
    
    # 최근 20줄 명령어 저장
    tail -20 "$HISTORY_FILE" > user_commands.txt
    
    echo -e "${GREEN}최근 20개 명령어가 user_commands.txt에 저장되었습니다.${NC}"
}

# 2. 인기 명령어 추출 함수
extract_popular_commands() {
    echo -e "${YELLOW}인기 명령어를 추출하는 중...${NC}"
    
    if [ ! -f user_commands.txt ]; then
        echo -e "${RED}user_commands.txt 파일이 없습니다. 먼저 명령어 기록을 저장해주세요.${NC}"
        return
    fi
    
    # 명령어의 첫 번째 단어만 추출하여 인기도 계산
    awk '{print $1}' user_commands.txt | sort | uniq -c | sort -nr | head -5 > popular_commands.txt
    
    echo -e "${GREEN}상위 5개 인기 명령어가 popular_commands.txt에 저장되었습니다.${NC}"
}

# 3. 현재 로그인한 사용자 정보 출력 함수
show_logged_users() {
    echo -e "${YELLOW}현재 로그인한 사용자 정보를 수집하는 중...${NC}"
    
    # 현재 로그인한 사용자 정보 저장
    who > logged_users.txt
    
    echo -e "${GREEN}로그인 사용자 정보가 logged_users.txt에 저장되었습니다.${NC}"
}

# 4. 시스템 부하 요약 함수
check_system_status() {
    echo -e "${YELLOW}시스템 상태를 확인하는 중...${NC}"
    
    # 시스템 상태 정보 수집
    {
        echo "=== 시스템 부하 평균(Load Average) ==="
        uptime
        echo ""
    } > system_status.txt
    
    echo -e "${GREEN}시스템 상태가 system_status.txt에 저장되었습니다.${NC}"
}

# 5. 보너스: 상위 5개 프로세스 보기 함수
show_top_processes() {
    echo -e "${YELLOW}상위 5개 프로세스를 확인하는 중...${NC}"
    
    # CPU 사용률 기준 상위 5개 프로세스
    {
        echo "=== 상위 5개 프로세스 (CPU 사용률 기준) ==="
        echo "생성 시간: $(date)"
        echo ""
        ps aux | head -1  # 헤더
        ps aux | tail -n +2 | sort -k3 -nr | head -5
    } > top_processes.txt
    
    echo -e "${GREEN}상위 5개 프로세스 정보가 top_processes.txt에 저장되었습니다.${NC}"
}

# 도움말 표시 함수
show_help() {
    echo -e "${BLUE}======================================${NC}"
    echo -e "${BLUE}   사용자 로그 기록 및 요약 시스템   ${NC}"
    echo -e "${BLUE}======================================${NC}"
    echo ""
    echo -e "${GREEN}사용법:${NC}"
    echo "  $0                    - 대화형 메뉴 실행"
    echo "  $0 [옵션]             - 특정 기능 직접 실행"
    echo ""
    echo -e "${GREEN}옵션 (짧은 형태/긴 형태):${NC}"
    echo "  -c, --commands        - 사용자 명령어 기록 저장"
    echo "  -p, --popular         - 인기 명령어 추출"
    echo "  -u, --users           - 현재 로그인 사용자 보기"
    echo "  -s, --status          - 시스템 상태 확인"
    echo "  -t, --top             - 상위 5개 프로세스 보기"
    echo "  -h, --help            - 이 도움말 표시"
    echo ""
}

# 명령행 인자 처리 함수
handle_command_line_args() {
    case $1 in
        # 옵션 형태 (-c, --commands 등)
        "-c"|"--commands"|"commands")
            clear
            save_user_commands
            ;;
        "-p"|"--popular"|"popular")
            clear
            extract_popular_commands
            ;;
        "-u"|"--users"|"users")
            clear
            show_logged_users
            ;;
        "-s"|"--status"|"status")
            clear
            check_system_status
            ;;
        "-t"|"--top"|"processes")
            clear
            show_top_processes
            ;;
        "-h"|"--help"|"help")
            show_help
            ;;
        *)
            echo -e "${RED}알 수 없는 인자입니다: $1${NC}"
            echo ""
            show_help
            exit 1
            ;;
    esac
}

# 메인 루프
main() {
    while true; do
        show_menu
        read choice
        
        case $choice in
            1)
                clear
                save_user_commands
                echo ""
                echo -n "계속하려면 Enter를 누르세요..."
                read
                ;;
            2)
                clear
                extract_popular_commands
                echo ""
                echo -n "계속하려면 Enter를 누르세요..."
                read
                ;;
            3)
                clear
                show_logged_users
                echo ""
                echo -n "계속하려면 Enter를 누르세요..."
                read
                ;;
            4)
                clear
                check_system_status
                echo ""
                echo -n "계속하려면 Enter를 누르세요..."
                read
                ;;
            5)
                clear
                show_top_processes
                echo ""
                echo -n "계속하려면 Enter를 누르세요..."
                read
                ;;
            6)
                clear
                exit 0
                ;;
            *)
                echo -e "${RED}잘못된 선택입니다. 1-6 사이의 숫자를 입력해주세요.${NC}"
                ;;
        esac
    done
}

# 스크립트 실행 권한 확인
if [ ! -x "$0" ]; then
    echo -e "${YELLOW}스크립트에 실행 권한을 부여하는 중...${NC}"
    chmod +x "$0"
fi

# 명령행 인자가 있는 경우 처리
if [ $# -gt 0 ]; then
    handle_command_line_args "$1"
    exit 0
fi

# 메인 함수 실행
main
