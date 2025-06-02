#!/bin/bash
#
# Copyright © 2025 
#
# 사용자 로그 기록 및 요약 시스템
# 사용 방법은 README.md 를 참조하세요
#

RED='\033[0;31m'
BOLD='\033[1m'
BOLD_RED='\033[1;31m'
BOLD_BLUE='\033[1;36m'
BOLD_YELLOW='\033[1;33m'
RED_BG='\033[41m'
GREEN_BG='\033[42m'
NC='\033[0m'

show_menu() {
    clear
    echo ""
    echo ""
    echo -e "${BOLD_BLUE}***************************************${NC}"
    echo -e "${BOLD_BLUE}*   사용자 로그 기록 및 요약 시스템   *${NC}"
    echo -e "${BOLD_BLUE}***************************************${NC}"
    echo ""
    echo -e "${BOLD_YELLOW}[1] 사용자 명령어 기록 저장${NC}"
    echo -e "${BOLD_YELLOW}[2] 인기 명령어 추출${NC}"
    echo -e "${BOLD_YELLOW}[3] 현재 로그인 사용자 보기${NC}"
    echo -e "${BOLD_YELLOW}[4] 시스템 상태 확인${NC}"
    echo -e "${BOLD_YELLOW}[5] 상위 5개 프로세스 보기${NC}"
    echo -e "${BOLD_RED}[6] 종료${NC}"
    echo ""
    echo -e -n "${BOLD}메뉴 번호를 입력하세요: ${NC}"
}

user_commands() {
    {
        echo "*** 최근 20개 사용자 명령어 기록 ***"
        echo ""
        bash -i -c 'fc -ln -20'
    } > user_commands.txt
    echo -e "${GREEN_BG}${BOLD} 최근 20개 명령어가 user_commands.txt에 저장되었습니다. ${NC}"
}

popular_commands() {
    if [ ! -f user_commands.txt ]; then
        echo -e "${RED_BG}${BOLD}user_commands.txt 파일이 없습니다. 먼저 명령어 기록을 저장해주세요.${NC}"
        return
    fi
    {
        echo "*** 가장 많이 사용한 상위 5개 명령어 ***"
        echo ""
        sed '1d' user_commands.txt | nawk 'NF {print $1}' | sort | uniq -c | sort -nr | head -5
    } > popular_commands.txt

    echo -e "${GREEN_BG}${BOLD} 상위 5개 인기 명령어가 popular_commands.txt에 저장되었습니다. ${NC}"
}

logged_users() {
    {
        echo "*** 현재 로그인 사용자 정보 ***"
        echo ""
        who
    } > logged_users.txt

    echo -e "${GREEN_BG}${BOLD} 로그인 사용자 정보가 logged_users.txt에 저장되었습니다. ${NC}"
}

system_status() {
    {
        echo "*** 시스템 부하 평균 ***"
        echo ""
        uptime
    } > system_status.txt
    
    echo -e "${GREEN_BG}${BOLD} 시스템 상태가 system_status.txt에 저장되었습니다. ${NC}"
}

top_processes() {
    {
        echo "*** 상위 5개 프로세스 (CPU 사용률 기준) ***"
        echo ""
        prstat -s cpu -n 5 1 1
    } > top_processes.txt
    
    echo -e "${GREEN_BG}${BOLD} 상위 5개 프로세스 정보가 top_processes.txt에 저장되었습니다. ${NC}"
}

show_help() {
    echo -e "${BOLD_BLUE}***************************************${NC}"
    echo -e "${BOLD_BLUE}*   사용자 로그 기록 및 요약 시스템   *${NC}"
    echo -e "${BOLD_BLUE}***************************************${NC}"
    echo ""
    echo -e "${BOLD_YELLOW}사용법:${NC}"
    echo "  $0                    - GUI 실행"
    echo "  $0 [옵션]             - 터미널 직접 실행"
    echo ""
    echo -e "${BOLD_YELLOW}옵션:${NC}"
    echo "  -c, --commands        - 사용자 명령어 기록 저장"
    echo "  -p, --popular         - 인기 명령어 추출"
    echo "  -u, --users           - 현재 로그인 사용자 보기"
    echo "  -s, --status          - 시스템 상태 확인"
    echo "  -t, --top             - 상위 5개 프로세스 보기"
    echo "  -h, --help            - 이 도움말 표시"
    echo ""
}

run_options() {
    case $1 in
        "-c"|"--commands"|"commands")
            clear
            user_commands
            ;;
        "-p"|"--popular"|"popular")
            clear
            popular_commands
            ;;
        "-u"|"--users"|"users")
            clear
            logged_users
            ;;
        "-s"|"--status"|"status")
            clear
            system_status
            ;;
        "-t"|"--top"|"processes")
            clear
            top_processes
            ;;
        "-h"|"--help"|"help")
            show_help
            ;;
        *)
            echo -e "${RED}알 수 없는 옵션입니다: $1${NC}"
            echo ""
            show_help
            exit 1
            ;;
    esac
}

main() {
    while true; do
        show_menu
        read choice
        
        case $choice in
            1)
                clear
                user_commands
                echo ""
                echo -n "계속하려면 Enter를 누르세요..."
                read
                ;;
            2)
                clear
                popular_commands
                echo ""
                echo -n "계속하려면 Enter를 누르세요..."
                read
                ;;
            3)
                clear
                logged_users
                echo ""
                echo -n "계속하려면 Enter를 누르세요..."
                read
                ;;
            4)
                clear
                system_status
                echo ""
                echo -n "계속하려면 Enter를 누르세요..."
                read
                ;;
            5)
                clear
                top_processes
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

if [ $# -gt 0 ]; then
    run_options "$1"
    exit 0
fi

main
